//
//  HIDDevice.swift
//  JoyConManager
//
//  Created by James Linnell on 9/9/18.
//  Copyright © 2018 James Linnell. All rights reserved.
//

import Foundation
import IOKit
import IOKit.hid

/**
Wrapper for `IOHIDCallback`.

- Parameter result: The return result of the callback.
- Parameter sender: The HIDDevice that sent the report.
*/
public typealias HIDDeviceRemovalCallback = (_ result: Return, _ sender: HIDDevice) -> Void

/**
Wrapper for `IOHIDValueCallback`.

- Parameter result: The return result of the callback.
- Parameter sender: The HIDQueue that sent the value.
- Parameter hidValue: The returned `HIDValue`.
*/
public typealias HIDDeviceInputValueCallback = (_ result: Return, _ sender: HIDQueue, _ hidValue: HIDValue) -> Void

/**
Wrapper for `IOHIDReportCallback`.

- Parameter context: A variable that, when registered with the `HIDDevice`, will be returned in the callback.
- Parameter result: The return result of the callback.
- Parameter sender: The HIDDevice that sent the report.
- Parameter type: The ReportType of the report.
- Parameter reportID: The report's ID.
- Parameter report: The report data.
*/
public typealias HIDDeviceInputReportCallback = (_ result: Return, _ sender: HIDDevice, _ type: HIDReportType, _ reportID: UInt32, _ report: [UInt8]) -> Void

public typealias HIDDeviceInputReportWithTimestampCallback = (_ result: Return, _ sender: HIDDevice, _ type: HIDReportType, _ rpeortID: UInt32, _ report: [UInt8], _ timestamp: UInt64) -> Void

public class HIDDevice {
	
	// MARK: Initialization
	
	let device: IOHIDDevice
	
	public init(with device: IOHIDDevice) {
		self.device = device
		
		reportBuffer = [UInt8](repeating: 0, count: self.maxInputReportSize ?? 0)
		reportWithTimestampBuffer = [UInt8](repeating: 0, count: self.maxInputReportSize ?? 0)
	}
	
	// MARK: Callback Properties
	
	private var registeredRemovalCallbacks: [HIDDeviceRemovalCallback] = []
	private var registeredInputValueCallbacks: [HIDDeviceInputValueCallback] = []
	
	private var reportBuffer: [UInt8]!
	private var registeredInputReportCallbacks: [HIDDeviceInputReportCallback] = []
	private var reportWithTimestampBuffer: [UInt8]!
	private var registeredInputReportWithTimestampsCallbacks: [HIDDeviceInputReportWithTimestampCallback] = []
	
	
	deinit {
		let context = Unmanaged.passUnretained(self)
		
		// Unregister static callback functions
		self.register(removalCallback: nil, context: context)
		self.register(inputValueCallback: nil, context: context)
		var temp: UInt8 = 0
		self.register(inputReportCallback: nil, context: context, report: &temp, reportLength: 0)
		self.register(inputReportWithTimeStampCallback: nil, context: context, report: &temp, reportLength: 0)
	}
	
	// MARK: Swift-friendly Callbacks
	
	private lazy var setupRemovalCallback: Void = {
		let context = Unmanaged.passUnretained(self)
		
		let removalCallback: IOHIDCallback = {
			context, result, sender in
			let this = Unmanaged<HIDDevice>.fromOpaque(context!).takeUnretainedValue()
			let deviceSender = Unmanaged<IOHIDDevice>.fromOpaque(sender!).takeUnretainedValue()
			let device = deviceSender === this.device ? this : HIDDevice(with: deviceSender)
			
			for callback in this.registeredRemovalCallbacks {
				callback(Return(with: result), device)
			}
		}
		self.register(removalCallback: removalCallback, context: context)
	}()
	
	public func register(removalCallback: @escaping HIDDeviceRemovalCallback) {
		_ = setupRemovalCallback
		registeredRemovalCallbacks.append(removalCallback)
	}
	
	private lazy var setupInputValueCallback: Void = {
		let context = Unmanaged.passUnretained(self)
		
		let inputValueCallback: IOHIDValueCallback = {
			context, result, sender, value in
			let this = Unmanaged<HIDDevice>.fromOpaque(context!).takeUnretainedValue()
			let queueSender = Unmanaged<IOHIDQueue>.fromOpaque(sender!).takeUnretainedValue()
			
			for callback in this.registeredInputValueCallbacks {
				callback(Return(with: result), HIDQueue(with: queueSender), HIDValue(with: value))
			}
		}
		self.register(inputValueCallback: inputValueCallback, context: context)
	}()
	
