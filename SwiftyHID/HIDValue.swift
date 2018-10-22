//
//  HIDValue.swift
//  JoyConManager
//
//  Created by James Linnell on 9/24/18.
//  Copyright © 2018 James Linnell. All rights reserved.
//

import Foundation
import IOKit

public enum HIDValueScaleType {
	
	/// Type for value that is scaled with respect to the calibration properties.
	case calibrated
	/// Type for value that is scaled with respect to the physical min and physical max of the element.
	case physical
	/// Type for value that is scaled with respect to the element's unit exponent.
	case exponent
	
	var value: IOHIDValueScaleType {
		switch self {
		case .calibrated: return IOHIDValueScaleType(kIOHIDValueScaleTypeCalibrated)
		case .physical: return IOHIDValueScaleType(kIOHIDValueScaleTypePhysical)
		case .exponent: return IOHIDValueScaleType(kIOHIDValueScaleTypeExponent)
		}
	}
}

public class HIDValue {
	let value: IOHIDValue
	
	init(with value: IOHIDValue) {
		self.value = value
	}
	
	init?(_ value: IOHIDValue?) {
		if let value = value {
			self.value = value
		} else {
			return nil
		}
	}
}

extension HIDValue: CustomStringConvertible {
	
	// MARK: HIDValue CustomStringConvertible Implementation
	
	public var description: String {
		return "Timestamp: \(getTimeStamp()), Length: \(getLength()), Bytes: \(self.getBytes().map { $0 }), Integer: \(getIntegerValue()), Element: \(getElement())"
	}
}

extension HIDValue {
	
	// MARK: IOHIDValue Methods
	
	/*!
	@function   IOHIDValueGetTypeID
	@abstract   Returns the type identifier of all IOHIDValue instances.
	*/
	@available(OSX 10.5, *)
	public static func getTypeID() -> CFTypeID {
		return IOHIDValueGetTypeID()
	}
	
	/*!
	@function   IOHIDValueCreateWithIntegerValue
	@abstract   Creates a new element value using an integer value.
	@discussion IOHIDValueGetTimeStamp should represent OS AbsoluteTime, not CFAbsoluteTime.
	To obtain the OS AbsoluteTime, please reference the APIs declared in <mach/mach_time.h>
	@param      allocator The CFAllocator which should be used to allocate memory for the value.  This
	parameter may be NULL in which case the current default CFAllocator is used. If this
	reference is not a valid CFAllocator, the behavior is undefined.
	@param      element IOHIDElementRef associated with this value.
	@param      timeStamp OS absolute time timestamp for this value.
	@param      value Integer value to be copied to this object.
	@result     Returns a reference to a new IOHIDValueRef.
	*/
	@available(OSX 10.5, *)
	public static func create(withIntegerValue integerValue: CFIndex, allocator: CFAllocator?, element: HIDElement, timeStamp: UInt64) -> HIDValue {
		return HIDValue(with: IOHIDValueCreateWithIntegerValue(allocator, element.element, timeStamp, integerValue))
	}
	
	/*!
	@function   IOHIDValueCreateWithBytes
	@abstract   Creates a new element value using byte data.
	@discussion IOHIDValueGetTimeStamp should represent OS AbsoluteTime, not CFAbsoluteTime.
	To obtain the OS AbsoluteTime, please reference the APIs declared in <mach/mach_time.h>
	@param      allocator The CFAllocator which should be used to allocate memory for the value.  This
	parameter may be NULL in which case the current default CFAllocator is used. If this
	reference is not a valid CFAllocator, the behavior is undefined.
	@param      element IOHIDElementRef associated with this value.
	@param      timeStamp OS absolute time timestamp for this value.
	@param      bytes Pointer to a buffer of uint8_t to be copied to this object.
	@param      length Number of bytes in the passed buffer.
	@result     Returns a reference to a new IOHIDValueRef.
	*/
	@available(OSX 10.5, *)
	public static func create(withBytes bytes: Data, allocator: CFAllocator?, element: HIDElement, timeStamp: UInt64) -> HIDValue? {
		
		var value: IOHIDValue? = nil
		bytes.withUnsafeBytes {
			body in
			value = IOHIDValueCreateWithBytes(allocator, element.element, timeStamp, body, bytes.count)
		}
		
		if let value = value {
			return HIDValue(with: value)
		}
		return nil
	}
	
