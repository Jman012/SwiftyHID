//
//  Utils.swift
//  JoyConManager
//
//  Created by James Linnell on 10/14/18.
//  Copyright © 2018 James Linnell. All rights reserved.
//

import Foundation

class Utils {
	static func createArray<T: Numeric>(pointer: UnsafePointer<T>, length: Int) -> Array<T> {
		var array = Array<T>(repeating: 0, count: length)
		for i in 0..<length {
			array[i] = pointer.advanced(by: i).pointee
		}
		return array
	}
}