	public func register(inputValueCallback: @escaping HIDDeviceInputValueCallback) {
		_ = setupInputValueCallback
		registeredInputValueCallbacks.append(inputValueCallback)
	}
	
	private lazy var setupInputReportCallback: Void = {
		let context = Unmanaged.passUnretained(self)
		
		let inputReportCallback: IOHIDReportCallback = {
			context, result, sender, type, reportID, report, reportLength in
			let this = Unmanaged<HIDDevice>.fromOpaque(context!).takeUnretainedValue()
			let deviceSender = Unmanaged<IOHIDDevice>.fromOpaque(sender!).takeUnretainedValue()
			let device = deviceSender === this.device ? this : HIDDevice(with: deviceSender)
			
			if this.registeredInputReportCallbacks.count > 0 {
				let reportArray = Utils.createArray(pointer: report, length: reportLength)
				
				for callback in this.registeredInputReportCallbacks {
					callback(Return(with: result), device, HIDReportType(with: type), reportID, reportArray)
				}
			}
		}
		self.reportBuffer.withUnsafeMutableBufferPointer {
			buffer in
			self.register(inputReportCallback: inputReportCallback, context: context, report: buffer.baseAddress!, reportLength: buffer.count)
		}
	}()
	
	public func register(inputReportCallback: @escaping HIDDeviceInputReportCallback) {
		_ = setupInputReportCallback
		registeredInputReportCallbacks.append(inputReportCallback)
	}
	
	private lazy var setupInputReportWithTimestampCallback: Void = {
		let context = Unmanaged.passUnretained(self)
		
		let inputReportWithTimestampCallback: IOHIDReportWithTimeStampCallback = {
			context, result, sender, type, reportID, report, reportLength, timestamp in
			let this = Unmanaged<HIDDevice>.fromOpaque(context!).takeUnretainedValue()
			let deviceSender = Unmanaged<IOHIDDevice>.fromOpaque(sender!).takeUnretainedValue()
			let device = deviceSender === this.device ? this : HIDDevice(with: deviceSender)
			
			if this.registeredInputReportWithTimestampsCallbacks.count > 0 {
				let reportArray = Utils.createArray(pointer: report, length: reportLength)
				
				for callback in this.registeredInputReportWithTimestampsCallbacks {
					callback(Return(with: result), device, HIDReportType(with: type), reportID, reportArray, timestamp)
				}
			}
		}
		self.reportWithTimestampBuffer.withUnsafeMutableBufferPointer {
			buffer in
			self.register(inputReportWithTimeStampCallback: inputReportWithTimestampCallback, context: context, report: buffer.baseAddress!, reportLength: buffer.count)
		}
	}()
	
	public func register(inputReportWithTimestampCallback: @escaping HIDDeviceInputReportWithTimestampCallback) {
		_ = setupInputReportWithTimestampCallback
		registeredInputReportWithTimestampsCallbacks.append(inputReportWithTimestampCallback)
	}
}

extension HIDDevice {
	
	// MARK: IOHIDDevice Methods
	
	/**
	 Returns the type identifier of all `HIDDevice` instances
	 */
	@available(OSX 10.5, *)
	static func getTypeID() -> CFTypeID {
		return IOHIDDeviceGetTypeID()
	}
	
	/**
	 Creates an element from an `io_service_t`.
	 
	 The `io_service_t` passed in this method must reference an object
	 in the kernel of type `HIDDevice`.

	 - Parameter allocator: Allocation to be used during creation.
	 - Parameter service: Reference to service object in the kernel.
	 - Returns: Returns a new `HIDDevice`
	 */
	@available(OSX 10.5, *)
	static public func create(allocator: Allocator, service: io_service_t) -> HIDDevice? {
		if let device = IOHIDDeviceCreate(allocator.value, service) {
			return HIDDevice(with: device)
		} else {
			return nil
		}
	}
	
	/**
	 Returns the `io_service_t` for an `HIDDevice`, if it has one.
	 
	 If the `HIDDevice` references an object in the kernel, this is used to get the `io_service_t` for that object.
	 
	 - Returns: Returns the `io_service_t` if the `HIDDevice` has one, or `MACH_PORT_NULL` if it does not.
	 */
	@available(OSX 10.6, *)
	public func getService() -> io_service_t {
		return IOHIDDeviceGetService(device)
	}
	
