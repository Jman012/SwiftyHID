//
//  HIDElement.swift
//  JoyConManager
//
//  Created by James Linnell on 9/23/18.
//  Copyright © 2018 James Linnell. All rights reserved.
//

import Foundation
import IOKit

public protocol HIDElementDictionaryKeyable {
	var type: AnyObject? { get set }
	var cookie: AnyObject? { get set }
	var collectionType: AnyObject? { get set }
	var usage: AnyObject? { get set }
	var usagePage: AnyObject? { get set }
	var min: AnyObject? { get set }
	var max: AnyObject? { get set }
	var scaledMin: AnyObject? { get set }
	var scaledMax: AnyObject? { get set }
	var size: AnyObject? { get set }
	var reportSize: AnyObject? { get set }
	var reportCount: AnyObject? { get set }
	var reportID: AnyObject? { get set }
	var isArray: AnyObject? { get set }
	var isRelative: AnyObject? { get set }
	var isWrapping: AnyObject? { get set }
	var isNonLinear: AnyObject? { get set }
	var hasPreferredState: AnyObject? { get set }
	var hasNullState: AnyObject? { get set }
	var flags: AnyObject? { get set }
	var unit: AnyObject? { get set }
	var unitExponent: AnyObject? { get set }
	var name: AnyObject? { get set }
	var valueLocation: AnyObject? { get set }
	var duplicateIndex: AnyObject? { get set }
	var parentCollection: AnyObject? { get set }
	var variableSize: AnyObject? { get set }
	var vendorSpecific: AnyObject? { get set }
}

public protocol HIDElementMatchKeyable: HIDElementDictionaryKeyable {
	var cookieMin: AnyObject? { get set }
	var cookieMax: AnyObject? { get set }
	var usageMin: AnyObject? { get set }
	var usageMax: AnyObject? { get set }
	
	/**
	 The minimum bounds for a calibrated value.
	*/
	var calibrationMin: AnyObject? { get set }
	
	/**
	 The maximum bounds for a calibrated value.
	*/
	var calibrationMax: AnyObject? { get set }
	
	/**
	 The mininum tolerance to be used when calibrating a logical element value.
	
	 The saturation property is used to allow for slight differences in the minimum and maximum value returned by an element.
	*/
	var calibrationSaturationMin: AnyObject? { get set }
	
	/**
	 The maximum tolerance to be used when calibrating a logical element value.
	
	 The saturation property is used to allow for slight differences in the minimum and maximum value returned by an element.
	*/
	var calibrationSaturationMax: AnyObject? { get set }
	
	/**
	 The minimum bounds near the midpoint of a logical value in which the value is ignored.
	
	 The dead zone property is used to allow for slight differences in the idle value returned by an element.
	*/
	var calibrationDeadZoneMin: AnyObject? { get set }
	
	/**
	 The maximum bounds near the midpoint of a logical value in which the value is ignored.
	
	 The dead zone property is used to allow for slight differences in the idle value returned by an element.
	*/
	var calibrationDeadZoneMax: AnyObject? { get set }
	
	/**
	 The scale or level of detail returned in a calibrated element value.
	
	 Values are rounded off such that if granularity=0.1, values after calibration are 0, 0.1, 0.2, 0.3, etc.
	*/
	var calibrationGranularity: AnyObject? { get set }
}

/**
 Keys that represent properties of a particular elements.
 
 These keys can also be added to a matching dictionary when searching for elements via copy(matchingElements:,options:).
 */
public enum HIDElementDictionaryKey: Hashable {
	case type
	case cookie
	case collectionType
	case usage
	case usagePage
	case min
	case max
	case scaledMin
	case scaledMax
	case size
	case reportSize
	case reportCount
	case reportID
	case isArray
	case isRelative
	case isWrapping
	case isNonLinear
	case hasPreferredState
	case hasNullState
	case flags
	case unit
	case unitExponent
	case name
	case valueLocation
	case duplicateIndex
	case parentCollection
	case variableSize
	case vendorSpecific
	
