//
//  Return.swift
//  SwiftyHID
//
//  Created by James Linnell on 9/22/18.
//  Copyright © 2018 James Linnell. All rights reserved.
//

import Foundation

public enum Return {
	case aborted
	case badArgument
	case badMedia
	case badMessageID
	case busy
	case cannotLock
	case cannotWire
	case dmaError
	case deviceError
	case error
	case exclusiveAccess
	case ioError
	case ipcError
	case internalError
	case invalid
	case isoTooNew
	case isoTooOld
	case lockedRead
	case lockedWrite
	case messageTooLarge
	case noBandwidth
	case noChannels
	case noCompletion
	case noDevice
	case noFrames
	case noInterrupt
	case noMedia
	case noMemory
	case noPower
	case noResources
	case noSpace
	case notAligned
	case notAttached
	case notFound
	case notOpen
	case notPermitted
	case notPrivileged
	case notReadable
	case notReady
	case notResponding
	case notWritable
	case offline
	case overrun
	case portExists
	case rldError
	case stillOpen
	case success
	case timeout
	case underrun
	case unformattedMedia
	case unsupported
	case unsupportedMode
	case vmError
	case other(IOReturn)
	
	var value: IOReturn {
		switch self {
		case .aborted: return kIOReturnAborted
		case .badArgument: return kIOReturnBadArgument
		case .badMedia: return kIOReturnBadMedia
		case .badMessageID: return kIOReturnBadMessageID
		case .busy: return kIOReturnBusy
		case .cannotLock: return kIOReturnCannotLock
		case .cannotWire: return kIOReturnCannotWire
		case .dmaError: return kIOReturnDMAError
		case .deviceError: return kIOReturnDeviceError
		case .error: return kIOReturnError
		case .exclusiveAccess: return kIOReturnExclusiveAccess
		case .ioError: return kIOReturnIOError
		case .ipcError: return kIOReturnIPCError
		case .internalError: return kIOReturnInternalError
		case .invalid: return kIOReturnInvalid
		case .isoTooNew: return kIOReturnIsoTooNew
		case .isoTooOld: return kIOReturnIsoTooOld
		case .lockedRead: return kIOReturnLockedRead
		case .lockedWrite: return kIOReturnLockedWrite
		case .messageTooLarge: return kIOReturnMessageTooLarge
		case .noBandwidth: return kIOReturnNoBandwidth
		case .noChannels: return kIOReturnNoChannels
		case .noCompletion: return kIOReturnNoCompletion
		case .noDevice: return kIOReturnNoDevice
		case .noFrames: return kIOReturnNoFrames
		case .noInterrupt: return kIOReturnNoInterrupt
		case .noMedia: return kIOReturnNoMedia
		case .noMemory: return kIOReturnNoMemory
		case .noPower: return kIOReturnNoPower
		case .noResources: return kIOReturnNoResources
		case .noSpace: return kIOReturnNoSpace
		case .notAligned: return kIOReturnNotAligned
		case .notAttached: return kIOReturnNotAttached
		case .notFound: return kIOReturnNotFound
		case .notOpen: return kIOReturnNotOpen
		case .notPermitted: return kIOReturnNotPermitted
		case .notPrivileged: return kIOReturnNotPrivileged
		case .notReadable: return kIOReturnNotReadable
		case .notReady: return kIOReturnNotReady
		case .notResponding: return kIOReturnNotResponding
		case .notWritable: return kIOReturnNotWritable
		case .offline: return kIOReturnOffline
		case .overrun: return kIOReturnOverrun
		case .portExists: return kIOReturnPortExists
		case .rldError: return kIOReturnRLDError
		case .stillOpen: return kIOReturnStillOpen
		case .success: return kIOReturnSuccess
		case .timeout: return kIOReturnTimeout
		case .underrun: return kIOReturnUnderrun
		case .unformattedMedia: return kIOReturnUnformattedMedia
		case .unsupported: return kIOReturnUnsupported
		case .unsupportedMode: return kIOReturnUnsupportedMode
		case .vmError: return kIOReturnVMError
		case .other(let val): return val
		}
	}
	
	init(with value: IOReturn) {
		switch value {
		case kIOReturnAborted: self = .aborted
		case kIOReturnBadArgument: self = .badArgument
		case kIOReturnBadMedia: self = .badMedia
		case kIOReturnBadMessageID: self = .badMessageID
		case kIOReturnBusy: self = .busy
		case kIOReturnCannotLock: self = .cannotLock
		case kIOReturnCannotWire: self = .cannotWire
		case kIOReturnDMAError: self = .dmaError
		case kIOReturnDeviceError: self = .deviceError
		case kIOReturnError: self = .error
		case kIOReturnExclusiveAccess: self = .exclusiveAccess
		case kIOReturnIOError: self = .ioError
		case kIOReturnIPCError: self = .ipcError
		case kIOReturnInternalError: self = .internalError
		case kIOReturnInvalid: self = .invalid
		case kIOReturnIsoTooNew: self = .isoTooNew
		case kIOReturnIsoTooOld: self = .isoTooOld
		case kIOReturnLockedRead: self = .lockedRead
		case kIOReturnLockedWrite: self = .lockedWrite
		case kIOReturnMessageTooLarge: self = .messageTooLarge
		case kIOReturnNoBandwidth: self = .noBandwidth
		case kIOReturnNoChannels: self = .noChannels
		case kIOReturnNoCompletion: self = .noCompletion
		case kIOReturnNoDevice: self = .noDevice
		case kIOReturnNoFrames: self = .noFrames
		case kIOReturnNoInterrupt: self = .noInterrupt
		case kIOReturnNoMedia: self = .noMedia
		case kIOReturnNoMemory: self = .noMemory
		case kIOReturnNoPower: self = .noPower
		case kIOReturnNoResources: self = .noResources
		case kIOReturnNoSpace: self = .noSpace
		case kIOReturnNotAligned: self = .notAligned
		case kIOReturnNotAttached: self = .notAttached
		case kIOReturnNotFound: self = .notFound
		case kIOReturnNotOpen: self = .notOpen
		case kIOReturnNotPermitted: self = .notPermitted
		case kIOReturnNotPrivileged: self = .notPrivileged
		case kIOReturnNotReadable: self = .notReadable
		case kIOReturnNotReady: self = .notReady
		case kIOReturnNotResponding: self = .notResponding
		case kIOReturnNotWritable: self = .notWritable
		case kIOReturnOffline: self = .offline
		case kIOReturnOverrun: self = .overrun
		case kIOReturnPortExists: self = .portExists
		case kIOReturnRLDError: self = .rldError
		case kIOReturnStillOpen: self = .stillOpen
		case kIOReturnSuccess: self = .success
		case kIOReturnTimeout: self = .timeout
		case kIOReturnUnderrun: self = .underrun
		case kIOReturnUnformattedMedia: self = .unformattedMedia
		case kIOReturnUnsupported: self = .unsupported
		case kIOReturnUnsupportedMode: self = .unsupportedMode
		case kIOReturnVMError: self = .vmError
		default: self = .other(value)
		}
	}
}