	/**
	 Opens an `HIDDevice` for communication.
	 
	 Before the client can issue commands that change the state of the device, it must have succeeded in opening the device. This establishes a link between the client's task and the actual device. To establish an exclusive link use the `HIDOption.seizeDevice` option.
	 
	 - Parameter options: Option bits to be sent down to the device.
	 - Returns: `Return.success` if successful.
	 */
	@available(OSX 10.5, *)
	public func open(with options: HIDOption) -> Return {
		return Return(with: IOHIDDeviceOpen(device, options.value))
	}
	
	/**
	 Closes communication with a `HIDDevice`.
	 
	 This closes a link between the client's task and the actual device.
	 
	 - Parameter options: Option bits to be sent down to the device.
	 - Returns: `Return.success` if successful.
	 */
	@available(OSX 10.5, *)
	public func close(with options: HIDOption) -> Return {
		return Return(with: IOHIDDeviceClose(device, options.value))
	}
	
	/**
	 Convenience function that scans the Application Collection elements to see if it conforms to the provided usage page and usage.
	 
	 Examples of Application Collection usages pairs are:
	 ```
	 usage = GenericDesktopUsage.mouse
	 ```
	 
	 - Parameter usage: Device usage page and usage
	 - Returns: True if device conforms to provided usage.
	 */
	@available(OSX 10.5, *)
	public func conforms(to usage: UsagePageUsage) -> Bool {
		return IOHIDDeviceConformsTo(device, UInt32(usage.usagePage), UInt32(usage.usage))
	}
	
	/**
	 Obtains a property from an `HIDDevice`.
	 
	 - ToDo: Enumerate all possible return types for better safety and usage.
	 
	 - Parameter key: `HIDDevicePropertyKey` containing key to be used when querying the device.
	 - Returns: CFTypeRef containing the property.
	 */
	@available(OSX 10.5, *)
	public func getProperty(key: HIDDevicePropertyKey) -> AnyObject? {
		return IOHIDDeviceGetProperty(device, key.key as CFString)
	}
	
	/**
	 Sets a property for an `HIDDevice`.
	 
	 - ToDo: Enumerate all possible return types for better safety and usage.
	 
	 - Parameter key: `HIDDevicePropertyKey` containing key to be used when modifiying the device property.
	 - Parameter property: `CFTypeRef` containing the property to be set.
	 - Returns: True if successful.
	 */
	@available(OSX 10.5, *)
	public func setProperty(_ property: AnyObject, forKey key: HIDDevicePropertyKey) -> Bool {
		return IOHIDDeviceSetProperty(device, key.key as CFString, property)
	}
	
	/**
	 Obtains `HIDElements` that match the criteria contained in the matching dictionary.
	 
	 - Parameter matching: CFDictionaryRef containg element matching criteria.
	 - Parameter options: Reserved for future use.
	 - Returns: CFArrayRef containing multiple IOHIDElement object.
	 */
	@available(OSX 10.5, *)
	public func copyElements(matching: Dictionary<HIDElementMatchKey, Any>?, options: HIDOption) -> [HIDElement] {
		let cfArray = IOHIDDeviceCopyMatchingElements(device, matching?.ioHIDSafeDic, options.value)
		
		if let cfElements = cfArray {
			if let elements = cfElements as? [IOHIDElement] {
				return elements.map { HIDElement(with: $0) }
			}
		}
		
		return []
	}
	
	/**
	 Schedules HID device with run loop.
	 
	 Formally associates device with client's run loop. Scheduling this device with the run loop is necessary before making use of any asynchronous APIs.
	 
	 - ToDo: Convert CFRunLoop and the run loop mode types.
	 
	 - Parameter runLoop: RunLoop to be used when scheduling any asynchronous activity.
	 - Parameter runLoopMode: Run loop mode to be used when scheduling any asynchronous activity.
	 */
	@available(OSX 10.5, *)
	public func schedule(with runLoop: CFRunLoop, mode: CFRunLoopMode) {
		IOHIDDeviceScheduleWithRunLoop(device, runLoop, mode.rawValue)
	}
	
	/**
	 Unschedules `HIDDevice` with run loop.
	 
	 Formally disassociates device with client's run loop.
	 
	 - Parameter runLoop: RunLoop to be used when unscheduling any asynchronous activity.
	 - Parameter runLoopMode: Run loop mode to be used when unscheduling any asynchronous activity.
	 */
	@available(OSX 10.5, *)
	public func unschedule(from runLoop: CFRunLoop, mode: CFRunLoopMode) {
		IOHIDDeviceUnscheduleFromRunLoop(device, runLoop, mode.rawValue)
	}
	
