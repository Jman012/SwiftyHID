//
//  Errors.swift
//  SwiftyHID
//
//  Created by James Linnell on 10/28/18.
//  Copyright © 2018 James Linnell. All rights reserved.
//

import Foundation

enum HIDDescError: Error {
	case unexpectedEndOfData
}

public enum HIDDescriptorParserError: Error {
	case unknownTypeOrTag(HIDDescData)
	
	case unbalancedCollectionTags
	case unbalancedGlobalPushPop
	
	case noReportItems
	
	case unevenUsageBoundaries
	case unevenStringBoundaries
	case unevenDesignatorBoundaries
	
	case requiredUsagePageNotSetBeforeMain
	case requiredUsageNotSetBeforeMain
	case requiredLogicalMinimumNotSetBeforeMain
	case requiredLogicalMaximumNotSetBeforeMain
	case requiredReportSizeNotSetBeforeMain
	case requiredReportCountNotSetBeforeMain
	
	case invalidItemWhileParsing(invalidData: HIDDescData, parsedSoFar: [(HIDDescriptorItem, HIDDescData)])
}
