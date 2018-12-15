//
//  Utils.swift
//  SwiftyHID
//
//  Created by James Linnell on 10/14/18.
//  Copyright © 2018 James Linnell. All rights reserved.
//

import Foundation

public class Utils {
	public static func createArray<T: Numeric>(pointer: UnsafePointer<T>, length: Int) -> Array<T> {
		var array = Array<T>(repeating: 0, count: length)
		for i in 0..<length {
			array[i] = pointer.advanced(by: i).pointee
		}
		return array
	}
	
	public static func getBit<T: BinaryInteger>(data: T, bitNumber: UInt) -> Bool {
		return (data & (1 << bitNumber)) > 0
	}
	
	public static func getNibble<T: BinaryInteger>(data: T, nibbleIndex: UInt) -> UInt8 {
		let shift = T(nibbleIndex * 4)
		return UInt8(truncatingIfNeeded: (data & (0xF << shift)) >> shift)
	}
}