	/**
	 Registers a callback to be used when an `HIDDevice` is removed.
	 
	 In most cases this occurs when a device is unplugged.
	
	 - Multiple callbacks may be registered, keyed by the context.
	 - To unregister, pass the same context but a nil callback.
	 
	 - Parameter callback: Pointer to a callback method of type `HIDCallback`.
	 - Parameter context: Pointer to data to be passed to the callback.
	 */
	@available(OSX 10.5, *)
	public func register<Instance>(removalCallback callback: IOHIDCallback?, context: Unmanaged<Instance>) {
		IOHIDDeviceRegisterRemovalCallback(device, callback, context.toOpaque())
	}
	
	/**
	 Registers a callback to be used when an input value is issued by the device.
	
	 An input element refers to any element of type	kIOHIDElementTypeInput and is usually issued by interrupt driven
	reports. If more specific element values are desired, you can
	specify matching criteria via IOHIDDeviceSetInputValueMatching
	and IOHIDDeviceSetInputValueMatchingMultiple.
	
	 - Multiple callbacks may be registered, keyed by the context.
	 - To unregister, pass the same context but a nil callback.
	
	 - Parameter callback: Pointer to a callback method of type IOHIDValueCallback.
	 - Parameter context: Pointer to data to be passed to the callback.
	 */
	@available(OSX 10.5, *)
	public func register<Instance>(inputValueCallback callback: IOHIDValueCallback?, context: Unmanaged<Instance>) {
		IOHIDDeviceRegisterInputValueCallback(device, callback, context.toOpaque())
	}
	
	/**
	 Registers a callback to be used when an input report is issued
	by the device.
	
	 An input report is an interrupt driver report issued by the
	device.
	
	- Multiple callbacks may be registered, keyed by the context.
	- To unregister, pass the same context but a nil callback.
	
	- Parameter callback: Pointer to a callback method of type IOHIDReportCallback.
	- Parameter report: Pointer to preallocated buffer in which to copy inbound report data.
	- Parameter reportLength: Length of preallocated buffer.
	- Parameter context: Pointer to data to be passed to the callback.
	 */
	@available(OSX 10.5, *)
	public func register<Instance>(inputReportCallback: IOHIDReportCallback?, context: Unmanaged<Instance>, report: UnsafeMutablePointer<UInt8>, reportLength: CFIndex) {
		IOHIDDeviceRegisterInputReportCallback(device, report, reportLength, inputReportCallback, context.toOpaque())
	}
	
	/**
	 Registers a timestamped callback to be used when an input report is issued
	by the device.
	
	 An input report is an interrupt driver report issued by the
	device.
	
	- Multiple callbacks may be registered, keyed by the context.
	- To unregister, pass the same context but a nil callback.
	
	- Parameter callback: Pointer to a callback method of type IOHIDReportWithTimeStampCallback.
	- Parameter report: Pointer to preallocated buffer in which to copy inbound report data.
	- Parameter reportLength: Length of preallocated buffer.
	- Parameter context: Pointer to data to be passed to the callback.
	 */
	@available(OSX 10.10, *)
	public func register<Instance>(inputReportWithTimeStampCallback callback: IOHIDReportWithTimeStampCallback?, context: Unmanaged<Instance>, report: UnsafeMutablePointer<UInt8>, reportLength: CFIndex) {
		IOHIDDeviceRegisterInputReportWithTimeStampCallback(device, report, reportLength, callback, context.toOpaque())
	}
	
	/**
	 Sets matching criteria for input values received via
	IOHIDDeviceRegisterInputValueCallback.
	
	 Matching keys are prefixed by kIOHIDElement and declared in
	<IOKit/hid/IOHIDKeys.h>.  Passing a NULL dictionary will result
	in all devices being enumerated. Any subsequent calls will cause
	the hid manager to release previously matched input elements and
	restart the matching process using the revised criteria.  If
	interested in multiple, specific device elements, please defer to
	using IOHIDDeviceSetInputValueMatchingMultiple.
	
	- Parameter matching: CFDictionaryRef containg device matching criteria.
	 */
	@available(OSX 10.5, *)
	public func setInputValue(matching: Dictionary<HIDElementMatchKey, Any>?) {
		IOHIDDeviceSetInputValueMatching(device, matching?.ioHIDSafeDic)
	}
	