	var value: String {
		switch self {
		case .cookie: return kIOHIDElementCookieKey
		case .type: return kIOHIDElementTypeKey
		case .collectionType: return kIOHIDElementCollectionTypeKey
		case .usage: return kIOHIDElementUsageKey
		case .usagePage: return kIOHIDElementUsagePageKey
		case .min: return kIOHIDElementMinKey
		case .max: return kIOHIDElementMaxKey
		case .scaledMin: return kIOHIDElementScaledMinKey
		case .scaledMax: return kIOHIDElementScaledMaxKey
		case .size: return kIOHIDElementSizeKey
		case .reportSize: return kIOHIDElementReportSizeKey
		case .reportCount: return kIOHIDElementReportCountKey
		case .reportID: return kIOHIDElementReportIDKey
		case .isArray: return kIOHIDElementIsArrayKey
		case .isRelative: return kIOHIDElementIsRelativeKey
		case .isWrapping: return kIOHIDElementIsWrappingKey
		case .isNonLinear: return kIOHIDElementIsNonLinearKey
		case .hasPreferredState: return kIOHIDElementHasPreferredStateKey
		case .hasNullState: return kIOHIDElementHasNullStateKey
		case .flags: return kIOHIDElementFlagsKey
		case .unit: return kIOHIDElementUnitKey
		case .unitExponent: return kIOHIDElementUnitExponentKey
		case .name: return kIOHIDElementNameKey
		case .valueLocation: return kIOHIDElementValueLocationKey
		case .duplicateIndex: return kIOHIDElementDuplicateIndexKey
		case .parentCollection: return kIOHIDElementParentCollectionKey
		case .variableSize: return kIOHIDElementVariableSizeKey
		case .vendorSpecific: return kIOHIDElementVendorSpecificKey
		}
	}
	
	// MARK: Hashable Implementation
	
	public var hashValue: Int { return value.hashValue }
	
	static public func ==(lhs: HIDElementDictionaryKey, rhs: HIDElementDictionaryKey) -> Bool {
		return lhs.value == rhs.value
	}
}

/**
 Keys used for matching particular elements.
 
 These keys should only be used with a matching dictionary when searching for elements via copy(matchingElements:,options:).
 */
public enum HIDElementMatchKey: Hashable {
	case exact(HIDElementDictionaryKey)
	case cookieMin
	case cookieMax
	case usageMin
	case usageMax
	
	/**
	 The minimum bounds for a calibrated value.
	 */
	case calibrationMin
	
	/**
	 The maximum bounds for a calibrated value.
	 */
	case calibrationMax
	
	/**
	 The mininum tolerance to be used when calibrating a logical element value.
	 
	 The saturation property is used to allow for slight differences in the minimum and maximum value returned by an element.
	 */
	case calibrationSaturationMin
	
	/**
	 The maximum tolerance to be used when calibrating a logical element value.
	 
	 The saturation property is used to allow for slight differences in the minimum and maximum value returned by an element.
	 */
	case calibrationSaturationMax
	
	/**
	 The minimum bounds near the midpoint of a logical value in which the value is ignored.
	 
	 The dead zone property is used to allow for slight differences in the idle value returned by an element.
	 */
	case calibrationDeadZoneMin
	
	/**
	 The maximum bounds near the midpoint of a logical value in which the value is ignored.
	 
	 The dead zone property is used to allow for slight differences in the idle value returned by an element.
	 */
	case calibrationDeadZoneMax
	
	/**
	 The scale or level of detail returned in a calibrated element value.
	 
	 Values are rounded off such that if granularity=0.1, values after calibration are 0, 0.1, 0.2, 0.3, etc.
	 */
	case calibrationGranularity
	
	var value: String {
		switch self {
		case .exact(let dicKey): return dicKey.value
		case .cookieMin: return kIOHIDElementCookieMinKey
		case .cookieMax: return kIOHIDElementCookieMaxKey
		case .usageMin: return kIOHIDElementUsageMinKey
		case .usageMax: return kIOHIDElementUsageMaxKey
		case .calibrationMin: return kIOHIDElementCalibrationMinKey
		case .calibrationMax: return kIOHIDElementCalibrationMaxKey
		case .calibrationSaturationMin: return kIOHIDElementCalibrationSaturationMinKey
		case .calibrationSaturationMax: return kIOHIDElementCalibrationSaturationMaxKey
		case .calibrationDeadZoneMin: return kIOHIDElementCalibrationDeadZoneMinKey
		case .calibrationDeadZoneMax: return kIOHIDElementCalibrationDeadZoneMaxKey
		case .calibrationGranularity: return kIOHIDElementCalibrationGranularityKey
		}
	}
	
	// MARK: Hashable Implementation
	
