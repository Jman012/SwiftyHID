//
//  HIDTransaction.swift
//  SwiftyHID
//
//  Created by James Linnell on 9/29/18.
//  Copyright © 2018 James Linnell. All rights reserved.
//

import Foundation
import IOKit

typealias HIDTransactionCallback = (_ result: Return, _ sender: HIDTransaction) -> ()

public class HIDTransaction {
	
	let transaction: IOHIDTransaction
	
	init(with transaction: IOHIDTransaction) {
		self.transaction = transaction
	}
}

extension HIDTransaction {
	
	// MARK: IOHIDTransaction Methods
	
	/*!
	@function   IOHIDTransactionCreate
	@abstract   Creates an IOHIDTransaction object for the specified device.
	@discussion IOHIDTransaction objects can be used to either send or receive
	multiple element values.  As such the direction used should
	represent they type of objects added to the transaction.
	@param      allocator Allocator to be used during creation.
	@param      device IOHIDDevice object
	@param      direction The direction, either in or out, for the transaction.
	@param      options Reserved for future use.
	@result     Returns a new IOHIDTransactionRef.
	*/
	@available(OSX 10.5, *)
	public func create(allocator: CFAllocator?, device: HIDDevice, direction: IOHIDTransactionDirectionType, options: HIDOption) -> HIDTransaction? {
		if let trans = IOHIDTransactionCreate(allocator, device.device, direction, options.value) {
			return HIDTransaction(with: trans)
		}
		return nil
	}
	
	/*!
	@function   IOHIDTransactionGetDevice
	@abstract   Obtain the device associated with the transaction.
	@param      transaction IOHIDTransaction to be queried.
	@result     Returns the a reference to the device.
	*/
	@available(OSX 10.5, *)
	public func getDevice() -> HIDDevice {
		return HIDDevice(with: IOHIDTransactionGetDevice(transaction))
	}
	
	/*!
	@function   IOHIDTransactionGetDirection
	@abstract   Obtain the direction of the transaction.
	@param      transaction IOHIDTransaction to be queried.
	@result     Returns the transaction direction.
	*/
	@available(OSX 10.5, *)
	public func getDirection() -> IOHIDTransactionDirectionType {
		return IOHIDTransactionGetDirection(transaction)
	}
	
	/*!
	@function   IOHIDTransactionSetDirection
	@abstract   Sets the direction of the transaction
	@disussion  This method is useful for manipulating bi-direction (feature)
	elements such that you can set or get element values without
	creating an additional transaction object.
	@param      transaction IOHIDTransaction object to be modified.
	@param      direction The new transaction direction.
	*/
	@available(OSX 10.5, *)
	public func setDirection(_ direction: IOHIDTransactionDirectionType) {
		IOHIDTransactionSetDirection(transaction, direction)
	}
	
	/*!
	@function   IOHIDTransactionAddElement
	@abstract   Adds an element to the transaction
	@disussion  To minimize device traffic it is important to add elements that
	share a common report type and report id.
	@param      transaction IOHIDTransaction object to be modified.
	@param      element Element to be added to the transaction.
	*/
	@available(OSX 10.5, *)
	public func addElement(_ element: HIDElement) {
		IOHIDTransactionAddElement(transaction, element.element)
	}
	
	/*!
	@function   IOHIDTransactionRemoveElement
	@abstract   Removes an element to the transaction
	@param      transaction IOHIDTransaction object to be modified.
	@param      element Element to be removed to the transaction.
	*/
	@available(OSX 10.5, *)
	public func removeElement(_ element: HIDElement) {
		IOHIDTransactionRemoveElement(transaction, element.element)
	}
	
	/*!
	@function   IOHIDTransactionContainsElement
	@abstract   Queries the transaction to determine if elemement has been added.
	@param      transaction IOHIDTransaction object to be queried.
	@param      element Element to be queried.
	@result     Returns true or false depending if element is present.
	*/
	@available(OSX 10.5, *)
	public func containsElement(_ element: HIDElement) -> Bool {
		return IOHIDTransactionContainsElement(transaction, element.element)
	}
	
	/*!
	@function   IOHIDTransactionScheduleWithRunLoop
	@abstract   Schedules transaction with run loop.
	@discussion Formally associates transaction with client's run loop.
	Scheduling this transaction with the run loop is necessary
	before making use of any asynchronous APIs.
	@param      transaction IOHIDTransaction object to be modified.
	@param      runLoop RunLoop to be used when scheduling any asynchronous
	activity.
	@param      runLoopMode Run loop mode to be used when scheduling any
	asynchronous activity.
	*/
	@available(OSX 10.5, *)
	public func schedule(withRunLoop runLoop: CFRunLoop, mode: CFRunLoopMode) {
		IOHIDTransactionScheduleWithRunLoop(transaction, runLoop, mode.rawValue)
	}
	