	/**
	 Sets multiple matching criteria for input values received via
	IOHIDDeviceRegisterInputValueCallback.
	
	 Matching keys are prefixed by kIOHIDElement and declared in
	<IOKit/hid/IOHIDKeys.h>.  This method is useful if interested
	in multiple, specific elements .
	
	- Parameter multiple: CFArrayRef containing multiple CFDictionaryRef objects
	containg input element matching criteria.
	 */
	@available(OSX 10.5, *)
	public func setInputValue(matchingMultiple: [Dictionary<HIDElementMatchKey, Any>]?) {
		IOHIDDeviceSetInputValueMatchingMultiple(device, matchingMultiple?.map { $0.ioHIDSafeDic } as CFArray?)
	}
	
	/**
	 Sets a value for an element.
	
	 This method behaves synchronously and will block until the
	report has been issued to the device.  It is only relevent for
	either output or feature type elements.  If setting values for
	multiple elements you may want to consider using
	IOHIDDeviceSetValueMultiple or IOHIDTransaction.
	
	- Parameter element: IOHIDElementRef whose value is to be modified.
	- Parameter value: IOHIDValueRef containing value to be set.
	- Returns: kIOReturnSuccess if successful.
	 */
	@available(OSX 10.5, *)
	public func setValue(element: HIDElement, value: HIDValue) -> Return {
		return Return(with: IOHIDDeviceSetValue(device, element.element, value.value))
	}
	
	/**
	 Sets multiple values for multiple elements.
	
	 This method behaves synchronously and will block until the
	report has been issued to the device.  It is only relevent for
	either output or feature type elements.
	
	- Parameter multiple: CFDictionaryRef where key is IOHIDElementRef and
	value is IOHIDValueRef.
	- Returns: kIOReturnSuccess if successful.
	 */
	@available(OSX 10.5, *)
	public func setValue(multiple: Dictionary<HIDElement, HIDValue>) -> Return {
		var dic: Dictionary<IOHIDElement, IOHIDValue> = [:]
		for (el, val) in multiple {
			dic[el.element] = val.value
		}
		
		return Return(with: IOHIDDeviceSetValueMultiple(device, dic as CFDictionary))
	}
	
	/**
	 Sets a value for an element and returns status via a completion
	callback.
	
	 This method behaves asynchronously and will invoke the callback
	once the report has been issued to the device.  It is only
	relevent for either output or feature type elements.
	If setting values for multiple elements you may want to
	consider using IOHIDDeviceSetValueWithCallback or
	IOHIDTransaction.
	
	- Parameter element: IOHIDElementRef whose value is to be modified.
	- Parameter value: IOHIDValueRef containing value to be set.
	- Parameter timeout: CFTimeInterval containing the timeout.
	- Parameter callback: Pointer to a callback method of type
	IOHIDValueCallback.
	- Parameter context: Pointer to data to be passed to the callback.
	- Returns: kIOReturnSuccess if successful.
	 */
	@available(OSX 10.5, *)
	public func setValue<Instance>(element: HIDElement, value: HIDValue, timeout: TimeInterval, withCallback callback: IOHIDValueCallback?, context: Unmanaged<Instance>) -> Return {
		return Return(with: IOHIDDeviceSetValueWithCallback(device, element.element, value.value, timeout, callback, context.toOpaque()))
	}
	
	/**
	 Sets multiple values for multiple elements and returns status
	via a completion callback.
	
	 This method behaves asynchronously and will invoke the callback
	once the report has been issued to the device.  It is only
	relevent for either output or feature type elements.
	
	- Parameter multiple: CFDictionaryRef where key is IOHIDElementRef and
	value is IOHIDValueRef.
	- Parameter timeout: CFTimeInterval containing the timeout.
	- Parameter callback: Pointer to a callback method of type
	IOHIDValueMultipleCallback.
	- Parameter context: Pointer to data to be passed to the callback.
	- Returns: kIOReturnSuccess if successful.
	 */
	@available(OSX 10.5, *)
	public func setValue<Instance>(multiple: Dictionary<HIDElement, HIDValue>, timeout: TimeInterval, withCallback callback: IOHIDValueMultipleCallback?, context: Unmanaged<Instance>) {
		var dic: Dictionary<IOHIDElement, IOHIDValue> = [:]
		for (el, val) in multiple {
			dic[el.element] = val.value
		}
		
		IOHIDDeviceSetValueMultipleWithCallback(device, dic as CFDictionary, timeout, callback, context.toOpaque())
	}
	
