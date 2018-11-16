//
//  HIDUnitTests.swift
//  SwiftyHIDTests
//
//  Created by James Linnell on 11/12/18.
//  Copyright © 2018 James Linnell. All rights reserved.
//

import XCTest
@testable import SwiftyHID

class HIDUnitTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDescription() {
		XCTAssertEqual("1", HIDUnit(withSystem: .siLinear, lengthExp: 0, massExp: 0, timeExp: 0, tempExp: 0, currentExp: 0, luminExp: 0).description)
		
        XCTAssertEqual("centimeter^2×gram/(second^2)", HIDUnit(withSystem: .siLinear, lengthExp: 2, massExp: 1, timeExp: -2, tempExp: 0, currentExp: 0, luminExp: 0).description)
		XCTAssertEqual("1/(second^2)", HIDUnit(withSystem: .siLinear, lengthExp: 0, massExp: 0, timeExp: -2, tempExp: 0, currentExp: 0, luminExp: 0).description)
		XCTAssertEqual("centimeter^2×gram", HIDUnit(withSystem: .siLinear, lengthExp: 2, massExp: 1, timeExp: 0, tempExp: 0, currentExp: 0, luminExp: 0).description)
		XCTAssertEqual("centimeter", HIDUnit(withSystem: .siLinear, lengthExp: 1, massExp: 0, timeExp: 0, tempExp: 0, currentExp: 0, luminExp: 0).description)
		
		XCTAssertEqual("centimeter×gram×second×kelvin×ampere×candela", HIDUnit(withSystem: .siLinear, lengthExp: 1, massExp: 1, timeExp: 1, tempExp: 1, currentExp: 1, luminExp: 1).description)
		XCTAssertEqual("radian×gram×second×kelvin×ampere×candela", HIDUnit(withSystem: .siRotation, lengthExp: 1, massExp: 1, timeExp: 1, tempExp: 1, currentExp: 1, luminExp: 1).description)
		XCTAssertEqual("inch×slug×second×farenheit×ampere×candela", HIDUnit(withSystem: .englishLinear, lengthExp: 1, massExp: 1, timeExp: 1, tempExp: 1, currentExp: 1, luminExp: 1).description)
		XCTAssertEqual("degree×slug×second×farenheit×ampere×candela", HIDUnit(withSystem: .englishRotation, lengthExp: 1, massExp: 1, timeExp: 1, tempExp: 1, currentExp: 1, luminExp: 1).description)
		
		XCTAssertEqual("1/(centimeter×gram×second×kelvin×ampere×candela)", HIDUnit(withSystem: .siLinear, lengthExp: -1, massExp: -1, timeExp: -1, tempExp: -1, currentExp: -1, luminExp: -1).description)
		XCTAssertEqual("1/(radian×gram×second×kelvin×ampere×candela)", HIDUnit(withSystem: .siRotation, lengthExp: -1, massExp: -1, timeExp: -1, tempExp: -1, currentExp: -1, luminExp: -1).description)
		XCTAssertEqual("1/(inch×slug×second×farenheit×ampere×candela)", HIDUnit(withSystem: .englishLinear, lengthExp: -1, massExp: -1, timeExp: -1, tempExp: -1, currentExp: -1, luminExp: -1).description)
		XCTAssertEqual("1/(degree×slug×second×farenheit×ampere×candela)", HIDUnit(withSystem: .englishRotation, lengthExp: -1, massExp: -1, timeExp: -1, tempExp: -1, currentExp: -1, luminExp: -1).description)
	}
	
	func testInitialization() {
		XCTAssertEqual(HIDUnit(withData: 0b00000000_00000000_00000000_00000000), HIDUnit(withSystem: .none, lengthExp: 0, massExp: 0, timeExp: 0, tempExp: 0, currentExp: 0, luminExp: 0))
		
		XCTAssertEqual(HIDUnit(withData: 0b00000000_00000000_00000000_00000001), HIDUnit(withSystem: .siLinear, lengthExp: 0, massExp: 0, timeExp: 0, tempExp: 0, currentExp: 0, luminExp: 0))
		
		XCTAssertEqual(HIDUnit(withData: 0b00000110_01010100_00110010_00010010), HIDUnit(withSystem: .siRotation, lengthExp: 1, massExp: 2, timeExp: 3, tempExp: 4, currentExp: 5, luminExp: 6))
		
		XCTAssertEqual(HIDUnit(withData: 0b11101101_11001011_10101001_10000011), HIDUnit(withSystem: .englishLinear, lengthExp: -8, massExp: -7, timeExp: -6, tempExp: -5, currentExp: -4, luminExp: -3))
	}

}
