//
//  HIDDescriptorItemTests.swift
//  SwiftyHIDTests
//
//  Created by James Linnell on 11/11/18.
//  Copyright © 2018 James Linnell. All rights reserved.
//

import XCTest
import Foundation
@testable import SwiftyHID

class HIDDescriptorItemTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
	
	func testInputData() {
		// These are taken from the HID Spec
		XCTAssertEqual(HIDDescriptorMainInputData(data: 0b0000_0000).dataOrConstant, DataOrConstant.data)
		XCTAssertEqual(HIDDescriptorMainInputData(data: 0b0000_0001).dataOrConstant, DataOrConstant.constant)
		
		XCTAssertEqual(HIDDescriptorMainInputData(data: 0b0000_0000).arrayOrVariable, ArrayOrVariable.array)
		XCTAssertEqual(HIDDescriptorMainInputData(data: 0b0000_0010).arrayOrVariable, ArrayOrVariable.variable)
		
		XCTAssertEqual(HIDDescriptorMainInputData(data: 0b0000_0000).absoluteOrRelative, AbsoluteOrRelative.absolute)
		XCTAssertEqual(HIDDescriptorMainInputData(data: 0b0000_0100).absoluteOrRelative, AbsoluteOrRelative.relative)
		
		XCTAssertEqual(HIDDescriptorMainInputData(data: 0b0000_0000).noWrapOrWrap, NoWrapOrWrap.noWrap)
		XCTAssertEqual(HIDDescriptorMainInputData(data: 0b0000_1000).noWrapOrWrap, NoWrapOrWrap.wrap)
		
		XCTAssertEqual(HIDDescriptorMainInputData(data: 0b0000_0000).linearOrNonLinear, LinearOrNonLinear.linear)
		XCTAssertEqual(HIDDescriptorMainInputData(data: 0b0001_0000).linearOrNonLinear, LinearOrNonLinear.nonLinear)
		
		XCTAssertEqual(HIDDescriptorMainInputData(data: 0b0000_0000).preferredOrNoPreferredState, PreferredOrNoPreferredState.preferredState)
		XCTAssertEqual(HIDDescriptorMainInputData(data: 0b0010_0000).preferredOrNoPreferredState, PreferredOrNoPreferredState.noPreferredState)
		
		XCTAssertEqual(HIDDescriptorMainInputData(data: 0b0000_0000).noNullPositionOrNullState, NoNullPositionOrNullState.noNullPosition)
		XCTAssertEqual(HIDDescriptorMainInputData(data: 0b0100_0000).noNullPositionOrNullState, NoNullPositionOrNullState.nullState)
		
		XCTAssertEqual(HIDDescriptorMainInputData(data: 0b0000_0000_0000).bitFieldOrBufferedBytes, BitFieldOrBufferedBytes.bitField)
		XCTAssertEqual(HIDDescriptorMainInputData(data: 0b0001_0000_0000).bitFieldOrBufferedBytes, BitFieldOrBufferedBytes.bufferedBytes)
	}
	
	func testOutputData() {
		// These are taken from the HID Spec
		XCTAssertEqual(HIDDescriptorMainOutputData(data: 0b0000_0000).dataOrConstant, DataOrConstant.data)
		XCTAssertEqual(HIDDescriptorMainOutputData(data: 0b0000_0001).dataOrConstant, DataOrConstant.constant)
		
		XCTAssertEqual(HIDDescriptorMainOutputData(data: 0b0000_0000).arrayOrVariable, ArrayOrVariable.array)
		XCTAssertEqual(HIDDescriptorMainOutputData(data: 0b0000_0010).arrayOrVariable, ArrayOrVariable.variable)
		
		XCTAssertEqual(HIDDescriptorMainOutputData(data: 0b0000_0000).absoluteOrRelative, AbsoluteOrRelative.absolute)
		XCTAssertEqual(HIDDescriptorMainOutputData(data: 0b0000_0100).absoluteOrRelative, AbsoluteOrRelative.relative)
		
		XCTAssertEqual(HIDDescriptorMainOutputData(data: 0b0000_0000).noWrapOrWrap, NoWrapOrWrap.noWrap)
		XCTAssertEqual(HIDDescriptorMainOutputData(data: 0b0000_1000).noWrapOrWrap, NoWrapOrWrap.wrap)
		
		XCTAssertEqual(HIDDescriptorMainOutputData(data: 0b0000_0000).linearOrNonLinear, LinearOrNonLinear.linear)
		XCTAssertEqual(HIDDescriptorMainOutputData(data: 0b0001_0000).linearOrNonLinear, LinearOrNonLinear.nonLinear)
		
		XCTAssertEqual(HIDDescriptorMainOutputData(data: 0b0000_0000).preferredOrNoPreferredState, PreferredOrNoPreferredState.preferredState)
		XCTAssertEqual(HIDDescriptorMainOutputData(data: 0b0010_0000).preferredOrNoPreferredState, PreferredOrNoPreferredState.noPreferredState)
		
		XCTAssertEqual(HIDDescriptorMainOutputData(data: 0b0000_0000).noNullPositionOrNullState, NoNullPositionOrNullState.noNullPosition)
		XCTAssertEqual(HIDDescriptorMainOutputData(data: 0b0100_0000).noNullPositionOrNullState, NoNullPositionOrNullState.nullState)
		
		XCTAssertEqual(HIDDescriptorMainOutputData(data: 0b0000_0000).nonVolatileOrVolatile, NonVolatileOrVolatile.nonVolatile)
		XCTAssertEqual(HIDDescriptorMainOutputData(data: 0b1000_0000).nonVolatileOrVolatile, NonVolatileOrVolatile.volatile)
		
		XCTAssertEqual(HIDDescriptorMainOutputData(data: 0b0000_0000_0000).bitFieldOrBufferedBytes, BitFieldOrBufferedBytes.bitField)
		XCTAssertEqual(HIDDescriptorMainOutputData(data: 0b0001_0000_0000).bitFieldOrBufferedBytes, BitFieldOrBufferedBytes.bufferedBytes)
	}
	
	func testFeatureData() {
		// These are taken from the HID Spec
		XCTAssertEqual(HIDDescriptorMainFeatureData(data: 0b0000_0000).dataOrConstant, DataOrConstant.data)
		XCTAssertEqual(HIDDescriptorMainFeatureData(data: 0b0000_0001).dataOrConstant, DataOrConstant.constant)
		
		XCTAssertEqual(HIDDescriptorMainFeatureData(data: 0b0000_0000).arrayOrVariable, ArrayOrVariable.array)
		XCTAssertEqual(HIDDescriptorMainFeatureData(data: 0b0000_0010).arrayOrVariable, ArrayOrVariable.variable)
		
		XCTAssertEqual(HIDDescriptorMainFeatureData(data: 0b0000_0000).absoluteOrRelative, AbsoluteOrRelative.absolute)
		XCTAssertEqual(HIDDescriptorMainFeatureData(data: 0b0000_0100).absoluteOrRelative, AbsoluteOrRelative.relative)
		
		XCTAssertEqual(HIDDescriptorMainFeatureData(data: 0b0000_0000).noWrapOrWrap, NoWrapOrWrap.noWrap)
		XCTAssertEqual(HIDDescriptorMainFeatureData(data: 0b0000_1000).noWrapOrWrap, NoWrapOrWrap.wrap)
		
		XCTAssertEqual(HIDDescriptorMainFeatureData(data: 0b0000_0000).linearOrNonLinear, LinearOrNonLinear.linear)
		XCTAssertEqual(HIDDescriptorMainFeatureData(data: 0b0001_0000).linearOrNonLinear, LinearOrNonLinear.nonLinear)
		
		XCTAssertEqual(HIDDescriptorMainFeatureData(data: 0b0000_0000).preferredOrNoPreferredState, PreferredOrNoPreferredState.preferredState)
		XCTAssertEqual(HIDDescriptorMainFeatureData(data: 0b0010_0000).preferredOrNoPreferredState, PreferredOrNoPreferredState.noPreferredState)
		
		XCTAssertEqual(HIDDescriptorMainFeatureData(data: 0b0000_0000).noNullPositionOrNullState, NoNullPositionOrNullState.noNullPosition)
		XCTAssertEqual(HIDDescriptorMainFeatureData(data: 0b0100_0000).noNullPositionOrNullState, NoNullPositionOrNullState.nullState)
		
		XCTAssertEqual(HIDDescriptorMainFeatureData(data: 0b0000_0000).nonVolatileOrVolatile, NonVolatileOrVolatile.nonVolatile)
		XCTAssertEqual(HIDDescriptorMainFeatureData(data: 0b1000_0000).nonVolatileOrVolatile, NonVolatileOrVolatile.volatile)
		
		XCTAssertEqual(HIDDescriptorMainFeatureData(data: 0b0000_0000_0000).bitFieldOrBufferedBytes, BitFieldOrBufferedBytes.bitField)
		XCTAssertEqual(HIDDescriptorMainFeatureData(data: 0b0001_0000_0000).bitFieldOrBufferedBytes, BitFieldOrBufferedBytes.bufferedBytes)
	}

    func testCollection() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
		
		// These are taken from the HID Spec
		XCTAssertEqual(HIDDescriptorMainCollectionType(data: 0x00), HIDDescriptorMainCollectionType.physical)
		XCTAssertEqual(HIDDescriptorMainCollectionType(data: 0x01), HIDDescriptorMainCollectionType.application)
		XCTAssertEqual(HIDDescriptorMainCollectionType(data: 0x02), HIDDescriptorMainCollectionType.logical)
		XCTAssertEqual(HIDDescriptorMainCollectionType(data: 0x03), HIDDescriptorMainCollectionType.report)
		XCTAssertEqual(HIDDescriptorMainCollectionType(data: 0x04), HIDDescriptorMainCollectionType.namedArray)
		XCTAssertEqual(HIDDescriptorMainCollectionType(data: 0x05), HIDDescriptorMainCollectionType.usageSwitch)
		XCTAssertEqual(HIDDescriptorMainCollectionType(data: 0x06), HIDDescriptorMainCollectionType.usageModifier)
		for n: UInt8 in 0x07...0x7F {
			XCTAssertEqual(HIDDescriptorMainCollectionType(data: UInt32(n)), HIDDescriptorMainCollectionType.reserved(n))
		}
		for n: UInt32 in 0x80...0xFF {
			XCTAssertEqual(HIDDescriptorMainCollectionType(data: n), HIDDescriptorMainCollectionType.vendorDefined(n))
		}
		
    }

}