	/**
	 Gets a value for an element.
	
	 This method behaves synchronously and return back immediately
	for input type element.  If requesting a value for a feature
	element, this will block until the report has been issued to the
	device.  If obtaining values for multiple elements you may want
	to consider using IOHIDDeviceCopyValueMultiple or IOHIDTransaction.
	
	- Parameter element: IOHIDElementRef whose value is to be obtained.
	- Parameter pValue: Pointer to IOHIDValueRef to be obtained.
	- Returns: kIOReturnSuccess if successful.
	 */
	@available(OSX 10.5, *)
	/// - ToDo: Is this going to work correctly?
	public func getValue(element: HIDElement) -> (HIDValue?, Return) {
		// Create a dummy value so Swift will let us get an unmanaged instance to it to pass in
		let value: IOHIDValue = IOHIDValueCreateWithIntegerValue(nil, element.element, 0, 0)
		var unmanagedValue = Unmanaged.passUnretained(value)
		let ioReturn = IOHIDDeviceGetValue(device, element.element, &unmanagedValue)
		return (HIDValue(with: value), Return(with: ioReturn))
	}
	
	/**
	 Copies a values for multiple elements.
	
	 This method behaves synchronously and return back immediately
	for input type element.  If requesting a value for a feature
	element, this will block until the report has been issued to the
	device.
	
	- Parameter elements: CFArrayRef containing multiple IOHIDElementRefs whose
	values are to be obtained.
	- Parameter pMultiple: Pointer to CFDictionaryRef where the keys are the
	provided elements and the values are the requested values.
	- Returns: kIOReturnSuccess if successful.
	 */
//	@available(OSX 10.5, *)
	/// - ToDo: Is this going to work correctly?
//	public func copyValueMultiple(elements: [HIDElement]) -> (Dictionary<HIDElement, HIDValue>?, Return) {
//		let dic: CFDictionary
//		var unmanagedDic: Unmanaged<CFDictionary>? = Unmanaged<CFDictionary>.passUnretained(dic)
//		let ioReturn = IOHIDDeviceCopyValueMultiple(device, elements.map { $0.element } as CFArray, &unmanagedDic)
//
//		var resultDic: Dictionary<HIDElement, HIDValue>? = nil
//		if let typedDic = dic as? Dictionary<IOHIDElement, IOHIDValue> {
//			var resultDicTemp = Dictionary<HIDElement, HIDValue>()
//			for (el, val) in typedDic {
//				resultDicTemp[HIDElement(with: el)] = HIDValue(with: val)
//			}
//			resultDic = resultDicTemp
//		}
//		return (resultDic, Return(with: ioReturn))
//	}
	
	/**
	 Gets a value for an element and returns status via a completion
	callback.
	
	 This method behaves asynchronusly and is only relevent for
	either output or feature type elements. If obtaining values for
	multiple elements you may want to consider using
	IOHIDDeviceCopyValueMultipleWithCallback or IOHIDTransaction.
	
	- Parameter element: IOHIDElementRef whose value is to be obtained.
	- Parameter pValue: Pointer to IOHIDValueRef to be passedback.
	- Parameter timeout: CFTimeInterval containing the timeout.
	- Parameter callback: Pointer to a callback method of type
	IOHIDValueCallback.
	- Parameter context: Pointer to data to be passed to the callback.
	- Returns: kIOReturnSuccess if successful.
	 */
//	@available(OSX 10.5, *)
//	public func IOHIDDeviceGetValueWithCallback(_ device: IOHIDDevice, _ element: IOHIDElement, _ pValue: UnsafeMutablePointer<Unmanaged<IOHIDValue>>, _ timeout: CFTimeInterval, _ callback: IOKit.IOHIDValueCallback?, _ context: UnsafeMutableRawPointer?) -> IOReturn
	
	/**
	 Copies a values for multiple elements and returns status via a
	completion callback.
	
	 This method behaves asynchronusly and is only relevent for
	either output or feature type elements.
	
	- Parameter elements: CFArrayRef containing multiple IOHIDElementRefs whose
	values are to be obtained.
	- Parameter pMultiple: Pointer to CFDictionaryRef where the keys are the
	provided elements and the values are the requested values.
	- Parameter timeout: CFTimeInterval containing the timeout.
	- Parameter callback: Pointer to a callback method of type
	IOHIDValueMultipleCallback.
	- Parameter context: Pointer to data to be passed to the callback.
	- Returns: kIOReturnSuccess if successful.
	 */
//	@available(OSX 10.5, *)
//	public func IOHIDDeviceCopyValueMultipleWithCallback(_ device: IOHIDDevice, _ elements: CFArray, _ pMultiple: UnsafeMutablePointer<Unmanaged<CFDictionary>?>?, _ timeout: CFTimeInterval, _ callback: IOKit.IOHIDValueMultipleCallback?, _ context: UnsafeMutableRawPointer?) -> IOReturn
	
