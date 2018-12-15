//
//  HIDQueue.swift
//  SwiftyHID
//
//  Created by James Linnell on 9/29/18.
//  Copyright © 2018 James Linnell. All rights reserved.
//

import Foundation
import IOKit

public class HIDQueue {
	
	let queue: IOHIDQueue
	
	init(with queue: IOHIDQueue) {
		self.queue = queue
	}
}

extension HIDQueue {
	
	// MARK: IOHIDQueue Methods
	
	/*!
	@function   IOHIDQueueCreate
	@abstract   Creates an IOHIDQueue object for the specified device.
	@discussion Take care in specifying an appropriate depth to prevent dropping
	events.
	@param      allocator Allocator to be used during creation.
	@param      device IOHIDDevice object
	@param      depth The number of values that can be handled by the queue.
	@param      options Reserved for future use.
	@result     Returns a new IOHIDQueueRef.
	*/
	@available(OSX 10.5, *)
	public func create(allocator: CFAllocator?, device: HIDDevice, depth: Int, options: HIDOption) -> HIDQueue? {
		if let queue = IOHIDQueueCreate(allocator, device.device, depth, options.value) {
			return HIDQueue(with: queue)
		}
		return nil
	}
	
	/*!
	@function   IOHIDQueueGetDevice
	@abstract   Obtain the device associated with the queue.
	@param      queue IOHIDQueue to be queried.
	@result     Returns the a reference to the device.
	*/
	@available(OSX 10.5, *)
	public func getDevice() -> HIDDevice {
		return HIDDevice(with: IOHIDQueueGetDevice(queue))
	}
	
	/*!
	@function   IOHIDQueueGetDepth
	@abstract   Obtain the depth of the queue.
	@param      queue IOHIDQueue to be queried.
	@result     Returns the queue depth.
	*/
	@available(OSX 10.5, *)
	public func getDepth() -> Int {
		return IOHIDQueueGetDepth(queue)
	}
	
	/*!
	@function   IOHIDQueueSetDepth
	@abstract   Sets the depth of the queue.
	@discussion Set the appropriate depth value based on the number of elements
	contained in a queue.
	@param      queue IOHIDQueue object to be modified.
	@param      depth The new queue depth.
	*/
	@available(OSX 10.5, *)
	public func setDepth(_ depth: Int) {
		IOHIDQueueSetDepth(queue, depth)
	}
	
	/*!
	@function   IOHIDQueueAddElement
	@abstract   Adds an element to the queue
	@param      queue IOHIDQueue object to be modified.
	@param      element Element to be added to the queue.
	*/
	@available(OSX 10.5, *)
	public func addElement(_ element: HIDElement) {
		IOHIDQueueAddElement(queue, element.element)
	}
	
	/*!
	@function   IOHIDQueueRemoveElement
	@abstract   Removes an element from the queue
	@param      queue IOHIDQueue object to be modified.
	@param      element Element to be removed from the queue.
	*/
	@available(OSX 10.5, *)
	public func removeElement(_ element: HIDElement) {
		IOHIDQueueRemoveElement(queue, element.element)
	}
	
	/*!
	@function   IOHIDQueueContainsElement
	@abstract   Queries the queue to determine if elemement has been added.
	@param      queue IOHIDQueue object to be queried.
	@param      element Element to be queried.
	@result     Returns true or false depending if element is present.
	*/
	@available(OSX 10.5, *)
	public func containsElement(_ element: HIDElement) -> Bool {
		return IOHIDQueueContainsElement(queue, element.element)
	}
	
	/*!
	@function   IOHIDQueueStart
	@abstract   Starts element value delivery to the queue.
	@param      queue IOHIDQueue object to be started.
	*/
	@available(OSX 10.5, *)
	public func start() {
		IOHIDQueueStart(queue)
	}
	
	/*!
	@function   IOHIDQueueStop
	@abstract   Stops element value delivery to the queue.
	@param      queue IOHIDQueue object to be stopped.
	*/
	@available(OSX 10.5, *)
	public func stop() {
		IOHIDQueueStop(queue)
	}
	