	/*!
	@function   IOHIDTransactionUnscheduleFromRunLoop
	@abstract   Unschedules transaction with run loop.
	@discussion Formally disassociates transaction with client's run loop.
	@param      transaction IOHIDTransaction object to be modified.
	@param      runLoop RunLoop to be used when scheduling any asynchronous
	activity.
	@param      runLoopMode Run loop mode to be used when scheduling any
	asynchronous activity.
	*/
	@available(OSX 10.5, *)
	public func unschedule(fromRunLoop runLoop: CFRunLoop, mode: CFRunLoopMode) {
		IOHIDTransactionUnscheduleFromRunLoop(transaction, runLoop, mode.rawValue)
	}
	
	/*!
	@function   IOHIDTransactionSetValue
	@abstract   Sets the value for a transaction element.
	@discussion The value set is pended until the transaction is committed and
	is only used if the transaction direction is
	kIOHIDTransactionDirectionTypeOutput.  Use the
	kIOHIDTransactionOptionDefaultOutputValue option to set the
	default element value.
	@param      transaction IOHIDTransaction object to be modified.
	@param      element Element to be modified after a commit.
	@param      value Value to be set for the given element.
	@param      options See IOHIDTransactionOption.
	*/
	@available(OSX 10.5, *)
	public func setValue(_ value: HIDValue, forElement element: HIDElement, options: HIDOption) {
		IOHIDTransactionSetValue(transaction, element.element, value.value, options.value)
	}
	
	/*!
	@function   IOHIDTransactionGetValue
	@abstract   Obtains the value for a transaction element.
	@discussion If the transaction direction is
	kIOHIDTransactionDirectionTypeInput the value represents what
	was obtained from the device from the transaction.  Otherwise,
	if the transaction direction is
	kIOHIDTransactionDirectionTypeOutput the value represents the
	pending value to be sent to the device.  Use the
	kIOHIDTransactionOptionDefaultOutputValue option to get the
	default element value.
	@param      transaction IOHIDTransaction object to be queried.
	@param      element Element to be queried.
	@param      options See IOHIDTransactionOption.
	@result     Returns IOHIDValueRef for the given element.
	*/
	@available(OSX 10.5, *)
	public func getValue(fromElement element: HIDElement, options: HIDOption) -> HIDValue? {
		if let value = IOHIDTransactionGetValue(transaction, element.element, options.value) {
			return HIDValue(with: value)
		}
		return nil
	}
	
	/*!
	@function   IOHIDTransactionCommit
	@abstract   Synchronously commits element transaction to the device.
	@discussion In regards to kIOHIDTransactionDirectionTypeOutput direction,
	default element values will be used if element values are not
	set.  If neither are set, that element will be omitted from the
	commit. After a transaction is committed, transaction element
	values will be cleared and default values preserved.
	@param      transaction IOHIDTransaction object to be modified.
	@result     Returns kIOReturnSuccess if successful or a kern_return_t if
	unsuccessful.
	*/
	@available(OSX 10.5, *)
	public func commit() -> Return {
		return Return(with: IOHIDTransactionCommit(transaction))
	}
	
	/*!
	@function   IOHIDTransactionCommitWithCallback
	@abstract   Commits element transaction to the device.
	@discussion In regards to kIOHIDTransactionDirectionTypeOutput direction,
	default element values will be used if element values are not
	set.  If neither are set, that element will be omitted from the
	commit. After a transaction is committed, transaction element
	values will be cleared and default values preserved.
	<br>
	<b>Note:</b> It is possible for elements from different reports
	to be present in a given transaction causing a commit to
	transcend multiple reports. Keep this in mind when setting a
	appropriate timeout.
	@param      transaction IOHIDTransaction object to be modified.
	@param      timeout Timeout for issuing the transaction.
	@param      callback Callback of type IOHIDCallback to be used when
	transaction has been completed.  If null, this method will
	behave synchronously.
	@param      context Pointer to data to be passed to the callback.
	@result     Returns kIOReturnSuccess if successful or a kern_return_t if
	unsuccessful.
	*/
	@available(OSX 10.5, *)
	public func commit<Instance>(withCallback callback: IOHIDCallback?, context: Unmanaged<Instance>, timeout: TimeInterval) -> Return {
		return Return(with: IOHIDTransactionCommitWithCallback(transaction, timeout, callback, context.toOpaque()))
	}
	
	/*!
	@function   IOHIDTransactionClear
	@abstract   Clears element transaction values.
	@discussion In regards to kIOHIDTransactionDirectionTypeOutput direction,
	default element values will be preserved.
	@param      transaction IOHIDTransaction object to be modified.
	*/
	@available(OSX 10.5, *)
	public func clear() {
		IOHIDTransactionClear(transaction)
	}
}

extension HIDTransaction: Equatable {
	
	// MARK: Equatable Implementation
	
	public static func ==(lhs: HIDTransaction, rhs: HIDTransaction) -> Bool {
		return lhs.transaction == rhs.transaction
	}
}

extension HIDTransaction: Hashable {
	
	// MARK: Hashable Implementation
	
	public var hashValue: Int {
		return transaction.hashValue
	}
}
