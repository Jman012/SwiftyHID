//
//  HIDUnit.swift
//  SwiftyHID
//
//  Created by James Linnell on 11/11/18.
//  Copyright © 2018 James Linnell. All rights reserved.
//

import Foundation

/**
 * Represents a simple or complex Unit. It allows multiple types of
 * units to be expressed in order to express combined units, such as Joules.
 */
public struct HIDUnit {
	
	public enum System: UInt8 {
		case none = 0
		case siLinear = 1
		case siRotation = 2
		case englishLinear = 3
		case englishRotation = 4
	}
	
	
	var system: System
	var lengthExponent: Int8 = 0
	var massExponent: Int8 = 0
	var timeExponent: Int8 = 0
	var temperatureExponent: Int8 = 0
	var currentExponent: Int8 = 0
	var luminousIntensityExponent: Int8 = 0
	
	init(withData data: UInt32) {
		system = System(rawValue: UInt8(truncatingIfNeeded: Utils.getNibble(data: data, nibbleIndex: 0))) ?? System.none
		
		for i in 1..<7 {
			// Mask for the correct nibble (nib), then shift it down appropriately
			
			switch i {
			case 1: lengthExponent = HIDUnit.exponentValue(fromNibble: Utils.getNibble(data: data, nibbleIndex: 1))
			case 2: massExponent = HIDUnit.exponentValue(fromNibble: Utils.getNibble(data: data, nibbleIndex: 2))
			case 3: timeExponent = HIDUnit.exponentValue(fromNibble: Utils.getNibble(data: data, nibbleIndex: 3))
			case 4: temperatureExponent = HIDUnit.exponentValue(fromNibble: Utils.getNibble(data: data, nibbleIndex: 4))
			case 5: currentExponent = HIDUnit.exponentValue(fromNibble: Utils.getNibble(data: data, nibbleIndex: 5))
			case 6: luminousIntensityExponent = HIDUnit.exponentValue(fromNibble: Utils.getNibble(data: data, nibbleIndex: 6))
			default:
				break
			}
		}
	}
	
	init(withSystem system: System, lengthExp: Int8, massExp: Int8, timeExp: Int8, tempExp: Int8, currentExp: Int8, luminExp: Int8) {
		self.system = system
		lengthExponent = lengthExp
		massExponent = massExp
		timeExponent = timeExp
		temperatureExponent = tempExp
		currentExponent = currentExp
		luminousIntensityExponent = luminExp
	}
	
	private static func exponentValue(fromNibble nibble: UInt8) -> Int8 {
		switch nibble {
		case 0x0: return 0
		case 0x1: return 1
		case 0x2: return 2
		case 0x3: return 3
		case 0x4: return 4
		case 0x5: return 5
		case 0x6: return 6
		case 0x7: return 7
		case 0x8: return -8
		case 0x9: return -7
		case 0xA: return -6
		case 0xB: return -5
		case 0xC: return -4
		case 0xD: return -3
		case 0xE: return -2
		case 0xF: return -1
		default: return 0
		}
	}
}

extension HIDUnit: CustomStringConvertible {
	
	// MARK: CustomStringConvertible Implementation
	
