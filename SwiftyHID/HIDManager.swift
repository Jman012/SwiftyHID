//
//  HIDManager.swift
//  JoyConManager
//
//  Created by James Linnell on 9/29/18.
//  Copyright © 2018 James Linnell. All rights reserved.
//

import Foundation
import IOKit

public typealias HIDManagerDeviceMatchingCallback = (_ result: Return, _ sender: HIDManager, _ device: HIDDevice) -> Void
public typealias HIDManagerDeviceRemovalCallback = (_ result: Return, _ sender: HIDManager, _ device: HIDDevice) -> Void

public class HIDManager {
	
	// MARK: Initialization
	
	let manager: IOHIDManager
	
	init(with manager: IOHIDManager) {
		self.manager = manager
		
		setupCallbacks()
	}
	
	// MARK: Callback Properties
	
	private var registeredMatchingCallback: HIDManagerDeviceMatchingCallback?
	private var registeredRemovalCallback: HIDManagerDeviceRemovalCallback?
	private var registeredInputValueCallback: HIDDeviceInputValueCallback?
	private var registeredInputReportCallback: HIDDeviceInputReportCallback?
	
	
	deinit {
		// Unregister static callback functions
		self.register(deviceMatchingCallback: nil, context: Unmanaged.passUnretained(self))
		self.register(deviceRemovalCallback: nil, context: Unmanaged.passUnretained(self))
		self.register(inputValueCallback: nil, context: Unmanaged.passUnretained(self))
		self.register(inputReportCallback: nil, context: Unmanaged.passUnretained(self))
	}
	
	// MARK: Swift-friendly Callbacks
	
	private func setupCallbacks() {
		let context = Unmanaged.passUnretained(self)
		
		let matchingCallback: IOHIDDeviceCallback = {
			context, result, sender, device in
			let this = Unmanaged<HIDManager>.fromOpaque(context!).takeUnretainedValue()
			
			if let callback = this.registeredMatchingCallback {
				callback(Return(with: result), this, HIDDevice(with: device))
			}
		}
		self.register(deviceMatchingCallback: matchingCallback, context: context)
		
		let removalCallback: IOHIDDeviceCallback = {
			context, result, sender, device in
			let this = Unmanaged<HIDManager>.fromOpaque(context!).takeUnretainedValue()
			
			if let callback = this.registeredRemovalCallback {
				callback(Return(with: result), this, HIDDevice(with: device))
			}
		}
		self.register(deviceRemovalCallback: removalCallback, context: context)
		
		let inputValueCallback: IOHIDValueCallback = {
			context, result, sender, value in
			let this = Unmanaged<HIDManager>.fromOpaque(context!).takeUnretainedValue()
			let queueSender = Unmanaged<IOHIDQueue>.fromOpaque(sender!).takeUnretainedValue()
			
			if let callback = this.registeredInputValueCallback {
				callback(Return(with: result), HIDQueue(with: queueSender), HIDValue(with: value))
			}
		}
		self.register(inputValueCallback: inputValueCallback, context: context)
		
		let inputReportCallback: IOHIDReportCallback = {
			context, result, sender, type, reportID, report, reportLength in
			let this = Unmanaged<HIDManager>.fromOpaque(context!).takeUnretainedValue()
			let deviceSender = Unmanaged<IOHIDDevice>.fromOpaque(sender!).takeUnretainedValue()
			let device = HIDDevice(with: deviceSender)
			
			if let callback = this.registeredInputReportCallback {
				let reportArray = Utils.createArray(pointer: report, length: reportLength)
				
				callback(Return(with: result), device, HIDReportType(with: type), reportID, reportArray)
			}
		}
		self.register(inputReportCallback: inputReportCallback, context: context)
	}
	
	public func register(matchingCallback: @escaping HIDManagerDeviceMatchingCallback) {
		registeredMatchingCallback = matchingCallback
	}
	
	public func register(removalCallback: @escaping HIDManagerDeviceRemovalCallback) {
		registeredRemovalCallback = removalCallback
	}
	
	public func register(inputValueCallback: @escaping HIDDeviceInputValueCallback) {
		registeredInputValueCallback = inputValueCallback
	}
	
	public func register(inputReportCallback: @escaping HIDDeviceInputReportCallback) {
		registeredInputReportCallback = inputReportCallback
	}
}

extension HIDManager {
	
	// MARK: IOHIDManager Methods
	
