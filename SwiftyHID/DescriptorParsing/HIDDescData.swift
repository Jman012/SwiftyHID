//
//  HIDDescItem.swift
//  SwiftyHID
//
//  Created by James Linnell on 10/28/18.
//  Copyright © 2018 James Linnell. All rights reserved.
//

import Foundation

public struct HIDDescData {
	
	// MARK: Bit-wise constants
	
	private static let sizeMask: UInt8 = 0x03
	private static let tagMask: UInt8 = 0xF0
	private static let tagShift: UInt8 = 0x04
	private static let typeMask: UInt8 = 0x0C
	private static let typeShift: UInt8 = 0x02
	private static let longItemHeader: UInt8 = 0xFE
	
	// MARK: Member properties
	
	public let header: UInt8
	public let byteCount: UInt8
	public let itemType: UInt8
	public let itemTag: UInt8
	public let signedValue: Int32
	public let unsignedValue: UInt32
	public let bytes: Data
	
	public init(header: UInt8, bytecount: UInt8, itemType: UInt8, itemTag: UInt8, signedValue: Int32, unsignedValue: UInt32, bytes: Data) {
		self.header = header
		self.byteCount = bytecount
		self.itemType = itemType
		self.itemTag = itemTag
		self.signedValue = signedValue
		self.unsignedValue = unsignedValue
		self.bytes = bytes
	}
	
	public static func create(withDescriptorData descriptorData: Data, index origIndex: Int) throws -> HIDDescData {
		var index = origIndex
		
		// Don't go past our data
		if index >= descriptorData.count {
			throw HIDDescError.unexpectedEndOfData
		}
		
		// Get header byte, which contains the type and the tag in the bit
		let header: UInt8 = descriptorData[index]
		index += 1
		
		// Don't go past our data
		if index > descriptorData.count {
			throw HIDDescError.unexpectedEndOfData
		}
		
		// Type is simple to parse
		let itemType: UInt8 = HIDDescData.getItemType(header)
		
		// Set the Tag, which is complicated
		var byteCount: UInt8 = 0
		var itemTag: UInt8 = 0
		if header == HIDDescData.longItemHeader {
			// The header is the long item header. 'Skip long items!'.
			byteCount = descriptorData[index]
			index += 1
			
			if index >= descriptorData.count {
				throw HIDDescError.unexpectedEndOfData
			}
			
			itemTag = descriptorData[index]
			index += 1
			
			if index >= descriptorData.count {
				throw HIDDescError.unexpectedEndOfData
			}
		} else {
			// Short Item Header
			byteCount = HIDDescData.getItemSize(header)
			itemTag = HIDDescData.getItemTag(header)
		}
		var bytes = Data(count: Int(byteCount))
		
		if (index + Int(byteCount)) > descriptorData.count {
			throw HIDDescError.unexpectedEndOfData
		}
		
		// Get the bytes into our signed/unsigned values
		// Easily handle edge case of no data bytes
		var unsignedValue: UInt32 = 0
		if byteCount == 0 {
			return HIDDescData(header: header, bytecount: byteCount, itemType: itemType, itemTag: itemTag, signedValue: 0, unsignedValue: 0, bytes: bytes)
		}
		// Normal case for gathering bytes
		var signedValue: Int32 = 0
		if byteCount > 0 && byteCount <= 4 {
			
			var byte: UInt8 = 0
			var i = 0
			for _ in 0..<byteCount {
				byte = descriptorData[index]
				index += 1
				
				bytes[i] = byte
				
				unsignedValue |= UInt32(byte << (i*8))
				i += 1
			}
			
			signedValue = Int32(truncatingIfNeeded: unsignedValue)
			
			// Fix signed value
			// If the last byte had its highest bit on, then it's negated
			// and
			if byte & 0x80 != 0 {
				while i < 4 {
					signedValue |= (0xFF << (i * 8))
					i += 1
				}
			}
		}
		
		return HIDDescData(header: header, bytecount: byteCount, itemType: itemType, itemTag: itemTag, signedValue: signedValue, unsignedValue: unsignedValue, bytes: bytes)
	}
	
	private static func getItemType(_ byte: UInt8) -> UInt8 {
		return (byte & typeMask) >> typeShift
	}
	
	private static func getItemTag(_ byte: UInt8) -> UInt8 {
		return (byte & tagMask) >> tagShift
	}
	
	private static func getItemSize(_ byte: UInt8) -> UInt8 {
		var size = byte & sizeMask
		if size == 3 {
			// 0 = 0 bytes, 1 = 1 byte, 2 = 2 bytes, 3 = 4 bytes
			size = 4
		}
		return size
	}
}