	/**
	 Sends a report to the device.
	
	 This method behaves synchronously and will block until the
	report has been issued to the device.  It is only relevent for
	either output or feature type reports.
	
	- Parameter reportType: Type of report being sent.
	- Parameter reportID: ID of the report being sent.  If the device supports
	multiple reports, this should also be set in the first byte of
	the report.
	- Parameter report: The report bytes to be sent to the device.
	- Parameter reportLength: The length of the report to be sent to the device.
	- Returns: kIOReturnSuccess if successful.
	 */
	@available(OSX 10.5, *)
	public func setReport(type: HIDReportType, reportID: CFIndex, report: UnsafePointer<UInt8>, reportLength: CFIndex) -> Return {
		return Return(with: IOHIDDeviceSetReport(device, type.value, reportID, report, reportLength))
	}
	
	/**
	 Sends a report to the device.
	
	 This method behaves asynchronously and will block until the
	report has been issued to the device.  It is only relevent for
	either output or feature type reports.
	
	- Parameter reportType: Type of report being sent.
	- Parameter reportID: ID of the report being sent.  If the device supports
	multiple reports, this should also be set in the first byte of
	the report.
	- Parameter report: The report bytes to be sent to the device.
	- Parameter reportLength: The length of the report to be sent to the device.
	- Parameter timeout: CFTimeInterval containing the timeout.
	- Parameter callback: Pointer to a callback method of type IOHIDReportCallback.
	- Parameter context: Pointer to data to be passed to the callback.
	- Returns: kIOReturnSuccess if successful.
	 */
	@available(OSX 10.5, *)
	public func setReport<Instance>(withCallback callback: IOHIDReportCallback?, context: Unmanaged<Instance>, reportType: HIDReportType, reportID: CFIndex, report: UnsafePointer<UInt8>, reportLength: CFIndex, timeout: TimeInterval) -> Return {
		return Return(with: IOHIDDeviceSetReportWithCallback(device, reportType.value, reportID, report, reportLength, timeout, callback, context.toOpaque()))
	}
	
	/**
	 Obtains a report from the device.
	
	 This method behaves synchronously and will block until the
	report has been received from the device.  This is only intended
	for feature reports because of sporadic devicesupport for
	polling input reports.  Please defer to using
	IOHIDDeviceRegisterInputReportCallback for obtaining input
	reports.
	
	- Parameter reportType: Type of report being requested.
	- Parameter reportID: ID of the report being requested.
	- Parameter report: Pointer to preallocated buffer in which to copy inbound report data.
	- Parameter pReportLength: Pointer to length of preallocated buffer.  This
	value will be modified to refect the length of the returned report.
	- Returns: kIOReturnSuccess if successful.
	 */
	@available(OSX 10.5, *)
	public func getReport(reportType: HIDReportType, reportID: CFIndex, report: UnsafeMutablePointer<UInt8>, reportLength: inout CFIndex) -> Return {
		let ioReturn = IOHIDDeviceGetReport(device, reportType.value, reportID, report, &reportLength)
		return Return(with: ioReturn)
	}
	
	/**
	 Obtains a report from the device.
	
	 This method behaves asynchronously and will block until the
	report has been received from the device.  This is only intended
	for feature reports because of sporadic devicesupport for
	polling input reports.  Please defer to using
	IOHIDDeviceRegisterInputReportCallback for obtaining input
	reports.
	
	- Parameter reportType: Type of report being requested.
	- Parameter reportID: ID of the report being requested.
	- Parameter report: Pointer to preallocated buffer in which to copy inbound report data.
	- Parameter pReportLength: Pointer to length of preallocated buffer.
	- Parameter pReportLength: Pointer to length of preallocated buffer.  This
	value will be modified to refect the length of the returned report.
	- Parameter callback: Pointer to a callback method of type IOHIDReportCallback.
	- Parameter context: Pointer to data to be passed to the callback.
	- Returns: kIOReturnSuccess if successful.
	 */
//	@available(OSX 10.5, *)
//	public func IOHIDDeviceGetReportWithCallback(_ device: IOHIDDevice, _ reportType: IOHIDReportType, _ reportID: CFIndex, _ report: UnsafeMutablePointer<UInt8>, _ pReportLength: UnsafeMutablePointer<CFIndex>, _ timeout: CFTimeInterval, _ callback: @escaping IOKit.IOHIDReportCallback, _ context: UnsafeMutableRawPointer) -> IOReturn
}

