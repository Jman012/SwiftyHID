//
//  HIDDeviceProperty.swift
//  SwiftyHID
//
//  Created by James Linnell on 10/20/18.
//  Copyright © 2018 James Linnell. All rights reserved.
//

import Foundation
import IOKit

public protocol HIDDevicePropertyable {
	var transport: String? { get }
	var vendorID: Int? { get }
	var vendorIDSource: Int? { get }
	var productID: Int? { get }
	var versionNumber: Int? { get }
	var manufacturer: String? { get }
	var product: String? { get }
	var serialNumber: String? { get }
	var countryCode: HIDCountryCode? { get }
	/// - ToDo: Find true type
	var standardType: AnyObject? { get }
	var locationID: Int? { get }
	var deviceUsagePairs: [Usage]? { get }
	var primaryUsage: Usage? { get }
	var maxInputReportSize: Int? { get }
	var maxOutputReportSize: Int? { get }
	var maxFeatureReportSize: Int? { get }
	var reportInterval: Int? { get }
	/// - ToDo: Find true type
	var sampleInterval: AnyObject? { get }
	/// - ToDo: Find true type
	var batchInterval: AnyObject? { get }
	/// - ToDo: Find true type
	var requestTimeout: AnyObject? { get }
	var reportDescriptor: Data? { get }
	/// - ToDo: Find true type
	var reset: AnyObject? { get }
	/// - ToDo: Find true type
	var keyboardLanguage: AnyObject? { get }
	var altHandlerId: Int? { get }
	var builtIn: Bool? { get }
	/// - ToDo: Find true type
	var displayIntegrated: AnyObject? { get }
	/// - ToDo: Find true type
	var productIDMask: AnyObject? { get }
	/// - ToDo: Find true type
	var productIDArray: AnyObject? { get }
	/// - ToDo: Find true type
	var powerOnDelayNS: AnyObject? { get }
	/// - ToDo: Find true type
	var category: AnyObject? { get }
	/// - ToDo: Find true type
	var maxResponseLatency: AnyObject? { get }
	var uniqueID: Int? { get }
	/// - ToDo: Find true type
	var physicalDeviceUniqueID: AnyObject? { get }
}

public enum HIDDevicePropertyKey: CaseIterable {
	case transport
	case vendorID
	case vendorIDSource
	case productID
	case versionNumber
	case manufacturer
	case product
	case serialNumber
	case countryCode
	case standardType
	case locationID
	// The following are actually keys in the deviceUsagePairs dictionary below
	//	case deviceUsage
	//	case deviceUsagePage
	case deviceUsagePairs
	case primaryUsage
	case primaryUsagePage
	case maxInputReportSize
	case maxOutputReportSize
	case maxFeatureReportSize
	case reportInterval
	case sampleInterval
	case batchInterval
	case requestTimeout
	case reportDescriptor
	case reset
	case keyboardLanguage
	case altHandlerId
	case builtIn
	case displayIntegrated
	case productIDMask
	case productIDArray
	case powerOnDelayNS
	case category
	case maxResponseLatency
	case uniqueID
	case physicalDeviceUniqueID
	case other(customKey: String)
	
	var key: String {
		switch self {
		case .transport: return kIOHIDTransportKey
		case .vendorID: return kIOHIDVendorIDKey
		case .vendorIDSource: return kIOHIDVendorIDSourceKey
		case .productID: return kIOHIDProductIDKey
		case .versionNumber: return kIOHIDVersionNumberKey
		case .manufacturer: return kIOHIDManufacturerKey
		case .product: return kIOHIDProductKey
		case .serialNumber: return kIOHIDSerialNumberKey
		case .countryCode: return kIOHIDCountryCodeKey
		case .standardType: return kIOHIDStandardTypeKey
		case .locationID: return kIOHIDLocationIDKey
		case .deviceUsagePairs: return kIOHIDDeviceUsagePairsKey
		case .primaryUsage: return kIOHIDPrimaryUsageKey
		case .primaryUsagePage: return kIOHIDPrimaryUsagePageKey
		case .maxInputReportSize: return kIOHIDMaxInputReportSizeKey
		case .maxOutputReportSize: return kIOHIDMaxOutputReportSizeKey
		case .maxFeatureReportSize: return kIOHIDMaxFeatureReportSizeKey
		case .reportInterval: return kIOHIDReportIntervalKey
		case .sampleInterval: return kIOHIDSampleIntervalKey
		case .batchInterval: return kIOHIDBatchIntervalKey
		case .requestTimeout: return kIOHIDRequestTimeoutKey
		case .reportDescriptor: return kIOHIDReportDescriptorKey
		case .reset: return kIOHIDResetKey
		case .keyboardLanguage: return kIOHIDKeyboardLanguageKey
		case .altHandlerId: return kIOHIDAltHandlerIdKey
		case .builtIn: return kIOHIDBuiltInKey
		case .displayIntegrated: return kIOHIDDisplayIntegratedKey
		case .productIDMask: return kIOHIDProductIDMaskKey
		case .productIDArray: return kIOHIDProductIDArrayKey
		case .powerOnDelayNS: return kIOHIDPowerOnDelayNSKey
		case .category: return kIOHIDCategoryKey
		case .maxResponseLatency: return kIOHIDMaxResponseLatencyKey
		case .uniqueID: return kIOHIDUniqueIDKey
		case .physicalDeviceUniqueID: return kIOHIDPhysicalDeviceUniqueIDKey
		case .other(let customKey): return customKey
		}
	}
	
	public static var allCases: [HIDDevicePropertyKey] {
		return [
			.transport,
			.vendorID,
			.vendorIDSource,
			.productID,
			.versionNumber,
			.manufacturer,
			.product,
			.serialNumber,
			.countryCode,
			.standardType,
			.locationID,
			.deviceUsagePairs,
			.primaryUsage,
			.primaryUsagePage,
			.maxInputReportSize,
			.maxOutputReportSize,
			.maxFeatureReportSize,
			.reportInterval,
			.sampleInterval,
			.batchInterval,
			.requestTimeout,
			.reportDescriptor,
			.reset,
			.keyboardLanguage,
			.altHandlerId,
			.builtIn,
			.displayIntegrated,
			.productIDMask,
			.productIDArray,
			.powerOnDelayNS,
			.category,
			.maxResponseLatency,
			.uniqueID,
			.physicalDeviceUniqueID,
		]
	}
}