	/*!
	@function   IOHIDValueCreateWithBytesNoCopy
	@abstract   Creates a new element value using byte data without performing a copy.
	@discussion The timestamp value passed should represent OS AbsoluteTime, not CFAbsoluteTime.
	To obtain the OS AbsoluteTime, please reference the APIs declared in <mach/mach_time.h>
	@param      allocator The CFAllocator which should be used to allocate memory for the value.  This
	parameter may be NULL in which case the current default CFAllocator is used. If this
	reference is not a valid CFAllocator, the behavior is undefined.
	@param      element IOHIDElementRef associated with this value.
	@param      timeStamp OS absolute time timestamp for this value.
	@param      bytes Pointer to a buffer of uint8_t to be referenced by this object.
	@param      length Number of bytes in the passed buffer.
	@result     Returns a reference to a new IOHIDValueRef.
	*/
//	@available(OSX 10.5, *)
//	public func IOHIDValueCreateWithBytesNoCopy(_ allocator: CFAllocator?, _ element: IOHIDElement, _ timeStamp: UInt64, _ bytes: UnsafePointer<UInt8>, _ length: CFIndex) -> IOHIDValue?
	
	/*!
	@function   IOHIDValueGetElement
	@abstract   Returns the element value associated with this IOHIDValueRef.
	@param      value The value to be queried. If this parameter is not a valid IOHIDValueRef, the behavior is undefined.
	@result     Returns a IOHIDElementRef referenced by this value.
	*/
	@available(OSX 10.5, *)
	public func getElement() -> HIDElement {
		return HIDElement(with: IOHIDValueGetElement(value))
	}
	
	/*!
	@function   IOHIDValueGetTimeStamp
	@abstract   Returns the timestamp value contained in this IOHIDValueRef.
	@discussion The timestamp value returned represents OS AbsoluteTime, not CFAbsoluteTime.
	@param      value The value to be queried. If this parameter is not a valid IOHIDValueRef, the behavior is undefined.
	@result     Returns a uint64_t representing the timestamp of this value.
	*/
	@available(OSX 10.5, *)
	public func getTimeStamp() -> UInt64 {
		return IOHIDValueGetTimeStamp(value)
	}
	
	/*!
	@function   IOHIDValueGetLength
	@abstract   Returns the size, in bytes, of the value contained in this IOHIDValueRef.
	@param      value The value to be queried. If this parameter is not a valid IOHIDValueRef, the behavior is undefined.
	@result     Returns length of the value.
	*/
	@available(OSX 10.5, *)
	// See getBytes() -> Data
	public func getLength() -> CFIndex {
		return IOHIDValueGetLength(value)
	}
	
	/*!
	@function   IOHIDValueGetBytePtr
	@abstract   Returns a byte pointer to the value contained in this IOHIDValueRef.
	@param      value The value to be queried. If this parameter is not a valid IOHIDValueRef, the behavior is undefined.
	@result     Returns a pointer to the value.
	*/
	@available(OSX 10.5, *)
//	public func IOHIDValueGetBytePtr(_ value: IOHIDValue) -> UnsafePointer<UInt8>
	// See getBytes() -> Data
	
	public func getBytes() -> Data {
		return Data(bytes: IOHIDValueGetBytePtr(value), count: getLength())
	}
	
	
	/*!
	@function   IOHIDValueGetIntegerValue
	@abstract   Returns an integer representaion of the value contained in this IOHIDValueRef.
	@discussion The value is based on the logical element value contained in the report returned by the device.
	@param      value The value to be queried. If this parameter is not a valid IOHIDValueRef, the behavior is undefined.
	@result     Returns an integer representation of the value.
	*/
	@available(OSX 10.5, *)
	public func getIntegerValue() -> CFIndex {
		return IOHIDValueGetIntegerValue(value)
	}
	
	/*!
	@function   IOHIDValueGetScaledValue
	@abstract   Returns an scaled representaion of the value contained in this IOHIDValueRef based on the scale type.
	@discussion The scaled value is based on the range described by the scale type's min and max, such that:
	<br>
	scaledValue = ((value - min) * (scaledMax - scaledMin) / (max - min)) + scaledMin
	<br>
	<b>Note:</b>
	<br>
	There are currently two types of scaling that can be applied:
	<ul>
	<li><b>kIOHIDValueScaleTypePhysical</b>: Scales element value using the physical bounds of the device such that <b>scaledMin = physicalMin</b> and <b>scaledMax = physicalMax</b>.
	<li><b>kIOHIDValueScaleTypeCalibrated</b>: Scales element value such that <b>scaledMin = -1</b> and <b>scaledMax = 1</b>.  This value will also take into account the calibration properties associated with this element.
	</ul>
	@param      value The value to be queried. If this parameter is not a valid IOHIDValueRef, the behavior is undefined.
	@param      type The type of scaling to be performed.
	@result     Returns an scaled floating point representation of the value.
	*/
	@available(OSX 10.5, *)
	public func getScaledValue(type: HIDValueScaleType) -> Double {
		return IOHIDValueGetScaledValue(value, type.value)
	}
}

extension HIDValue: Equatable {
	
	// MARK: Equatable Implementation
	
	public static func ==(lhs: HIDValue, rhs: HIDValue) -> Bool {
		return lhs.value == rhs.value
	}
}

extension HIDValue: Hashable {
	
	// MARK: Hashable Implementation
	
	public var hashValue: Int {
		return value.hashValue
	}
}
