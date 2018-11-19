//
//  HIDDescValidator.swift
//  SwiftyHID
//
//  Created by James Linnell on 10/28/18.
//  Copyright © 2018 James Linnell. All rights reserved.
//

import Foundation

public class HIDDescValidator {
	public static func validate(descriptorData: [HIDDescData]) -> [HIDDescriptorParserError] {
		
		var errors: [HIDDescriptorParserError] = []
		
		// These should end at 0, and never go negative
		var collectionNesting = 0
		var globalPushPopBalance = 0
		
		// These need to be at least 1
		var reportItemCount = 0
		
		// These need to be even
		var usageRanges = 0
		var stringRanges = 0
		var designatorRanges = 0
		
		// These must be encountered before reaching
		// a Main item.
		var usagePageSet = false
		// Either usage, or both usage min/max
		var usageSet = false
		var usageMinSet = false
		var usageMaxSet = false
		var logicalMinSet = false
		var logicalMaxSet = false
		var reportSizeSet = false
		var reportCountSet = false
		
		for data in descriptorData {
			let itemOpt = HIDDescriptorItem(type: data.itemType, tag: data.itemTag, unsignedValue: data.unsignedValue, signedValue: data.signedValue)
			
			guard let item = itemOpt else {
				errors.append(.unknownTypeOrTag(data))
				return errors // Unrecoverable
			}
			
			switch item {
			case .main(let tag):
				switch tag {
				case .beginCollection:
					collectionNesting += 1
				case .endCollection:
					collectionNesting -= 1
					
					if collectionNesting < 0 {
						errors.append(.unbalancedCollectionTags)
						return errors // Unrecoverable
					}
				case .input, .output, .feature:
					reportItemCount += 1
					
					if !usagePageSet && (!usageSet || (!usageMinSet && !usageMaxSet))
						&& !logicalMinSet && !logicalMaxSet
						&& !reportSizeSet && !reportCountSet {
						
						let isConstant: Bool
						switch tag {
						case .input(let data) where data.dataOrConstant == .constant:
							isConstant = true
						case .output(let data) where data.dataOrConstant == .constant:
							isConstant = true
						case .feature(let data) where data.dataOrConstant == .constant:
							isConstant = true
						default:
							isConstant = false
						}
						
						if isConstant && reportSizeSet && reportCountSet {
							// Constant inputs/outputs/features can be safely ignored as long
							// as the report size and count items are set.
						} else {
							if !usagePageSet {
								errors.append(.requiredUsagePageNotSetBeforeMain)
							}
							if !usageSet || (!usageMinSet && !usageMaxSet) {
								errors.append(.requiredUsageNotSetBeforeMain)
							}
							if !logicalMinSet {
								errors.append(.requiredLogicalMinimumNotSetBeforeMain)
							}
							if !logicalMaxSet {
								errors.append(.requiredLogicalMaximumNotSetBeforeMain)
							}
							if !reportSizeSet {
								errors.append(.requiredReportSizeNotSetBeforeMain)
							}
							if !reportCountSet {
								errors.append(.requiredReportCountNotSetBeforeMain)
							}
						}
					}
				}
				
			case .global(let tag):
				switch tag {
				case .usagePage:
					usagePageSet = true
				case .logicalMin:
					logicalMinSet = true
				case .logicalMax:
					logicalMaxSet = true
				case .reportSize:
					reportSizeSet = true
				case .reportCount:
					reportCountSet = true
				case .push:
					globalPushPopBalance += 1
				case .pop:
					globalPushPopBalance -= 1
					
					if globalPushPopBalance < 0 {
						errors.append(.unbalancedGlobalPushPop)
						return errors // Unrecoverable
					}
				default:
					break
				}
				
			case .local(let tag):
				switch tag {
				case .usage:
					usageSet = true
				case .usageMinimum:
					usageRanges += 1
					usageMinSet = true
				case .usageMaximum:
					usageRanges += 1
					usageMaxSet = true
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
			errors.append(.unbalancedCollectionTags)
		}
		if globalPushPopBalance != 0 {
			errors.append(.unbalancedGlobalPushPop)
		}
		
		if reportItemCount == 0 {
			errors.append(.noReportItems)
		}
		
		if usageRanges % 2 != 0 {
			errors.append(.unevenUsageBoundaries)
		}
		if stringRanges % 2 != 0 {
			errors.append(.unevenStringBoundaries)
		}
		if designatorRanges % 2 != 0 {
			errors.append(.unevenDesignatorBoundaries)
		}
		
		return errors
	}
}