	/*!
	@function   IOHIDManagerGetTypeID
	@abstract   Returns the type identifier of all IOHIDManager instances.
	*/
	@available(OSX 10.5, *)
	public static func getTypeID() -> CFTypeID {
		return IOHIDManagerGetTypeID()
	}
	
	/*!
	@function   IOHIDManagerCreate
	@abstract   Creates an IOHIDManager object.
	@discussion The IOHIDManager object is meant as a global management system
	for communicating with HID devices.
	@param      allocator Allocator to be used during creation.
	@param      options Supply @link kIOHIDManagerOptionUsePersistentProperties @/link to load
	properties from the default persistent property store. Otherwise supply
	@link kIOHIDManagerOptionNone @/link (or 0).
	@result     Returns a new IOHIDManagerRef.
	*/
	@available(OSX 10.5, *)
	public static func create(allocator: CFAllocator?, options: HIDOption) -> HIDManager {
		return HIDManager(with: IOHIDManagerCreate(allocator, options.value))
	}
	
	/*!
	@function   IOHIDManagerOpen
	@abstract   Opens the IOHIDManager.
	@discussion This will open both current and future devices that are
	enumerated. To establish an exclusive link use the
	kIOHIDOptionsTypeSeizeDevice option.
	@param      manager Reference to an IOHIDManager.
	@param      options Option bits to be sent down to the manager and device.
	@result     Returns kIOReturnSuccess if successful.
	*/
	@available(OSX 10.5, *)
	public func open(with options: HIDOption) -> Return {
		return Return(with: IOHIDManagerOpen(manager, options.value))
	}
	
	/*!
	@function   IOHIDManagerClose
	@abstract   Closes the IOHIDManager.
	@discussion This will also close all devices that are currently enumerated.
	@param      manager Reference to an IOHIDManager.
	@param      options Option bits to be sent down to the manager and device.
	@result     Returns kIOReturnSuccess if successful.
	*/
	@available(OSX 10.5, *)
	public func close(with options: HIDOption) -> Return {
		return Return(with: IOHIDManagerClose(manager, options.value))
	}
	
	/*!
	@function   IOHIDManagerGetProperty
	@abstract   Obtains a property of an IOHIDManager.
	@discussion Property keys are prefixed by kIOHIDDevice and declared in
	<IOKit/hid/IOHIDKeys.h>.
	@param      manager Reference to an IOHIDManager.
	@param      key CFStringRef containing key to be used when querying the
	manager.
	@result     Returns CFTypeRef containing the property.
	*/
	@available(OSX 10.5, *)
	/// ToDo: Find what keys are valid for a manager as opposed to a device and make a more limited enum
	public func getProperty(key: HIDDevicePropertyKey) -> AnyObject? {
		return IOHIDManagerGetProperty(manager, key.key as CFString)
	}
	
	/*!
	@function   IOHIDManagerSetProperty
	@abstract   Sets a property for an IOHIDManager.
	@discussion Property keys are prefixed by kIOHIDDevice and kIOHIDManager and
	declared in <IOKit/hid/IOHIDKeys.h>. This method will propagate
	any relevent properties to current and future devices that are
	enumerated.
	@param      manager Reference to an IOHIDManager.
	@param      key CFStringRef containing key to be used when modifiying the
	device property.
	@param      value CFTypeRef containing the property value to be set.
	@result     Returns TRUE if successful.
	*/
	@available(OSX 10.5, *)
	/// ToDo: Find what keys are valid for a manager as opposed to a device and make a more limited enum
	public func setProperty(_ value: AnyObject, forKey key: HIDDevicePropertyKey) -> Bool {
		return IOHIDManagerSetProperty(manager, key.key as CFString, value)
	}
	
	/*! @function   IOHIDManagerScheduleWithRunLoop
	@abstract   Schedules HID manager with run loop.
	@discussion Formally associates manager with client's run loop. Scheduling
	this device with the run loop is necessary before making use of
	any asynchronous APIs.  This will propagate to current and
	future devices that are enumerated.
	@param      manager Reference to an IOHIDManager.
	@param      runLoop RunLoop to be used when scheduling any asynchronous
	activity.
	@param      runLoopMode Run loop mode to be used when scheduling any
	asynchronous activity.
	*/
	@available(OSX 10.5, *)
	public func schedule(with runLoop: CFRunLoop, mode: CFRunLoopMode) {
		IOHIDManagerScheduleWithRunLoop(manager, runLoop, mode.rawValue)
	}
	
