//
//  HIDDescriptorItem.swift
//  SwiftyHID
//
//  Created by James Linnell on 11/4/18.
//  Copyright © 2018 James Linnell. All rights reserved.
//

import Foundation

public enum HIDDescriptorItem: CustomStringConvertible {
	case main(HIDDescriptorMainTag)
	case global(HIDDescriptorGlobalTag)
	case local(HIDDescriptorLocalTag)
	
	init?(type: UInt8, tag: UInt8, unsignedValue: UInt32, signedValue: Int32) {
		switch type {
		case 0x00: // Main
			if let mainTag = HIDDescriptorMainTag(tagValue: tag, unsignedValue: unsignedValue) {
				self = .main(mainTag)
				return
			}
		case 0x01: // Global
			if let globalTag = HIDDescriptorGlobalTag(tagValue: tag, unsignedValue: unsignedValue, signedValue: signedValue) {
				self = .global(globalTag)
				return
			}
		case 0x02: // Local
			if let localTag = HIDDescriptorLocalTag(tagValue: tag, unsignedValue: unsignedValue) {
				self = .local(localTag)
				return
			}
		default:
			break
		}
		return nil
	}
	
	public var description: String {
		switch self {
		case .main(let tag): return tag.description
			case .global(let tag): return tag.description
			case .local(let tag): return tag.description
		}
	}
}

// MARK: Main Tag Definitions

public enum HIDDescriptorMainTag: CustomStringConvertible {
	case input(HIDDescriptorMainInputData)
	case output(HIDDescriptorMainOutputData)
	case feature(HIDDescriptorMainFeatureData)
	case beginCollection(HIDDescriptorMainCollectionType)
	case endCollection
	
	init?(tagValue: UInt8, unsignedValue: UInt32) {
		switch tagValue {
		case 0x08:
			self = .input(HIDDescriptorMainInputData(data: unsignedValue))
		case 0x09:
			self = .output(HIDDescriptorMainOutputData(data: unsignedValue))
		case 0x0B:
			self = .feature(HIDDescriptorMainFeatureData(data: unsignedValue))
		case 0x0A:
			self = .beginCollection(HIDDescriptorMainCollectionType(data: unsignedValue))
		case 0x0C:
			self = .endCollection
		default:
			return nil
		}
	}
	
	public var description: String {
		switch self {
		case .input(let data):
			return "Input (\(data.dataOrConstant), \(data.arrayOrVariable), \(data.absoluteOrRelative), \(data.noWrapOrWrap), \(data.linearOrNonLinear), \(data.preferredOrNoPreferredState), \(data.noNullPositionOrNullState), \(data.bitFieldOrBufferedBytes))"
		case .output(let data):
			return "Output (\(data.dataOrConstant), \(data.arrayOrVariable), \(data.absoluteOrRelative), \(data.noWrapOrWrap), \(data.linearOrNonLinear), \(data.preferredOrNoPreferredState), \(data.noNullPositionOrNullState), \(data.nonVolatileOrVolatile), \(data.bitFieldOrBufferedBytes))"
		case .feature(let data):
			return "Feature (\(data.dataOrConstant), \(data.arrayOrVariable), \(data.absoluteOrRelative), \(data.noWrapOrWrap), \(data.linearOrNonLinear), \(data.preferredOrNoPreferredState), \(data.noNullPositionOrNullState), \(data.nonVolatileOrVolatile), \(data.bitFieldOrBufferedBytes))"
		case .beginCollection(let type):
			return "Collection (\(type))"
		case .endCollection:
			return "End Collection"
		}
	}
}

enum DataOrConstant: Equatable, CustomStringConvertible {
	case data
	case constant
	
	var description: String {
		switch self {
		case .data: return "Data"
		case .constant: return "Constant"
		}
	}
}
enum ArrayOrVariable: Equatable, CustomStringConvertible {
	case array
	case variable
	
	var description: String {
		switch self {
		case .array: return "Array"
		case .variable: return "Variable"
		}
	}
}
enum AbsoluteOrRelative: Equatable, CustomStringConvertible {
	case absolute
	case relative
	
