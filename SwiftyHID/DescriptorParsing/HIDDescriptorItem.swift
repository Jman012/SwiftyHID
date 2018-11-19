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

/**
 * Main items are used to either define or group certain types of data fields
 * within a Report descriptor. There are two types of Main items: data and
 * non-data. Data- type Main items are used to create a field within a report
 * and include Input, Output, and Feature. Other items do not create fields and
 * are subsequently referred to as non-data Main items.
 */
public enum HIDDescriptorMainTag: CustomStringConvertible {
	/**
	 * Input item tag: Refers to the data from one or more similar controls on a
	 * device. For example, variable data such as reading the position of a
	 * single axis or a group of levers or array data such as one or more push
	 * buttons or switches.
	 *
	 * An Input item describes information about the data provided by one or
	 * more physical controls. An application can use this information to
	 * interpret the data provided by the device. All data fields defined in a
	 * single item share an identical data format.
	 */
	case input(HIDDescriptorMainInputData)
	/**
	 * Output item tag: Refers to the data to one or more similar controls on a
	 * device such as setting the position of a single axis or a group of levers
	 * (variable data). Or, it can represent data to one or more LEDs (array
	 * data).
	 *
	 * The Output item is used to define an output data field in a report. This
	 * item is similar to an Input item except it describes data sent to the
	 * device—for example, LED states.
	 */
	case output(HIDDescriptorMainOutputData)
	/**
	 * Feature item tag: Describes device input and output not intended for
	 * consumption by the end user —for example, a software feature or Control
	 * Panel toggle.
	 *
	 * Feature items describe device configuration information that can be sent
	 * to the device.
	 */
	case feature(HIDDescriptorMainFeatureData)
	/**
	 * Collection item tag: A meaningful grouping of Input, Output, and Feature
	 * items—for example, mouse, keyboard, joystick, and pointer.
	 */
	case beginCollection(HIDDescriptorMainCollectionType)
	/**
	 * End Collection item tag: A terminating item used to specify the end of a
	 * collection of items.
	 */
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

/**
 * Indicates whether the item is data or a constant value. Data indicates the
 * item is defining report fields that contain modifiable device data. Constant
 * indicates the item is a static read-only field in a report and cannot be
 * modified (written) by the host.
 */
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

/**
 * Indicates whether the item creates variable or array data fields in reports.
 * In variable fields, each field represents data from a physical control. The
 * number of bits reserved for each field is determined by preceding Report
 * Size/Report Count items. For example, a bank of eight on/off switches could
 * be reported in 1 byte declared by a variable Input item where each bit
 * represents one switch, on (1) or off (0) (Report Size = 1, Report Count = 8).
 * Alternatively, a variable Input item could add 1 report byte used to
 * represent the state of four three- position buttons, where the state of each
 * button is represented by two bits (Report Size = 2, Report Count = 4). Or 1
 * byte from a variable Input item could represent the x position of a joystick
 * (Report Size = 8, Report Count = 1).
 *
 * An array provides an alternate means for describing the data returned from a
 * group of buttons. Arrays are more efficient, if less flexible than variable
 * items. Rather than returning a single bit for each button in the group, an
 * array returns an index in each field that corresponds to the pressed button
 * (like keyboard scan codes). An out-of range value in and array field is
 * considered no controls asserted. Buttons or keys in an array that are
 * simultaneously pressed need to be reported in multiple fields. Therefore, the
 * number of fields in an array input item (Report Count) dictates the maximum
 * number of simultaneous controls that can be reported. A keyboard could report
 * up to three simultaneous keys using an array with three 8-bit fields (Report
 * Size = 8, Report Count = 3). Logical Minimum specifies the lowest index value
 * returned by the array and Logical Maximum specifies the largest. The number
 * of elements in the array can be deduced by examining the difference between
 * Logical Minimum and Logical Maximum (number of elements = Logical Maximum -
 * Logical Minimum + 1).
 */
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

/**
 * Indicateswhetherthedataisabsolute(basedona fixed origin) or relative
 * (indicating the change in value from the last report). Mouse devices usually
 * provide relative data, while tablets usually provide absolute data.
 */
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

/**
 * Indicates whether the data “rolls over” when reaching either the extreme high
 * or low value. For example, a dial that can spin freely 360 degrees might
 * output values from 0 to 10. If Wrap is indicated, the next value reported
 * after passing the 10 position in the increasing direction would be 0.
 */
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

/**
 * Indicates whether the raw data from the device has been processed in some
 * way, and no longer represents a linear relationship between what is measured
 * and the data that is reported. Acceleration curves and joystick dead zones
 * are examples of this kind of data. Sensitivity settings would affect the
 * Units item, but the data would still be linear.
 */
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

/**
 * Indicates whether the control has a preferred state to which it will return
 * when the user is not physically interacting with the control. Push buttons
 * (as opposed to toggle buttons) and self- centering joysticks are examples.
 */
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

/**
 * Indicates whether the control has a state in which it is not sending
 * meaningful data. One possible use of the null state is for controls that
 * require the user to physically interact with the control in order for it to
 * report useful data. For example, some joysticks have a multidirectional
 * switch (a hat switch). When a hat switch is not being pressed it is in a null
 * state. When in a null state, the control will report a value outside of the
 * specified Logical Minimum and Logical Maximum (the most negative value, such
 * as -128 for an 8-bit value).
 */
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

/**
 * Indicates whether the Feature or Output control's value should be changed by
 * the host or not. Volatile output can change with or without host interaction.
 * To avoid synchronization problems, volatile controls should be relative
 * whenever possible. If volatile output is absolute, when issuing a Set Report
 * (Output), request set the value of any control you don't want to change to a
 * value outside of the specified Logical Minimum and Logical Maximum (the most
 * negative value, such as -128 for an 8-bit value). Invalid output to a control
 * is ignored by the device.
 */
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
/**
 * Indicates that the control emits a fixed-size stream of bytes. The contents
 * of the data field are determined by the application. The contents of the
 * buffer are not interpreted as a single numeric quantity. Report data defined
 * by a Buffered Bytes item must be aligned on an 8-bit boundary. The data from
 * a bar code reader is an example.
 */
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
	/**
	 * A physical collection is used for a set of data items that represent data
 	 * points collected at one geometric point. This is useful for sensing
	 * devices which may need to associate sets of measured or sensed data with
	 * a single point. It does not indicate that a set of data values comes from
	 * one device, such as a keyboard. In the case of device which reports the
	 * position of multiple sensors, physical collections are used to show which
	 * data comes from each separate sensor.
	 */
	case physical
	/**
	 * A group of Main items that might be familiar to applications. It could
	 * also be used to identify item groups serving different purposes in a
	 * single device. Common examples are a keyboard or mouse. A keyboard with
	 * an integrated pointing device could be defined as two different
	 * application collections. Data reports are usually (but not necessarily)
	 * associated with application collections (at least one report ID per
	 * application).
	 */
	case application
	/**
	 * A logical collection is used when a set of data items form a composite
	 * data structure. An example of this is the association between a data
	 * buffer and a byte count of the data. The collection establishes the link
	 * between the count and the buffer.
	 */
	case logical
	/**
	 * Defines a logical collection that wraps all the fields in a report. A
	 * unique report ID will be contained in this collection. An application
	 * can easily determine whether a device supports a certain function. Note
	 * that any valid Report ID value can be declared for a Report collection.
	 */
	case report
	/**
	 * A named array is a logical collection contains an array of selector
	 * usages. For a given function the set of selectors used by similar devices
	 * may vary. The naming of fields is common practice when documenting
	 * hardware registers. To determine whether a device supports a particular
	 * function like Status, an application might have to query for several
	 * known Status selector usages before it could determine whether the device
	 * supported Status. The Named Array usages allows the Array field that
	 * contains the selectors to be named, thus the application only needs to
	 * query for the Status usage to determine that a device supports status
	 * information.
	 */
	case namedArray
	/**
	 * A Usage Switch is a logical collection that modifies the meaning of the
	 * usages that it contains. This collection type indicates to an application
	 * that the usages found in this collection must be special cased. For
	 * instance, rather than declaring a usage on the LED page for every
	 * possible function, an Indicator usage can be applied to a Usage Switch
	 * collection and the standard usages defined in that collection can now be
	 * identified as indicators for a function rather than the function itself.
	 * Note that this collection type is not used for the labeling Ordinal
	 * collections, a Logical collection type is used for that.
	 */
	case usageSwitch
	/**
	 * Modifies the meaning of the usage attached to the encompassing
	 * collection. A usage typically defines a single operating mode for a
	 * control. The usage modifier allows the operating mode of a control to be
	 * extended. For instance, an LED is typically on or off. For particular
	 * states a device may want a generic method of blinking or choosing the
	 * color of a standard LED. Attaching the LED usage to a Usage Modifier
	 * collection will indicate to an application that the usage supports a new
	 * operating mode.
	 */
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

/**
 * Global items describe rather than define data from a control. A new Main item
 * assumes the characteristics of the item state table. Global items can change
 * the state table. As a result Global item tags apply to all subsequently
 * defined items unless overridden by another Global item.
 */
public enum HIDDescriptorGlobalTag: CustomStringConvertible {
	/**
	 * Unsigned integer specifying the current Usage Page. Since a usage are 32
	 * bit values, Usage Page items can be used to conserve space in a report
	 * descriptor by setting the high order 16 bits of a subsequent usages. Any
	 * usage that follows which is defines 16 bits or less is interpreted as a
	 * Usage ID and concatenated with the Usage Page to form a 32 bit Usage.
	 */
	case usagePage(UInt32)
	/**
	 * Extent value in logical units. This is the minimum value that a variable
	 * or array item will report. For example, a mouse reporting x position
	 * values from 0 to 128 would have a Logical Minimum of 0 and a Logical
	 * Maximum of 128.
	 */
	case logicalMin(Int32)
	/**
	 * Extent value in logical units. This is the maximum value that a variable
	 * or array item will report.
	 */
	case logicalMax(Int32)
	/**
	 * Minimum value for the physical extent of a variable item. This represents
	 * the Logical Minimum with units applied to it.
	 */
	case physicalMin(Int32)
	/**
	 * Maximum value for the physical extent of a variable item.
	 */
	case physicalMax(Int32)
	/**
	 * Value of the unit exponent in base 10. See the table later in this
	 * section for more information.
	 */
	case unitExponent(Int32)
	/**
	 * Unit values.
	 */
	case unit(HIDUnit)
	/**
	 * Unsigned integer specifying the size of the report fields in bits. This
	 * allows the parser to build an item map for the report handler to use. For
	 * more information, see Section 8: Report Protocol.
	 */
	case reportSize(UInt32)
	/**
	 * Unsigned value that specifies the Report ID. If a Report ID tag is used
	 * anywhere in Report descriptor, all data reports for the device are
	 * preceded by a single byte ID field. All items succeeding the first Report
	 * ID tag but preceding a second Report ID tag are included in a report
	 * prefixed by a 1-byte ID. All items succeeding the second but preceding a
	 * third Report ID tag are included in a second report prefixed by a second
	 * ID, and so on.
	 *
	 * This Report ID value indicates the prefix added to a particular report.
	 * For example, a Report descriptor could define a 3-byte report with a
	 * Report ID of 01. This device would generate a 4-byte data report in which
	 * the first byte is 01. The device may also generate other reports, each
	 * with a unique ID. This allows the host to distinguish different types of
	 * reports arriving over a single interrupt in pipe. And allows the device
	 * to distinguish different types of reports arriving over a single
	 * interrupt out pipe. Report ID zero is reserved and should not be used.
	 */
	case reportId(UInt32)
	/**
	 * Unsigned integer specifying the number of data fields for the item;
	 * determines how many fields are included in the report for this particular
	 * item (and consequently how many bits are added to the report).
	 */
	case reportCount(UInt32)
	/**
	 * Places a copy of the global item state table on the stack.
	 */
	case push
	/**
	 * Replaces the item state table with the top structure from the stack.
	 */
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

/**
 * Local item tags define characteristics of controls. These items do not carry
 * over to the next Main item. If a Main item defines more than one control, it
 * may be preceded by several similar Local item tags. For example, an Input
 * item may have several Usage tags associated with it, one for each control.
 */
public enum HIDDescriptorLocalTag: CustomStringConvertible {
	/**
	 * Usage index for an item usage; represents a suggested usage for the item
	 * or collection. In the case where an item represents multiple controls, a
	 * Usage tag may suggest a usage for every variable or element in an array.
	 */
	case usage(UInt32)
	/**
	 * Defines the starting usage associated with an array or bitmap.
	 */
	case usageMinimum(UInt32)
	/**
	 * Defines the ending usage associated with an array or bitmap.
	 */
	case usageMaximum(UInt32)
	/**
	 * Determines the body part used for a control. Index points to a designator
	 * in the Physical descriptor.
	 */
	case designatorIndex(UInt32)
	/**
	 * Defines the index of the starting designator associated with an array or
	 * bitmap.
	 */
	case designatorMinimum(UInt32)
	/**
	 * Defines the index of the ending designator associated with an array or
	 * bitmap.
	 */
	case designatorMaximum(UInt32)
	/**
	 * String index for a String descriptor; allows a string to be associated
	 * with a particular item or control.
	 */
	case stringIndex(UInt32)
	/**
	 * Specifies the first string index when assigning a group of sequential
	 * strings to controls in an array or bitmap.
	 */
	case stringMinimum(UInt32)
	/**
	 * Specifies the last string index when assigning a group of sequential
	 * strings to controls in an array or bitmap.
	 */
	case stringMaximum(UInt32)
	/**
	 * Defines the beginning or end of a set of local items (1 = open set,
	 * 0 = close set).
	 */
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
