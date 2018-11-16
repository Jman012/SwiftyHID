//
//  HIDDescValidator.swift
//  SwiftyHID
//
//  Created by James Linnell on 10/28/18.
//  Copyright © 2018 James Linnell. All rights reserved.
//

import Foundation

public class HIDDescValidator {
	public static func validate(descriptorData: [HIDDescData]) -> HIDDescriptorParserError? {
		
		// These should end at 0, and never go negative
		var collectionNesting = 0
		var globalPushPopBalance = 0
		
		// These need to be at least 1
		var reportItemCount = 0
		
		// These need to be even
		var usageRanges = 0
		var stringRanges = 0
		var designatorRanges = 0
		
		for data in descriptorData {
			let itemOpt = HIDDescriptorItem(type: data.itemType, tag: data.itemTag, unsignedValue: data.unsignedValue, signedValue: data.signedValue)
			
			guard let item = itemOpt else {
				return .unknownTypeOrTag(data)
			}
			
			switch item {
			case .main(let tag):
				switch tag {
				case .beginCollection:
					collectionNesting += 1
				case .endCollection:
					collectionNesting -= 1
					
					if collectionNesting < 0 {
						return .unbalancedCollectionTags
					}
				case .input, .output, .feature:
					reportItemCount += 1
				}
				
			case .global(let tag):
				switch tag {
				case .push:
					globalPushPopBalance += 1
				case .pop:
					globalPushPopBalance -= 1
					
					if globalPushPopBalance < 0 {
						return .unbalancedGlobalPushPop
					}
				default:
					break
				}
				
			case .local(let tag):
				switch tag {
				case .usageMinimum, .usageMaximum:
					usageRanges += 1
				case .stringMinimum, .stringMaximum:
					stringRanges += 1
				case .designatorMinimum, .designatorMaximum:
					designatorRanges += 1
				default:
					break
				}
				break
				
			}
		}
		
		if collectionNesting != 0 {
			return .unbalancedCollectionTags
		}
		if globalPushPopBalance != 0 {
			return .unbalancedGlobalPushPop
		}
		
		if reportItemCount == 0 {
			return .noReportItems
		}
		
		if usageRanges % 2 != 0 {
			return .unevenUsageBoundaries
		}
		if stringRanges % 2 != 0 {
			return .unevenStringBoundaries
		}
		if designatorRanges % 2 != 0 {
			return .unevenDesignatorBoundaries
		}
		
		return nil
	}
}