	var description: String {
		switch self {
		case .absolute: return "Absolute"
		case .relative: return "Relative"
		}
	}
}
enum NoWrapOrWrap: Equatable, CustomStringConvertible {
	case noWrap
	case wrap
	
	var description: String {
		switch self {
		case .noWrap: return "No Wrap"
		case .wrap: return "Wrap"
		}
	}
}
enum LinearOrNonLinear: Equatable, CustomStringConvertible {
	case linear
	case nonLinear
	
	var description: String {
		switch self {
		case .linear: return "Linear"
		case .nonLinear: return "Non-Linear"
		}
	}
}
enum PreferredOrNoPreferredState: Equatable, CustomStringConvertible {
	case preferredState
	case noPreferredState
	
	var description: String {
		switch self {
		case .preferredState: return "Preferred State"
		case .noPreferredState: return "No Preferred State"
		}
	}
}
enum NoNullPositionOrNullState: Equatable, CustomStringConvertible {
	case noNullPosition
	case nullState
	
	var description: String {
		switch self {
		case .noNullPosition: return "No Null Position"
		case .nullState: return "Null State"
		}
	}
}
enum NonVolatileOrVolatile: Equatable, CustomStringConvertible {
	case nonVolatile
	case volatile
	
	var description: String {
		switch self {
		case .nonVolatile: return "Non-Volative"
		case .volatile: return "Volatile"
		}
	}
}
enum BitFieldOrBufferedBytes: Equatable, CustomStringConvertible {
	case bitField
	case bufferedBytes
	
	var description: String {
		switch self {
		case .bitField: return "Bit Field"
		case .bufferedBytes: return "Buffered Bytes"
		}
	}
}

public struct HIDDescriptorMainInputData: Equatable {
	let dataOrConstant: DataOrConstant
	let arrayOrVariable: ArrayOrVariable
	let absoluteOrRelative: AbsoluteOrRelative
	let noWrapOrWrap: NoWrapOrWrap
	let linearOrNonLinear: LinearOrNonLinear
	let preferredOrNoPreferredState: PreferredOrNoPreferredState
	let noNullPositionOrNullState: NoNullPositionOrNullState
	// Input does not have NonVolatileOrVolatile
	let bitFieldOrBufferedBytes: BitFieldOrBufferedBytes
	
	init(data: UInt32) {
		dataOrConstant = Utils.getBit(data: data, bitNumber: 0) ? .constant : .data
		arrayOrVariable = Utils.getBit(data: data, bitNumber: 1) ? .variable : .array
		absoluteOrRelative = Utils.getBit(data: data, bitNumber: 2) ? .relative : .absolute
		noWrapOrWrap = Utils.getBit(data: data, bitNumber: 3) ? .wrap : .noWrap
		linearOrNonLinear = Utils.getBit(data: data, bitNumber: 4) ? .nonLinear : .linear
		preferredOrNoPreferredState = Utils.getBit(data: data, bitNumber: 5) ? .noPreferredState : .preferredState
		noNullPositionOrNullState = Utils.getBit(data: data, bitNumber: 6) ? .nullState : .noNullPosition
		bitFieldOrBufferedBytes = Utils.getBit(data: data, bitNumber: 8) ? .bufferedBytes : .bitField
	}
}

public struct HIDDescriptorMainOutputData: Equatable {
	let dataOrConstant: DataOrConstant
	let arrayOrVariable: ArrayOrVariable
	let absoluteOrRelative: AbsoluteOrRelative
	let noWrapOrWrap: NoWrapOrWrap
	let linearOrNonLinear: LinearOrNonLinear
	let preferredOrNoPreferredState: PreferredOrNoPreferredState
	let noNullPositionOrNullState: NoNullPositionOrNullState
	let nonVolatileOrVolatile: NonVolatileOrVolatile
	let bitFieldOrBufferedBytes: BitFieldOrBufferedBytes
	