	public var description: String {
		var desc = ""
		if case system = System.none {
			desc += "(no system) "
		}
		
		var positiveExponentUnits: [(String, Int8)] = []
		var negativeExponentUnits: [(String, Int8)] = []
		
		// Length
		var unitString = ""
		switch system {
		case .none:
			unitString = "length"
		case .siLinear:
			unitString = "centimeter"
		case .siRotation:
			unitString = "radian"
		case .englishLinear:
			unitString = "inch"
		case .englishRotation:
			unitString = "degree"
		}
		
		if lengthExponent > 0 {
			positiveExponentUnits.append((unitString, lengthExponent))
		} else if lengthExponent < 0 {
			negativeExponentUnits.append((unitString, lengthExponent))
		}
		
		// Mass
		unitString = ""
		switch system {
		case .none:
			unitString = "mass"
		case .siLinear, .siRotation:
			unitString = "gram"
		case .englishLinear, .englishRotation:
			unitString = "slug"
		}
		
		if massExponent > 0 {
			positiveExponentUnits.append((unitString, massExponent))
		} else if massExponent < 0 {
			negativeExponentUnits.append((unitString, massExponent))
		}
		
		// Time
		unitString = ""
		switch system {
		case .none:
			unitString = "time"
		case .siLinear, .siRotation, .englishLinear, .englishRotation:
			unitString = "second"
		}
		
		if timeExponent > 0 {
			positiveExponentUnits.append((unitString, timeExponent))
		} else if timeExponent < 0 {
			negativeExponentUnits.append((unitString, timeExponent))
		}
		
		// Temperature
		unitString = ""
		switch system {
		case .none:
			unitString = "temperature"
		case .siLinear, .siRotation:
			unitString = "kelvin"
		case .englishLinear, .englishRotation:
			unitString = "farenheit"
		}
		
		if temperatureExponent > 0 {
			positiveExponentUnits.append((unitString, temperatureExponent))
		} else if temperatureExponent < 0 {
			negativeExponentUnits.append((unitString, temperatureExponent))
		}
		
		// Current
		unitString = ""
		switch system {
		case .none:
			unitString = "current"
		case .siLinear, .siRotation, .englishLinear, .englishRotation:
			unitString = "ampere"
		}
		
		if currentExponent > 0 {
			positiveExponentUnits.append((unitString, currentExponent))
		} else if currentExponent < 0 {
			negativeExponentUnits.append((unitString, currentExponent))
		}
		
		// Luminous Intensity
		unitString = ""
		switch system {
		case .none:
			unitString = "luminosity"
		case .siLinear, .siRotation, .englishLinear, .englishRotation:
			unitString = "candela"
		}
		
		if luminousIntensityExponent > 0 {
			positiveExponentUnits.append((unitString, luminousIntensityExponent))
		} else if luminousIntensityExponent < 0 {
			negativeExponentUnits.append((unitString, luminousIntensityExponent))
		}
		
		if positiveExponentUnits.count == 0 && negativeExponentUnits.count == 0 {
			return "1"
		}
		
		if positiveExponentUnits.count > 0 {
			desc += positiveExponentUnits.map({ positive in
				if positive.1 > 1 {
					return "\(positive.0)^\(positive.1)"
				} else {
					return positive.0
				}
			}).joined(separator: "×")
		} else {
			desc += "1"
		}
		
		if negativeExponentUnits.count > 0 {
			desc += "/("
			desc += negativeExponentUnits.map({ negative in
				if negative.1 < -1 {
					return "\(negative.0)^\(-negative.1)"
				} else {
					return negative.0
				}
			}).joined(separator: "×")
			desc += ")"
		}
		
		return desc
	}
	
	/// Given an exponent, return a string for the unit name, and true if the exponent needs to be shown
	typealias UnitClosure = (Int8) -> (String)
	
	private static func getUnit(system: System, exponent: Int8,
								siLinear: UnitClosure,
								siRotation: UnitClosure,
								englishLinear: UnitClosure,
								englishRotation: UnitClosure) -> String {
		if exponent == 0 {
			return ""
		}
		
		let unitString: String
		let showExponent = exponent != 1
		switch system {
		case .none:
			unitString = "?"
		case .siLinear:
			unitString = siLinear(exponent)
		case .siRotation:
			unitString = siRotation(exponent)
		case .englishLinear:
			unitString = englishLinear(exponent)
		case .englishRotation:
			unitString = englishRotation(exponent)
		}
		
		if showExponent {
			return "\(unitString)^\(exponent)"
		} else {
			return unitString
		}
	}
}

extension HIDUnit: Equatable {
	
}
