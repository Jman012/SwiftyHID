//
//  HIDOptions.swift
//  SwiftyHID
//
//  Created by James Linnell on 9/22/18.
//  Copyright © 2018 James Linnell. All rights reserved.
//

import Foundation
import IOKit

/*
 /*!
 @typedef IOHIDOptionsType
 @abstract Options for opening a device via IOHIDLib.
 @constant kIOHIDOptionsTypeNone Default option.
 @constant kIOHIDOptionsTypeSeizeDevice Used to open exclusive
 communication with the device.  This will prevent the system
 and other clients from receiving events from the device.
 */
 
 public var kIOHIDOptionsTypeNone: Int { get }
 public var kIOHIDOptionsTypeSeizeDevice: Int { get }
 */

public enum HIDOption {
	case none
	case seizeDevice
	
	var value: UInt32 {
		switch self {
		case .none: return UInt32(kIOHIDOptionsTypeNone)
		case .seizeDevice: return UInt32(kIOHIDOptionsTypeSeizeDevice)
		}
	}
}