	init(data: UInt32) {
		dataOrConstant = Utils.getBit(data: data, bitNumber: 0) ? .constant : .data
		arrayOrVariable = Utils.getBit(data: data, bitNumber: 1) ? .variable : .array
		absoluteOrRelative = Utils.getBit(data: data, bitNumber: 2) ? .relative : .absolute
		noWrapOrWrap = Utils.getBit(data: data, bitNumber: 3) ? .wrap : .noWrap
		linearOrNonLinear = Utils.getBit(data: data, bitNumber: 4) ? .nonLinear : .linear
		preferredOrNoPreferredState = Utils.getBit(data: data, bitNumber: 5) ? .noPreferredState : .preferredState
		noNullPositionOrNullState = Utils.getBit(data: data, bitNumber: 6) ? .nullState : .noNullPosition
		nonVolatileOrVolatile = Utils.getBit(data: data, bitNumber: 7) ? .volatile : .nonVolatile
		bitFieldOrBufferedBytes = Utils.getBit(data: data, bitNumber: 8) ? .bufferedBytes : .bitField
	}
}

public struct HIDDescriptorMainFeatureData: Equatable {
	let dataOrConstant: DataOrConstant
	let arrayOrVariable: ArrayOrVariable
	let absoluteOrRelative: AbsoluteOrRelative
	let noWrapOrWrap: NoWrapOrWrap
	let linearOrNonLinear: LinearOrNonLinear
	let preferredOrNoPreferredState: PreferredOrNoPreferredState
	let noNullPositionOrNullState: NoNullPositionOrNullState
	let nonVolatileOrVolatile: NonVolatileOrVolatile
	let bitFieldOrBufferedBytes: BitFieldOrBufferedBytes
	
	init(data: UInt32) {
		dataOrConstant = Utils.getBit(data: data, bitNumber: 0) ? .constant : .data
		arrayOrVariable = Utils.getBit(data: data, bitNumber: 1) ? .variable : .array
		absoluteOrRelative = Utils.getBit(data: data, bitNumber: 2) ? .relative : .absolute
		noWrapOrWrap = Utils.getBit(data: data, bitNumber: 3) ? .wrap : .noWrap
		linearOrNonLinear = Utils.getBit(data: data, bitNumber: 4) ? .nonLinear : .linear
		preferredOrNoPreferredState = Utils.getBit(data: data, bitNumber: 5) ? .noPreferredState : .preferredState
		noNullPositionOrNullState = Utils.getBit(data: data, bitNumber: 6) ? .nullState : .noNullPosition
		nonVolatileOrVolatile = Utils.getBit(data: data, bitNumber: 7) ? .volatile : .nonVolatile
		bitFieldOrBufferedBytes = Utils.getBit(data: data, bitNumber: 8) ? .bufferedBytes : .bitField
	}
}

public enum HIDDescriptorMainCollectionType: Equatable, CustomStringConvertible {
	case physical
	case application
	case logical
	case report
	case namedArray
	case usageSwitch
	case usageModifier
	case reserved(UInt8)
	case vendorDefined(UInt32)
	
	init(data: UInt32) {
		switch data {
		case 0x00:
			self = .physical
		case 0x01:
			self = .application
		case 0x02:
			self = .logical
		case 0x03:
			self = .report
		case 0x04:
			self = .namedArray
		case 0x05:
			self = .usageSwitch
		case 0x06:
			self = .usageModifier
		case let x where x >= 0x07 && x <= 0x7F:
			self = .reserved(UInt8(x))
		default:
			self = .vendorDefined(data)
		}
	}
	
	public var description: String {
		switch self {
		case .physical: return "Physical"
		case .application: return "Application"
		case .logical: return "Logical"
		case .report: return "Report"
		case .namedArray: return "Named Array"
		case .usageSwitch: return "Usage Switch"
		case .usageModifier: return "Usage Modifier"
		case .reserved(let n): return "Reserved (\(n))"
		case .vendorDefined(let n): return "Vendor Defined (\(n))"
		}
	}
}

