//
//  HIDReportType.swift
//  SwiftyHID
//
//  Created by James Linnell on 10/15/18.
//  Copyright © 2018 James Linnell. All rights reserved.
//

import Foundation
import IOKit

/*!
@typedef IOHIDReportType
@abstract Describes different type of HID reports.
@discussion Used by the IOHIDFamily to identify the type of
report being processed.
*/
public enum HIDReportType {
	
	case input
	case output
	case feature
	case count
	
	var value: IOHIDReportType {
		switch self {
		case .input: return kIOHIDReportTypeInput
		case .output: return kIOHIDReportTypeOutput
		case .feature: return kIOHIDReportTypeFeature
		case .count: return kIOHIDReportTypeCount
		}
	}
	
	init(with value: IOHIDReportType) {
		switch value {
		case kIOHIDReportTypeInput: self = .input
		case kIOHIDReportTypeOutput: self = .output
		case kIOHIDReportTypeFeature: self = .feature
		case kIOHIDReportTypeCount: self = .count
		default: self = .input
		}
	}
}
