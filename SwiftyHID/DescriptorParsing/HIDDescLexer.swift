//
//  HIDDescParser.swift
//  SwiftyHID
//
//  Created by James Linnell on 10/28/18.
//  Copyright © 2018 James Linnell. All rights reserved.
//

import Foundation

public class HIDDescLexer {
	private init() {

	}
	
	public static func parse(descriptorData: Data) throws -> [(HIDDescriptorItem, HIDDescData)] {
		var items: [(HIDDescriptorItem, HIDDescData)] = []
		var index = 0
		
		while index < descriptorData.count {
			let data = try HIDDescData.create(withDescriptorData: descriptorData, index: index)
			guard let parsedItem = HIDDescriptorItem(type: data.itemType, tag: data.itemTag, unsignedValue: data.unsignedValue, signedValue: data.signedValue) else {
				throw HIDDescriptorParserError.invalidItemWhileParsing(invalidData: data, parsedSoFar: items)
			}
			items.append((parsedItem, data))
			index += Int(data.byteCount) + 1
		}
		
		return items
	}
}