// MARK: Global Tag Definitions

public enum HIDDescriptorGlobalTag: CustomStringConvertible {
	case usagePage(UInt32)
	case logicalMin(Int32)
	case logicalMax(Int32)
	case physicalMin(Int32)
	case physicalMax(Int32)
	case unitExponent(Int32)
	case unit(HIDUnit)
	case reportSize(UInt32)
	case reportId(UInt32)
	case reportCount(UInt32)
	case push
	case pop
	
	init?(tagValue: UInt8, unsignedValue: UInt32, signedValue: Int32) {
		switch tagValue {
		case 0x00: self = .usagePage(unsignedValue)
		case 0x01: self = .logicalMin(signedValue)
		case 0x02: self = .logicalMax(signedValue)
		case 0x03: self = .physicalMin(signedValue)
		case 0x04: self = .physicalMax(signedValue)
		case 0x05: self = .unitExponent(signedValue)
		case 0x06: self = .unit(HIDUnit(withData: unsignedValue))
		case 0x07: self = .reportSize(unsignedValue)
		case 0x08: self = .reportId(unsignedValue)
		case 0x09: self = .reportCount(unsignedValue)
		case 0x0A: self = .push
		case 0x0B: self = .pop
		default:
			return nil
		}
	}
	
	public var description: String {
		switch self {
		case .usagePage(let n): return "Usage Page (\(n))"
		case .logicalMin(let n): return "Logical Min (\(n))"
		case .logicalMax(let n): return "Logical Max (\(n))"
		case .physicalMin(let n): return "Physical Min (\(n))"
		case .physicalMax(let n): return "Physical Max (\(n))"
		case .unitExponent(let n): return "Unit Exponent (\(n))"
		case .unit(let unit): return "Unit (\(unit))"
		case .reportSize(let n): return "Report Size (\(n))"
		case .reportId(let n): return "Report ID (\(n))"
		case .reportCount(let n): return "Report Count (\(n))"
		case .push: return "Push"
		case .pop: return "Pop"
		}
	}
}

// MARK: Local Tag Definitions

public enum HIDDescriptorLocalTag: CustomStringConvertible {
	case usage(UInt32)
	case usageMinimum(UInt32)
	case usageMaximum(UInt32)
	case designatorIndex(UInt32)
	case designatorMinimum(UInt32)
	case designatorMaximum(UInt32)
	case stringIndex(UInt32)
	case stringMinimum(UInt32)
	case stringMaximum(UInt32)
	case delimiter(Bool)
	
	init?(tagValue: UInt8, unsignedValue: UInt32) {
		switch tagValue {
		case 0x00: self = .usage(unsignedValue)
		case 0x01: self = .usageMinimum(unsignedValue)
		case 0x02: self = .usageMaximum(unsignedValue)
		case 0x03: self = .designatorIndex(unsignedValue)
		case 0x04: self = .designatorMinimum(unsignedValue)
		case 0x05: self = .designatorMaximum(unsignedValue)
		case 0x07: self = .stringIndex(unsignedValue)
		case 0x08: self = .stringMinimum(unsignedValue)
		case 0x09: self = .stringMaximum(unsignedValue)
		case 0x0A: self = .delimiter(unsignedValue > 0)
		default:
			return nil
		}
	}
	
	public var description: String {
		switch self {
		case .usage(let n): return "Usage (\(n))"
		case .usageMinimum(let n): return "Usage Minimum (\(n))"
		case .usageMaximum(let n): return "Usage Maximum (\(n))"
		case .designatorIndex(let n): return "Designator Index (\(n))"
		case .designatorMinimum(let n): return "Designator Minimum (\(n))"
		case .designatorMaximum(let n): return "Designator Maximum (\(n))"
		case .stringIndex(let n): return "String Index (\(n))"
		case .stringMinimum(let n): return "String Minimum (\(n))"
		case .stringMaximum(let n): return "String Maximum (\(n))"
		case .delimiter(let b): return "Delimiter (\((b ? "True" : "False")))"
		}
	}
}