	public var hashValue: Int { return value.hashValue }
	
	static public func ==(lhs: HIDElementMatchKey, rhs: HIDElementMatchKey) -> Bool {
		return lhs.value == rhs.value
	}
}

extension Dictionary where Key == HIDElementMatchKey, Value == Any {
	var ioHIDSafeDic: CFDictionary {
		var dic: [String: Any] = [:]
		for (key, value) in self {
			dic[key.value] = value
		}
		return dic as CFDictionary
	}
}

public enum HIDElementCollectionType {
	
	/// Used for a set of data items that represent data points collected at one geometric point.
	case physical
	
	/// Identifies item groups serving different purposes in a single device.
	case application
	
	/// Used when a set of data items form a composite data structure.
	case logical
	
	/// Wraps all the fields in a report.
	case report
	
	/// Contains an array of selector usages.
	case namedArray
	
	/// Modifies the meaning of the usage it contains.
	case usageSwitch
	
	/// Modifies the meaning of the usage attached to the encompassing collection.
	case usageModifier
	
	case other(IOHIDElementCollectionType)
	
	public var value: IOHIDElementCollectionType {
		switch self {
		case .physical: return kIOHIDElementCollectionTypePhysical
		case .application: return kIOHIDElementCollectionTypeApplication
		case .logical: return kIOHIDElementCollectionTypeLogical
		case .report: return kIOHIDElementCollectionTypeReport
		case .namedArray: return kIOHIDElementCollectionTypeNamedArray
		case .usageSwitch: return kIOHIDElementCollectionTypeUsageSwitch
		case .usageModifier: return kIOHIDElementCollectionTypeUsageModifier
		case .other(let type): return type
		}
	}
	
	init(with type: IOHIDElementCollectionType) {
		switch type {
		case kIOHIDElementCollectionTypePhysical: self = .physical
		case kIOHIDElementCollectionTypeApplication: self = .application
		case kIOHIDElementCollectionTypeLogical: self = .logical
		case kIOHIDElementCollectionTypeReport: self = .report
		case kIOHIDElementCollectionTypeNamedArray: self = .namedArray
		case kIOHIDElementCollectionTypeUsageSwitch: self = .usageSwitch
		case kIOHIDElementCollectionTypeUsageModifier: self = .usageModifier
		default: self = .other(type)
		}
	}
}

/**
 Describes different types of HID elements.

 Used by the IOHIDFamily to identify the type of
 element processed. Represented by the key kIOHIDElementTypeKey in the
 dictionary describing the element.
 */
public enum HIDElementType {
	/// Misc input data field or varying size.
	case inputMisc
	/// One bit input data field.
	case inputButton
	/// Input data field used to represent an axis.
	case inputAxis
	/// Input data field used to represent a scan code or usage selector.
	case inputScanCodes
	/// Used to represent an output data field in a report.
	case output
	/// Describes input and output elements not intended for consumption by the end user.
	case feature
	/// Element used to identify a relationship between two or more elements.
	case collection
	case other(IOHIDElementType)
	
	var value: IOHIDElementType {
		switch self {
		case .inputMisc: return kIOHIDElementTypeInput_Misc
		case .inputButton: return kIOHIDElementTypeInput_Button
		case .inputAxis: return kIOHIDElementTypeInput_Axis
		case .inputScanCodes: return kIOHIDElementTypeInput_ScanCodes
		case .output: return kIOHIDElementTypeOutput
		case .feature: return kIOHIDElementTypeFeature
		case .collection: return kIOHIDElementTypeCollection
		case .other(let val): return val
		}
	}
	
	public static func create(with value: IOHIDElementType) -> HIDElementType {
		switch value {
		case kIOHIDElementTypeInput_Misc: return .inputMisc
		case kIOHIDElementTypeInput_Button: return .inputButton
		case kIOHIDElementTypeInput_Axis: return .inputAxis
		case kIOHIDElementTypeInput_ScanCodes: return .inputScanCodes
		case kIOHIDElementTypeOutput: return .output
		case kIOHIDElementTypeFeature: return .feature
		case kIOHIDElementTypeCollection: return .collection
		default: return .other(value)
		}
	}
}

public class HIDElement {
	
	let element: IOHIDElement
	
	public init(with element: IOHIDElement) {
		self.element = element
	}
	
}

extension HIDElement: CustomStringConvertible {
	
	// MARK: CustomStringConvertible Implementation
	