	/*! @function   IOHIDManagerUnscheduleFromRunLoop
	@abstract   Unschedules HID manager with run loop.
	@discussion Formally disassociates device with client's run loop. This will
	propagate to current devices that are enumerated.
	@param      manager Reference to an IOHIDManager.
	@param      runLoop RunLoop to be used when unscheduling any asynchronous
	activity.
	@param      runLoopMode Run loop mode to be used when unscheduling any
	asynchronous activity.
	*/
	@available(OSX 10.5, *)
	public func unschedule(from runLoop: CFRunLoop, mode: CFRunLoopMode) {
		IOHIDManagerUnscheduleFromRunLoop(manager, runLoop, mode.rawValue)
	}
	
	/*! @function   IOHIDManagerSetDeviceMatching
	@abstract   Sets matching criteria for device enumeration.
	@discussion Matching keys are prefixed by kIOHIDDevice and declared in
	<IOKit/hid/IOHIDKeys.h>.  Passing a NULL dictionary will result
	in all devices being enumerated. Any subsequent calls will cause
	the hid manager to release previously enumerated devices and
	restart the enuerate process using the revised criteria.  If
	interested in multiple, specific device classes, please defer to
	using IOHIDManagerSetDeviceMatchingMultiple.
	@param      manager Reference to an IOHIDManager.
	@param      matching CFDictionaryRef containg device matching criteria.
	*/
	@available(OSX 10.5, *)
	/// - ToDo: make a helper method with a builder object for the right kind of keys and values, typed.
	public func setDeviceMatching(single matching: Dictionary<HIDElementMatchKey, Any>?) {
		IOHIDManagerSetDeviceMatching(manager, matching?.ioHIDSafeDic)
	}
	
	/*! @function   IOHIDManagerSetDeviceMatchingMultiple
	@abstract   Sets multiple matching criteria for device enumeration.
	@discussion Matching keys are prefixed by kIOHIDDevice and declared in
	<IOKit/hid/IOHIDKeys.h>.  This method is useful if interested
	in multiple, specific device classes.
	@param      manager Reference to an IOHIDManager.
	@param      multiple CFArrayRef containing multiple CFDictionaryRef objects
	containg device matching criteria.
	*/
	@available(OSX 10.5, *)
	public func setDeviceMatching(multiple: [Dictionary<HIDElementMatchKey, Any>]?) {
		IOHIDManagerSetDeviceMatchingMultiple(manager, multiple?.map { $0.ioHIDSafeDic } as CFArray?)
	}
	
	/*! @function   IOHIDManagerCopyDevices
	@abstract   Obtains currently enumerated devices.
	@param      manager Reference to an IOHIDManager.
	@result     CFSetRef containing IOHIDDeviceRefs.
	*/
	@available(OSX 10.5, *)
	public func copyDevices() -> Set<HIDDevice>? {
		if let rawDevices = IOHIDManagerCopyDevices(manager) as? Set<IOHIDDevice> {
			return Set<HIDDevice>(rawDevices.map { HIDDevice(with: $0) })
		}
		return nil
	}
	
	/*! @function   IOHIDManagerRegisterDeviceMatchingCallback
	@abstract   Registers a callback to be used a device is enumerated.
	@discussion Only device matching the set criteria will be enumerated.
	@param      manager Reference to an IOHIDManagerRef.
	@param      callback Pointer to a callback method of type
	IOHIDDeviceCallback.
	@param      context Pointer to data to be passed to the callback.
	*/
	@available(OSX 10.5, *)
	public func register<Instance>(deviceMatchingCallback: IOHIDDeviceCallback?, context: Unmanaged<Instance>) {
		IOHIDManagerRegisterDeviceMatchingCallback(manager, deviceMatchingCallback, context.toOpaque())
	}
	
	/*! @function   IOHIDManagerRegisterDeviceRemovalCallback
	@abstract   Registers a callback to be used when any enumerated device is
	removed.
	@discussion In most cases this occurs when a device is unplugged.
	@param      manager Reference to an IOHIDManagerRef.
	@param      callback Pointer to a callback method of type
	IOHIDDeviceCallback.
	@param      context Pointer to data to be passed to the callback.
	*/
	@available(OSX 10.5, *)
	public func register<Instance>(deviceRemovalCallback: IOHIDDeviceCallback?, context: Unmanaged<Instance>) {
		IOHIDManagerRegisterDeviceRemovalCallback(manager, deviceRemovalCallback, context.toOpaque())
	}
	
