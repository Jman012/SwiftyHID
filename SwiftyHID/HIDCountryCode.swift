//
//  HIDCountryCode.swift
//  SwiftyHID
//
//  Created by James Linnell on 11/17/18.
//  Copyright © 2018 James Linnell. All rights reserved.
//

import Foundation

public enum HIDCountryCode {
	case notSupported
	case arabic
	case belgian
	case canadianBilingual
	case canadianFrench
	case czech
	case republic
	case danish
	case finnish
	case french
	case german
	case greek
	case hebrew
	case hungary
	case internationalISO
	case italian
	case japanKatakana
	case korean
	case latinAmerican
	case netherlandsDutch
	case norwegian
	case persianFarsi
	case poland
	case portuguese
	case russia
	case slovakia
	case spanish
	case swedish
	case swissFrench
	case swissGerman
	case switzerland
	case taiwan
	case turkishQ
	case uk
	case us
	case yugoslavia
	case turkishF
	case reserved(UInt)
	
	init(value: UInt) {
		switch value {
		case 0: self = .notSupported
		case 1: self = .arabic
		case 2: self = .belgian
		case 3: self = .canadianBilingual
		case 4: self = .canadianFrench
		case 5: self = .czech
		case 6: self = .republic
		case 7: self = .danish
		case 8: self = .finnish
		case 9: self = .french
		case 10: self = .german
		case 11: self = .greek
		case 12: self = .hebrew
		case 13: self = .hungary
		case 14: self = .internationalISO
		case 15: self = .italian
		case 16: self = .japanKatakana
		case 17: self = .korean
		case 18: self = .latinAmerican
		case 19: self = .netherlandsDutch
		case 20: self = .norwegian
		case 21: self = .persianFarsi
		case 22: self = .poland
		case 23: self = .portuguese
		case 24: self = .russia
		case 25: self = .slovakia
		case 26: self = .spanish
		case 27: self = .swedish
		case 28: self = .swissFrench
		case 29: self = .swissGerman
		case 30: self = .switzerland
		case 31: self = .taiwan
		case 32: self = .turkishQ
		case 33: self = .uk
		case 34: self = .us
		case 35: self = .yugoslavia
		case 36: self = .turkishF
		default: self = .reserved(value)
		}
	}
	
	var value: UInt {
		switch self {
		case .notSupported: return 0
		case .arabic: return 1
		case .belgian: return 2
		case .canadianBilingual: return 3
		case .canadianFrench: return 4
		case .czech: return 5
		case .republic: return 6
		case .danish: return 7
		case .finnish: return 8
		case .french: return 9
		case .german: return 10
		case .greek: return 11
		case .hebrew: return 12
		case .hungary: return 13
		case .internationalISO: return 14
		case .italian: return 15
		case .japanKatakana: return 16
		case .korean: return 17
		case .latinAmerican: return 18
		case .netherlandsDutch: return 19
		case .norwegian: return 20
		case .persianFarsi: return 21
		case .poland: return 22
		case .portuguese: return 23
		case .russia: return 24
		case .slovakia: return 25
		case .spanish: return 26
		case .swedish: return 27
		case .swissFrench: return 28
		case .swissGerman: return 29
		case .switzerland: return 30
		case .taiwan: return 31
		case .turkishQ: return 32
		case .uk: return 33
		case .us: return 34
		case .yugoslavia: return 35
		case .turkishF: return 36
		case .reserved(let n): return n
		}
	}
}