	public var description: String {
		return """
		Cookie: \(cookie)
		Type: \(type)
		CollectionType: \(collectionType)
		Usage: \(usage)
		IsVirtual: \(isVirtual)
		IsRelative: \(isRelative)
		IsWrapping: \(isWrapping)
		IsArray: \(isArray)
		IsNonLinear: \(isNonLinear)
		HasPreferredState: \(hasPreferredState)
		HasNullState: \(hasNullState)
		Name: \(name)
		ReportID: \(reportID)
		ReportSize: \(reportSize)
		ReportCount: \(reportCount)
		Unit: \(unit)
		UnitExponent: \(unitExponent)
		LogicalMin: \(logicalMin)
		LogicalMax: \(logicalMax)
		PhysicalMin: \(physicalMin)
		PhysicalMax: \(physicalMax)
		Children: \(children?.count ?? 0)
		"""
	}

}

extension HIDElement {
	
	// MARK: IOHIDElement Methods
	
	/*!
	@function   IOHIDElementGetTypeID
	@abstract   Returns the type identifier of all IOHIDElement instances.
	*/
	@available(OSX 10.5, *)
	public static func getTypeID() -> CFTypeID {
		return IOHIDElementGetTypeID()
	}
	
	/*!
	@function   IOHIDElementCreateWithDictionary
	@abstract   Creates an element from a dictionary.
	@discussion The dictionary should contain keys defined in IOHIDKeys.h and start with kIOHIDElement.  This call is meant be used by a IOHIDDeviceDeviceInterface object.
	@param      allocator Allocator to be used during creation.
	@param      dictionary dictionary containing values in which to create element.
	@result     Returns a new IOHIDElementRef.
	*/
	@available(OSX 10.5, *)
//	public func IOHIDElementCreateWithDictionary(_ allocator: CFAllocator?, _ dictionary: CFDictionary) -> IOHIDElement
	
	/*!
	@function   IOHIDElementGetDevice
	@abstract   Obtain the device associated with the element.
	@param      element IOHIDElement to be queried.
	@result     Returns the a reference to the device.
	*/
	@available(OSX 10.5, *)
	public var device: HIDDevice {
		return HIDDevice(with: IOHIDElementGetDevice(element))
	}
	
	/*!
	@function   IOHIDElementGetParent
	@abstract   Returns the parent for the element.
	@discussion The parent element can be an element of type kIOHIDElementTypeCollection.
	@param      element The element to be queried. If this parameter is not a valid IOHIDElementRef, the behavior is undefined.
	@result     Returns an IOHIDElementRef referencing the parent element.
	*/
	@available(OSX 10.5, *)
	public var parent: HIDElement? {
		if let el = IOHIDElementGetParent(element) {
			return HIDElement(with: el)
		}
		return nil
	}
	
	/*!
	@function   IOHIDElementGetChildren
	@abstract   Returns the children for the element.
	@discussion An element of type kIOHIDElementTypeCollection usually contains children.
	@param      element The element to be queried. If this parameter is not a valid IOHIDElementRef, the behavior is undefined.
	@result     Returns an CFArrayRef containing element objects of type IOHIDElementRef.
	*/
	@available(OSX 10.5, *)
	public var children: [HIDElement]? {
		if let children = IOHIDElementGetChildren(element) {
			return (children as! [IOHIDElement]).map { HIDElement(with: $0) }
		}
		return nil
	}
	
	/*!
	@function   IOHIDElementAttach
	@abstract   Establish a relationship between one or more elements.
	@discussion This is useful for grouping HID elements with related functionality.
	@param      element The element to be modified. If this parameter is not a valid IOHIDElementRef, the behavior is undefined.
	@param      toAttach The element to be attached. If this parameter is not a valid IOHIDElementRef, the behavior is undefined.
	*/
	@available(OSX 10.5, *)
	public func attach(to element: HIDElement) {
		IOHIDElementAttach(self.element, element.element)
	}
	
	/*!
	@function   IOHIDElementDetach
	@abstract   Remove a relationship between one or more elements.
	@discussion This is useful for grouping HID elements with related functionality.
	@param      element The element to be modified. If this parameter is not a valid IOHIDElementRef, the behavior is undefined.
	@param      toDetach The element to be detached. If this parameter is not a valid IOHIDElementRef, the behavior is undefined.
	*/
	@available(OSX 10.5, *)
	public func detach(_ element: HIDElement) {
		IOHIDElementDetach(self.element, element.element)
	}
	
