//
//  WeakArray.swift
//  JoyConManager
//
//  Created by James Linnell on 9/29/18.
//  Copyright © 2018 James Linnell. All rights reserved.
//

import Foundation

final class Weak<A: AnyObject> {
	weak var unbox: A?
	init(_ value: A) {
		unbox = value
	}
}

struct WeakArray<Element: AnyObject> {
	internal var items: [Weak<Element>] = []
	
	init() {
		
	}
	
	init(_ elements: [Element]) {
		items = elements.map { Weak($0) }
	}
}

extension WeakArray: Collection {
	var startIndex: Int { return items.startIndex }
	var endIndex: Int { return items.endIndex }
	
	subscript(_ index: Int) -> Element? {
		return items[index].unbox
	}
	
	func index(after idx: Int) -> Int {
		return items.index(after: idx)
	}
}