	/*!
	@function   IOHIDQueueScheduleWithRunLoop
	@abstract   Schedules queue with run loop.
	@discussion Formally associates queue with client's run loop. Scheduling
	this queue with the run loop is necessary before making
	use of any asynchronous APIs.
	@param      queue IOHIDQueue object to be modified.
	@param      runLoop RunLoop to be used when scheduling any asynchronous
	activity.
	@param      runLoopMode Run loop mode to be used when scheduling any
	asynchronous activity.
	*/
	@available(OSX 10.5, *)
	public func schedule(withRunLoop runLoop: CFRunLoop, mode: CFRunLoopMode) {
		IOHIDQueueScheduleWithRunLoop(queue, runLoop, mode.rawValue)
	}
	
	/*!
	@function   IOHIDQueueUnscheduleFromRunLoop
	@abstract   Unschedules queue with run loop.
	@discussion Formally disassociates queue with client's run loop.
	@param      queue IOHIDQueue object to be modified.
	@param      runLoop RunLoop to be used when scheduling any asynchronous
	activity.
	@param      runLoopMode Run loop mode to be used when scheduling any
	asynchronous activity.
	*/
	@available(OSX 10.5, *)
	public func unschedle(fromRunLoop runLoop: CFRunLoop, mode: String) {
		IOHIDQueueUnscheduleFromRunLoop(queue, runLoop, mode as CFString)
	}
	
	/*!
	@function   IOHIDQueueRegisterValueAvailableCallback
	@abstract   Sets callback to be used when the queue transitions to non-empty.
	@discussion In order to make use of asynchronous behavior, the queue needs
	to be scheduled with the run loop.
	@param      queue IOHIDQueue object to be modified.
	@param      callback Callback of type IOHIDCallback to be used when data is
	placed on the queue.
	@param      context Pointer to data to be passed to the callback.
	*/
	@available(OSX 10.5, *)
	public func register<Instance>(valueAvailableCallback: @escaping IOHIDCallback, withContext context: Unmanaged<Instance>) {
		IOHIDQueueRegisterValueAvailableCallback(queue, valueAvailableCallback, context.toOpaque())
	}
	
	/*!
	@function   IOHIDQueueCopyNextValue
	@abstract   Dequeues a retained copy of an element value from the head of an
	IOHIDQueue.
	@discussion Because the value is a retained copy, it is up to the caller to
	release the value using CFRelease. Use with setValueCallback to
	avoid polling the queue for data.
	@param      queue IOHIDQueue object to be queried.
	@result     Returns valid IOHIDValueRef if data is available.
	*/
	@available(OSX 10.5, *)
	public func copyNextValue() -> HIDValue? {
		if let value = IOHIDQueueCopyNextValue(queue) {
			return HIDValue(with: value)
		}
		return nil
	}
	
	/*!
	@function   IOHIDQueueCopyNextValueWithTimeout
	@abstract   Dequeues a retained copy of an element value from the head of an
	IOHIDQueue.  This method will block until either a value is
	available or it times out.
	@discussion Because the value is a retained copy, it is up to the caller to
	release the value using CFRelease. Use with setValueCallback to
	avoid polling the queue for data.
	@param      queue IOHIDQueue object to be queried.
	@param      timeout Timeout before aborting an attempt to dequeue a value
	from the head of a queue.
	@result     Returns valid IOHIDValueRef if data is available.
	*/
	@available(OSX 10.5, *)
	public func copyNextValue(withTimeout timeout: TimeInterval) -> HIDValue? {
		if let value = IOHIDQueueCopyNextValueWithTimeout(queue, timeout) {
			return HIDValue(with: value)
		}
		return nil
	}
}

extension HIDQueue: Equatable {
	
	// MARK: Equatable Implementation
	
	public static func ==(lhs: HIDQueue, rhs: HIDQueue) -> Bool {
		return lhs.queue == rhs.queue
	}
}

extension HIDQueue: Hashable {
	
	// MARK: Hashable Implementation
	
	public var hashValue: Int {
		return queue.hashValue
	}
}