	/*!
	@function   IOHIDElementCopyAttached
	@abstract   Obtain attached elements.
	@discussion Attached elements are those that have been grouped via IOHIDElementAttach.
	@param      element The element to be modified. If this parameter is not a valid IOHIDElementRef, the behavior is undefined.
	@result     Returns a copy of the current attached elements.
	*/
	@available(OSX 10.5, *)
	public func copyAttached() -> [HIDElement]? {
		if let copy = IOHIDElementCopyAttached(element) {
			return (copy as! [IOHIDElement]).map { HIDElement(with: $0) }
		}
		return nil
	}
	
	/*!
	@function   IOHIDElementGetCookie
	@abstract   Retrieves the cookie for the element.
	@discussion The IOHIDElementCookie represent a unique identifier for an element within a device.
	@param      element The element to be queried. If this parameter is not a valid IOHIDElementRef, the behavior is undefined.
	@result     Returns the IOHIDElementCookie for the element.
	*/
	@available(OSX 10.5, *)
	public var cookie: IOHIDElementCookie {
		return IOHIDElementGetCookie(element)
	}
	
	/*!
	@function   IOHIDElementGetType
	@abstract   Retrieves the type for the element.
	@param      element The element to be queried. If this parameter is not a valid IOHIDElementRef, the behavior is undefined.
	@result     Returns the IOHIDElementType for the element.
	*/
	@available(OSX 10.5, *)
	public var type: HIDElementType {
		return HIDElementType.create(with: IOHIDElementGetType(element))
	}
	
	/*!
	@function   IOHIDElementGetCollectionType
	@abstract   Retrieves the collection type for the element.
	@discussion The value returned by this method only makes sense if the element type is kIOHIDElementTypeCollection.
	@param      element The element to be queried. If this parameter is not a valid IOHIDElementRef, the behavior is undefined.
	@result     Returns the IOHIDElementCollectionType for the element.
	*/
	@available(OSX 10.5, *)
	public var collectionType: HIDElementCollectionType {
		return HIDElementCollectionType(with: IOHIDElementGetCollectionType(element))
	}
	
	/*!
	@function   IOHIDElementGetUsagePage and IOHIDElementGetUsage
	@abstract   Retrieves the usage page and usage for an element.
	@param      element The element to be queried. If this parameter is not a valid IOHIDElementRef, the behavior is undefined.
	@result     Returns the usage for the element.
	*/
	@available(OSX 10.5, *)
	public var usage: Usage {
		return Usage(withUsagePage: Int(IOHIDElementGetUsagePage(element)), usage: Int(IOHIDElementGetUsage(element)))
	}
	
	/*!
	@function   IOHIDElementIsVirtual
	@abstract   Returns the virtual property for the element.
	@discussion Indicates whether the element is a virtual element.
	@param      element The element to be queried. If this parameter is not a valid IOHIDElementRef, the behavior is undefined.
	@result     Returns the TRUE if virtual or FALSE if not.
	*/
	@available(OSX 10.5, *)
	public var isVirtual: Bool {
		return IOHIDElementIsVirtual(element)
	}
	
	/*!
	@function   IOHIDElementIsRelative
	@abstract   Returns the relative property for the element.
	@discussion Indicates whether the data is relative (indicating the change in value from the last report) or absolute
	(based on a fixed origin).
	@param      element The element to be queried. If this parameter is not a valid IOHIDElementRef, the behavior is undefined.
	@result     Returns TRUE if relative or FALSE if absolute.
	*/
	@available(OSX 10.5, *)
	public var isRelative: Bool {
		return IOHIDElementIsRelative(element)
	}
	
	/*!
	@function   IOHIDElementIsWrapping
	@abstract   Returns the wrap property for the element.
	@discussion Wrap indicates whether the data "rolls over" when reaching either the extreme high or low value.
	@param      element The element to be queried. If this parameter is not a valid IOHIDElementRef, the behavior is undefined.
	@result     Returns TRUE if wrapping or FALSE if non-wrapping.
	*/
	@available(OSX 10.5, *)
	public var isWrapping: Bool {
		return IOHIDElementIsWrapping(element)
	}
	
