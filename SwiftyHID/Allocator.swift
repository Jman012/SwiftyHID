//
//  Allocator.swift
//  JoyConManager
//
//  Created by James Linnell on 9/22/18.
//  Copyright © 2018 James Linnell. All rights reserved.
//

import Foundation
import IOKit

public enum Allocator {
	/** This is a synonym for NULL, if you'd rather use a named constant. */
	case defaultAllocator
	
	/** Default system allocator; you rarely need to use this. */
	case systemDefault
	
	/** This allocator uses malloc(), realloc(), and free(). This should not be
	 generally used; stick to kCFAllocatorDefault whenever possible. This
	 allocator is useful as the "bytesDeallocator" in CFData or
	 "contentsDeallocator" in CFString where the memory was obtained as a
	 result of malloc() type functions.
	 */
	case malloc
	
	/** This allocator explicitly uses the default malloc zone, returned by
	 malloc_default_zone(). It should only be used when an object is
	 safe to be allocated in non-scanned memory.
	 */
	case mallocZone
	
	/** Null allocator which does nothing and allocates no memory. This allocator
	 is useful as the "bytesDeallocator" in CFData or "contentsDeallocator"
	 in CFString where the memory should not be freed.
	 */
	case null
	
	/** Special allocator argument to CFAllocatorCreate() which means
	 "use the functions given in the context to allocate the allocator
	 itself as well".
	 */
	case useContext
	
	var value: CFAllocator {
		switch self {
		case .defaultAllocator: return kCFAllocatorDefault
		case .systemDefault: return kCFAllocatorSystemDefault
		case .malloc: return kCFAllocatorMalloc
		case .mallocZone: return kCFAllocatorMallocZone
		case .null: return kCFAllocatorNull
		case .useContext: return kCFAllocatorUseContext
		}
	}
}