	/*! @function   IOHIDManagerRegisterInputReportCallback
	@abstract   Registers a callback to be used when an input report is issued by
	any enumerated device.
	@discussion An input report is an interrupt driver report issued by a device.
	@param      manager Reference to an IOHIDManagerRef.
	@param      callback Pointer to a callback method of type IOHIDReportCallback.
	@param      context Pointer to data to be passed to the callback.
	*/
	@available(OSX 10.5, *)
	public func register<Instance>(inputReportCallback: IOHIDReportCallback?, context: Unmanaged<Instance>) {
		IOHIDManagerRegisterInputReportCallback(manager, inputReportCallback, context.toOpaque())
	}
	
	/*! @function   IOHIDManagerRegisterInputValueCallback
	@abstract   Registers a callback to be used when an input value is issued by
	any enumerated device.
	@discussion An input element refers to any element of type
	kIOHIDElementTypeInput and is usually issued by interrupt driven
	reports.
	@param      manager Reference to an IOHIDManagerRef.
	@param      callback Pointer to a callback method of type IOHIDValueCallback.
	@param      context Pointer to data to be passed to the callback.
	*/
	@available(OSX 10.5, *)
	public func register<Instance>(inputValueCallback: IOHIDValueCallback?, context: Unmanaged<Instance>) {
		IOHIDManagerRegisterInputValueCallback(manager, inputValueCallback, context.toOpaque())
	}
	
	/*! @function   IOHIDManagerSetInputValueMatching
	@abstract   Sets matching criteria for input values received via
	IOHIDManagerRegisterInputValueCallback.
	@discussion Matching keys are prefixed by kIOHIDElement and declared in
	<IOKit/hid/IOHIDKeys.h>.  Passing a NULL dictionary will result
	in all devices being enumerated. Any subsequent calls will cause
	the hid manager to release previously matched input elements and
	restart the matching process using the revised criteria.  If
	interested in multiple, specific device elements, please defer to
	using IOHIDManagerSetInputValueMatchingMultiple.
	@param      manager Reference to an IOHIDManager.
	@param      matching CFDictionaryRef containg device matching criteria.
	*/
	@available(OSX 10.5, *)
	public func setInputValue(matching: Dictionary<HIDElementMatchKey, Any>) {
		IOHIDManagerSetInputValueMatching(manager, matching.ioHIDSafeDic)
	}
	
	
	/*! @function   IOHIDManagerSetInputValueMatchingMultiple
	@abstract   Sets multiple matching criteria for input values received via
	IOHIDManagerRegisterInputValueCallback.
	@discussion Matching keys are prefixed by kIOHIDElement and declared in
	<IOKit/hid/IOHIDKeys.h>.  This method is useful if interested
	in multiple, specific elements .
	@param      manager Reference to an IOHIDManager.
	@param      multiple CFArrayRef containing multiple CFDictionaryRef objects
	containing input element matching criteria.
	*/
	@available(OSX 10.5, *)
	public func setInputValue(matchingMultiple: [Dictionary<HIDElementMatchKey, Any>]?) {
		IOHIDManagerSetInputValueMatchingMultiple(manager, matchingMultiple?.map { $0.ioHIDSafeDic } as CFArray?)
	}
	
	/*!
	@abstract   Used to write out the current properties to a specific domain.
	@discussion Using this function will cause the persistent properties to be saved out
	replacing any properties that already existed in the specified domain. All arguments
	must be non-NULL except options.
	@param     manager Reference to an IOHIDManager.
	@param     applicationID Reference to a CFPreferences applicationID.
	@param     userName Reference to a CFPreferences userName.
	@param     hostName Reference to a CFPreferences hostName.
	@param     options Reserved for future use.
	*/
	@available(OSX 10.6, *)
	public func saveToPropertyDomain(applicationID: String, userName: String, hostName: String, options: HIDOption) {
		IOHIDManagerSaveToPropertyDomain(manager, applicationID as CFString, userName as CFString, hostName as CFString, options.value)
	}
}

extension HIDManager: Equatable {
	
	// MARK: Equatable Implementation
	
	public static func ==(lhs: HIDManager, rhs: HIDManager) -> Bool {
		return lhs.manager == rhs.manager
	}
}

extension HIDManager: Hashable {
	
	// MARK: Hashable Implementation
	
	public var hashValue: Int {
		return manager.hashValue
	}
}