	/*!
	@function   IOHIDElementIsArray
	@abstract   Returns the array property for the element.
	@discussion Indicates whether the element represents variable or array data values. Variable values represent data from a
	physical control.  An array returns an index in each field that corresponds to the pressed button
	(like keyboard scan codes).
	<br>
	<b>Note:</b> The HID Manager will represent most elements as "variable" including the possible usages of an array.
	Array indices will remain as "array" elements with a usage of 0xffffffff.
	@param      element The element to be queried. If this parameter is not a valid IOHIDElementRef, the behavior is undefined.
	@result     Returns TRUE if array or FALSE if variable.
	*/
	@available(OSX 10.5, *)
	public var isArray: Bool {
		return IOHIDElementIsArray(element)
	}
	
	/*!
	@function   IOHIDElementIsNonLinear
	@abstract   Returns the linear property for the element.
	@discussion Indicates whether the value for the element has been processed in some way, and no longer represents a linear
	relationship between what is measured and the value that is reported.
	@param      element The element to be queried. If this parameter is not a valid IOHIDElementRef, the behavior is undefined.
	@result     Returns TRUE if non linear or FALSE if linear.
	*/
	@available(OSX 10.5, *)
	public var isNonLinear: Bool {
		return IOHIDElementIsNonLinear(element)
	}
	
	/*!
	@function   IOHIDElementHasPreferredState
	@abstract   Returns the preferred state property for the element.
	@discussion Indicates whether the element has a preferred state to which it will return when the user is not physically
	interacting with the control.
	@param      element The element to be queried. If this parameter is not a valid IOHIDElementRef, the behavior is undefined.
	@result     Returns TRUE if preferred state or FALSE if no preferred state.
	*/
	@available(OSX 10.5, *)
	public var hasPreferredState: Bool {
		return IOHIDElementHasPreferredState(element)
	}
	
	/*!
	@function   IOHIDElementHasNullState
	@abstract   Returns the null state property for the element.
	@discussion Indicates whether the element has a state in which it is not sending meaningful data.
	@param      element The element to be queried. If this parameter is not a valid IOHIDElementRef, the behavior is undefined.
	@result     Returns TRUE if null state or FALSE if no null state.
	*/
	@available(OSX 10.5, *)
	public var hasNullState: Bool {
		return IOHIDElementHasNullState(element)
	}
	
	/*!
	@function   IOHIDElementGetName
	@abstract   Returns the name for the element.
	@param      element The element to be queried. If this parameter is not a valid IOHIDElementRef, the behavior is undefined.
	@result     Returns CFStringRef containing the element name.
	*/
	@available(OSX 10.5, *)
	public var name: String {
		let r = IOHIDElementGetName(element) // as String
		// Todo: James: Report this to Apple? A non-nil object is...gasp...nil!
		if r == nil {
			return ""
		}
		return r as String
	}
	
	/*!
	@function   IOHIDElementGetReportID
	@abstract   Returns the report ID for the element.
	@discussion The report ID represents what report this particular element belongs to.
	@param      element The element to be queried. If this parameter is not a valid IOHIDElementRef, the behavior is undefined.
	@result     Returns the report ID.
	*/
	@available(OSX 10.5, *)
	public var reportID: UInt32 {
		return IOHIDElementGetReportID(element)
	}
	
	/*!
	@function   IOHIDElementGetReportSize
	@abstract   Returns the report size in bits for the element.
	@param      element The element to be queried. If this parameter is not a valid IOHIDElementRef, the behavior is undefined.
	@result     Returns the report size.
	*/
	@available(OSX 10.5, *)
	public var reportSize: UInt32 {
		return IOHIDElementGetReportSize(element)
	}
	
	/*!
	@function   IOHIDElementGetReportCount
	@abstract   Returns the report count for the element.
	@param      element The element to be queried. If this parameter is not a valid IOHIDElementRef, the behavior is undefined.
	@result     Returns the report count.
	*/
	@available(OSX 10.5, *)
	public var reportCount: UInt32 {
		return IOHIDElementGetReportCount(element)
	}
	
	/*!
	@function   IOHIDElementGetUnit
	@abstract   Returns the unit property for the element.
	@discussion The unit property is described in more detail in Section 6.2.2.7 of the
	"Device Class Definition for Human Interface Devices(HID)" Specification, Version 1.11.
	@param      element The element to be queried. If this parameter is not a valid IOHIDElementRef, the behavior is undefined.
	@result     Returns the unit.
	*/
	@available(OSX 10.5, *)
	public var unit: HIDUnit {
		return HIDUnit(withData: IOHIDElementGetUnit(element))
	}
	
