//
//  UtilsTesting.swift
//  SwiftyHIDTests
//
//  Created by James Linnell on 11/13/18.
//  Copyright © 2018 James Linnell. All rights reserved.
//

import XCTest
@testable import SwiftyHID

class UtilsTesting: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetNibble() {
        XCTAssertEqual(0, Utils.getNibble(data: 0, nibbleIndex: 0))
		XCTAssertEqual(1, Utils.getNibble(data: 1, nibbleIndex: 0))
		XCTAssertEqual(0, Utils.getNibble(data: UInt32(0b0000_0001), nibbleIndex: 1))
		XCTAssertEqual(1, Utils.getNibble(data: UInt32(0b0001_0000), nibbleIndex: 1))
		XCTAssertEqual(1, Utils.getNibble(data: UInt32(0b0001_0001), nibbleIndex: 1))
	}

}