extension HIDDevice: HIDDevicePropertyable {
	// MARK: HIDDevicePropertyable Implementation
	
	public var transport: String? {
		return getProperty(key: .transport) as! String?
	}
	
	public var vendorID: Int? {
		return getProperty(key: .vendorID) as! Int?
	}
	
	public var vendorIDSource: Int? {
		return getProperty(key: .vendorIDSource) as! Int?
	}
	
	public var productID: Int? {
		return getProperty(key: .productID) as! Int?
	}
	
	public var versionNumber: Int? {
		return getProperty(key: .versionNumber) as! Int?
	}
	
	public var manufacturer: String? {
		return getProperty(key: .manufacturer) as! String?
	}
	
	public var product: String? {
		return getProperty(key: .product) as! String?
	}
	
	public var serialNumber: String? {
		return getProperty(key: .serialNumber) as! String?
	}
	
	public var countryCode: Int? {
		return getProperty(key: .countryCode) as! Int?
	}
	
	public var standardType: AnyObject? {
		return getProperty(key: .standardType)
	}
	
	public var locationID: Int? {
		return getProperty(key: .locationID) as! Int?
	}
	
	public var deviceUsagePairs: [Usage]? {
		if let pairs = getProperty(key: .deviceUsagePairs) as? Array<Dictionary<String, Int>> {
			return pairs.filter {
				return $0[kIOHIDDeviceUsageKey] != nil && $0[kIOHIDDeviceUsagePageKey] != nil
			}.map {
				return Usage(withUsagePage: $0[kIOHIDDeviceUsageKey]!, usage: $0[kIOHIDDeviceUsagePageKey]!)
			}
		}
		return nil
	}
	
	public var primaryUsage: Usage? {
		guard let pUsagePage = getProperty(key: .primaryUsagePage) as? Int,
			let pUsage = getProperty(key: .primaryUsage) as? Int else {
				return nil
		}
		return Usage(withUsagePage: pUsagePage, usage: pUsage)
	}
	
	public var maxInputReportSize: Int? {
		return getProperty(key: .maxInputReportSize) as! Int?
	}
	
	public var maxOutputReportSize: Int? {
		return getProperty(key: .maxOutputReportSize) as! Int?
	}
	
	public var maxFeatureReportSize: Int? {
		return getProperty(key: .maxFeatureReportSize) as! Int?
	}
	
	public var reportInterval: Int? {
		return getProperty(key: .reportInterval) as! Int?
	}
	
	public var sampleInterval: AnyObject? {
		return getProperty(key: .sampleInterval)
	}
	
	public var batchInterval: AnyObject? {
		return getProperty(key: .batchInterval)
	}
	
	public var requestTimeout: AnyObject? {
		return getProperty(key: .requestTimeout)
	}
	
	public var reportDescriptor: Data? {
		return getProperty(key: .reportDescriptor) as? Data
	}
	
	public var reset: AnyObject? {
		return getProperty(key: .reset)
	}
	
	public var keyboardLanguage: AnyObject? {
		return getProperty(key: .keyboardLanguage)
	}
	
	public var altHandlerId: Int? {
		return getProperty(key: .altHandlerId) as! Int?
	}
	
	public var builtIn: Bool? {
		return getProperty(key: .builtIn) as! Bool?
	}
	
	public var displayIntegrated: AnyObject? {
		return getProperty(key: .displayIntegrated)
	}
	
	public var productIDMask: AnyObject? {
		return getProperty(key: .productIDMask)
	}
	
	public var productIDArray: AnyObject? {
		return getProperty(key: .productIDArray)
	}
	
	public var powerOnDelayNS: AnyObject? {
		return getProperty(key: .powerOnDelayNS)
	}
	
	public var category: AnyObject? {
		return getProperty(key: .category)
	}
	
	public var maxResponseLatency: AnyObject? {
		return getProperty(key: .maxResponseLatency)
	}
	
	public var uniqueID: Int? {
		return getProperty(key: .uniqueID) as! Int?
	}
	
	public var physicalDeviceUniqueID: AnyObject? {
		return getProperty(key: .physicalDeviceUniqueID)
	}
}

extension HIDDevice: Equatable {
	static public func ==(lhs: HIDDevice, rhs: HIDDevice) -> Bool {
		return lhs.device == rhs.device
	}
}

extension HIDDevice: Hashable {
	public var hashValue: Int {
		return device.hashValue
	}
}