	/*!
	@function   IOHIDElementGetUnitExponent
	@abstract   Returns the unit exponenet in base 10 for the element.
	@discussion The unit exponent property is described in more detail in Section 6.2.2.7 of the
	"Device Class Definition for Human Interface Devices(HID)" Specification, Version 1.11.
	@param      element The element to be queried. If this parameter is not a valid IOHIDElementRef, the behavior is undefined.
	@result     Returns the unit exponent.
	*/
	@available(OSX 10.5, *)
	public var unitExponent: UInt32 {
		return IOHIDElementGetUnitExponent(element)
	}
	
	/*!
	@function   IOHIDElementGetLogicalMin
	@abstract   Returns the minimum value possible for the element.
	@discussion This corresponds to the logical minimun, which indicates the lower bounds of a variable element.
	@param      element The element to be queried. If this parameter is not a valid IOHIDElementRef, the behavior is undefined.
	@result     Returns the logical minimum.
	*/
	@available(OSX 10.5, *)
	public var logicalMin: Int {
		return IOHIDElementGetLogicalMin(element) as Int
	}
	
	/*!
	@function   IOHIDElementGetLogicalMax
	@abstract   Returns the maximum value possible for the element.
	@discussion This corresponds to the logical maximum, which indicates the upper bounds of a variable element.
	@param      element The element to be queried. If this parameter is not a valid IOHIDElementRef, the behavior is undefined.
	@result     Returns the logical maximum.
	*/
	@available(OSX 10.5, *)
	public var logicalMax: Int {
		return IOHIDElementGetLogicalMax(element) as Int
	}
	
	/*!
	@function   IOHIDElementGetPhysicalMin
	@abstract   Returns the scaled minimum value possible for the element.
	@discussion Minimum value for the physical extent of a variable element. This represents the value for the logical minimum with units applied to it.
	@param      element The element to be queried. If this parameter is not a valid IOHIDElementRef, the behavior is undefined.
	@result     Returns the physical minimum.
	*/
	@available(OSX 10.5, *)
	public var physicalMin: Int {
		return IOHIDElementGetPhysicalMin(element) as Int
	}
	
	/*!
	@function   IOHIDElementGetPhysicalMax
	@abstract   Returns the scaled maximum value possible for the element.
	@discussion Maximum value for the physical extent of a variable element.  This represents the value for the logical maximum with units applied to it.
	@param      element The element to be queried. If this parameter is not a valid IOHIDElementRef, the behavior is undefined.
	@result     Returns the physical maximum.
	*/
	@available(OSX 10.5, *)
	public var physicalMax: Int {
		return IOHIDElementGetPhysicalMax(element) as Int
	}
	
	/*!
	@function   IOHIDElementGetProperty
	@abstract   Returns the an element property.
	@discussion Property keys are prefixed by kIOHIDElement and declared in IOHIDKeys.h.
	@param      element The element to be queried. If this parameter is not a valid IOHIDElementRef, the behavior is undefined.
	@param      key The key to be used when querying the element.
	@result     Returns the property.
	*/
	@available(OSX 10.5, *)
	public func getProperty(_ key: HIDElementDictionaryKey) -> AnyObject? {
		return IOHIDElementGetProperty(element, key.value as CFString)
	}
	
	/*!
	@function   IOHIDElementSetProperty
	@abstract   Sets an element property.
	@discussion This method can be used to set arbitrary element properties, such as application specific references.
	@param      element The element to be queried. If this parameter is not a valid IOHIDElementRef, the behavior is undefined.
	@param      key The key to be used when querying the element.
	@result     Returns TRUE if successful.
	*/
	@available(OSX 10.5, *)
	public func setProperty(_ property: AnyObject, forKey key: HIDElementDictionaryKey) -> Bool {
		return IOHIDElementSetProperty(element, key.value as CFString, property)
	}
}

extension HIDElement: Equatable {
	
	// MARK: Equatable Implementation
	
	public static func ==(lhs: HIDElement, rhs: HIDElement) -> Bool {
		return lhs.element == rhs.element
	}
}

extension HIDElement: Hashable {
	
	// MARK: Hashable Implementation
	
	public var hashValue: Int {
		return element.hashValue
	}
}
