//
//  HIDDescriptorParser.swift
//  SwiftyHID
//
//  Created by James Linnell on 11/4/18.
//  Copyright © 2018 James Linnell. All rights reserved.
//

import Foundation

public class HIDDescriptorParser {
	
	private var descriptorItems: [HIDDescriptorItem] = []
	private var globals: [HIDGlobalsItem] = []
	private var reports: [UInt32: HIDReportSizes] = [:]
	
	init() {
		
	}
	
	func parse(withDescriptorData descriptorData: Data) throws -> HIDDescriptor {
		self.descriptorItems = try HIDDescLexer.parse(descriptorData: descriptorData).map { $0.0 }
		globals = [HIDGlobalsItem()]
		
		for item in self.descriptorItems {
			switch item {
			case .main(let tag):
				try parseMainItem(mainTag: tag)
			case .global(let tag):
				try parseGlobalItem(globalTag: tag)
			case .local(let tag):
				try parseLocalItem(localTag: tag)
			}
		}
		
		return HIDDescriptor()
	}
	
	private func parseMainItem(mainTag: HIDDescriptorMainTag) throws {
//		switch mainTag {
//		case .input(let inputData):
//
//		case .output(let outputData):
//
//		case .feature(let featureData):
//
//		case .beginCollection(let collectionData):
//
//		case .endCollection:
//
//		}
	}
	
	private func parseGlobalItem(globalTag: HIDDescriptorGlobalTag) throws {
		
		guard let currentGlobal = globals.last else {
			throw HIDDescriptorParserError.unbalancedGlobalPushPop
		}
		
		switch globalTag {
		case .usagePage(let usagePage):
			currentGlobal.usagePage = usagePage
		case .logicalMin(let min):
			currentGlobal.logicalMinimum = min
		case .logicalMax(let max):
			currentGlobal.logicalMaximum = max
		case .physicalMin(let min):
			currentGlobal.physicalMinimum = min
		case .physicalMax(let max):
			currentGlobal.physicalMaximum = max
		case .unitExponent(let exponent):
			currentGlobal.unitExponent = exponent
		case .unit(let unit):
			currentGlobal.unit = unit
		case .reportSize(let size):
			currentGlobal.reportSize = size
		case .reportId(let reportId):
			if let _ = reports[reportId] {
				currentGlobal.reportId = reportId
			} else {
				reports[reportId] = HIDReportSizes(withReportId: reportId)
			}
		case .reportCount(let count):
			currentGlobal.reportCount = count
		case .push:
			globals.append(currentGlobal.copy())
		case .pop:
			let _ = globals.popLast()
		}
	}
	
	private func parseLocalItem(localTag: HIDDescriptorLocalTag) throws {
//		switch localTag {
//		case .usage(let usage):
//
//		case .designatorIndex(let index):
//
//		case .designatorMinimum(let min):
//
//		case .designatorMaximum(let max):
//
//		case .stringIndex(let index):
//
//		case .stringMinimum(let min):
//
//		case .stringMaximum(let max):
//
//		case .delimiter(let delimiter):
//
//		}
	}
	
}

protocol Copyable {
	init(instance: Self)
}

extension Copyable {
	func copy() -> Self {
		return Self.init(instance: self)
	}
}

class HIDGlobalsItem: Copyable {
	
	var usagePage: UInt32 = 0
	var logicalMinimum: Int32 = 0
	var logicalMaximum: Int32 = 0
	var physicalMinimum: Int32 = 0
	var physicalMaximum: Int32 = 0
	var unitExponent: Int32 = 0
	var unit: HIDUnit = HIDUnit(withData: 0)
	var reportSize: UInt32 = 0
	var reportId: UInt32 = 0
	var reportCount: UInt32 = 0
	
	init() {
		
	}
	
	required init(instance: HIDGlobalsItem) {
		usagePage = instance.usagePage
		logicalMinimum = instance.logicalMinimum
		logicalMaximum = instance.logicalMaximum
		physicalMinimum = instance.physicalMinimum
		physicalMaximum = instance.physicalMaximum
		unitExponent = instance.unitExponent
		unit = instance.unit
		reportSize = instance.reportSize
		reportId = instance.reportId
		reportCount = instance.reportCount
	}
}

class HIDReportSizes {
	var reportId: UInt32
	var inputBitCount: Int32 = 8
	var outputBitCount: Int32 = 8
	var featureBitCount: Int32 = 8
	
	init(withReportId reportId: UInt32) {
		self.reportId = reportId
	}
}
