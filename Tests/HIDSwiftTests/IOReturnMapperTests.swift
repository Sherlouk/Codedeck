//
//  IOReturnMapperTests.swift
//  HIDSwiftTests
//
//  Created by Sherlock, James on 02/12/2018.
//

import XCTest
@testable import HIDSwift

class IOReturnMapperTests: XCTestCase {
    
    func testCreation() {
        XCTAssertEqual(IOReturnMapper(rawValue: kIOReturnSuccess), .kIOReturnSuccess)
        XCTAssertNil(IOReturnMapper(rawValue: 1))
    }
    
    func testMapping() {
        XCTAssertEqual(kIOReturnSuccess, IOReturnMapper.kIOReturnSuccess.rawValue)
        XCTAssertEqual(kIOReturnError, IOReturnMapper.kIOReturnError.rawValue)
        XCTAssertEqual(kIOReturnNoMemory, IOReturnMapper.kIOReturnNoMemory.rawValue)
        XCTAssertEqual(kIOReturnNoResources, IOReturnMapper.kIOReturnNoResources.rawValue)
        XCTAssertEqual(kIOReturnIPCError, IOReturnMapper.kIOReturnIPCError.rawValue)
        XCTAssertEqual(kIOReturnNoDevice, IOReturnMapper.kIOReturnNoDevice.rawValue)
        XCTAssertEqual(kIOReturnNotPrivileged, IOReturnMapper.kIOReturnNotPrivileged.rawValue)
        XCTAssertEqual(kIOReturnBadArgument, IOReturnMapper.kIOReturnBadArgument.rawValue)
        XCTAssertEqual(kIOReturnLockedRead, IOReturnMapper.kIOReturnLockedRead.rawValue)
        XCTAssertEqual(kIOReturnLockedWrite, IOReturnMapper.kIOReturnLockedWrite.rawValue)
        XCTAssertEqual(kIOReturnExclusiveAccess, IOReturnMapper.kIOReturnExclusiveAccess.rawValue)
        XCTAssertEqual(kIOReturnBadMessageID, IOReturnMapper.kIOReturnBadMessageID.rawValue)
        XCTAssertEqual(kIOReturnUnsupported, IOReturnMapper.kIOReturnUnsupported.rawValue)
        XCTAssertEqual(kIOReturnVMError, IOReturnMapper.kIOReturnVMError.rawValue)
        XCTAssertEqual(kIOReturnInternalError, IOReturnMapper.kIOReturnInternalError.rawValue)
        XCTAssertEqual(kIOReturnIOError, IOReturnMapper.kIOReturnIOError.rawValue)
        XCTAssertEqual(kIOReturnCannotLock, IOReturnMapper.kIOReturnCannotLock.rawValue)
        XCTAssertEqual(kIOReturnNotOpen, IOReturnMapper.kIOReturnNotOpen.rawValue)
        XCTAssertEqual(kIOReturnNotReadable, IOReturnMapper.kIOReturnNotReadable.rawValue)
        XCTAssertEqual(kIOReturnNotWritable, IOReturnMapper.kIOReturnNotWritable.rawValue)
        XCTAssertEqual(kIOReturnNotAligned, IOReturnMapper.kIOReturnNotAligned.rawValue)
        XCTAssertEqual(kIOReturnBadMedia, IOReturnMapper.kIOReturnBadMedia.rawValue)
        XCTAssertEqual(kIOReturnStillOpen, IOReturnMapper.kIOReturnStillOpen.rawValue)
        XCTAssertEqual(kIOReturnRLDError, IOReturnMapper.kIOReturnRLDError.rawValue)
        XCTAssertEqual(kIOReturnDMAError, IOReturnMapper.kIOReturnDMAError.rawValue)
        XCTAssertEqual(kIOReturnBusy, IOReturnMapper.kIOReturnBusy.rawValue)
        XCTAssertEqual(kIOReturnTimeout, IOReturnMapper.kIOReturnTimeout.rawValue)
        XCTAssertEqual(kIOReturnOffline, IOReturnMapper.kIOReturnOffline.rawValue)
        XCTAssertEqual(kIOReturnNotReady, IOReturnMapper.kIOReturnNotReady.rawValue)
        XCTAssertEqual(kIOReturnNotAttached, IOReturnMapper.kIOReturnNotAttached.rawValue)
        XCTAssertEqual(kIOReturnNoChannels, IOReturnMapper.kIOReturnNoChannels.rawValue)
        XCTAssertEqual(kIOReturnNoSpace, IOReturnMapper.kIOReturnNoSpace.rawValue)
        XCTAssertEqual(kIOReturnPortExists, IOReturnMapper.kIOReturnPortExists.rawValue)
        XCTAssertEqual(kIOReturnCannotWire, IOReturnMapper.kIOReturnCannotWire.rawValue)
        XCTAssertEqual(kIOReturnNoInterrupt, IOReturnMapper.kIOReturnNoInterrupt.rawValue)
        XCTAssertEqual(kIOReturnNoFrames, IOReturnMapper.kIOReturnNoFrames.rawValue)
        XCTAssertEqual(kIOReturnMessageTooLarge, IOReturnMapper.kIOReturnMessageTooLarge.rawValue)
        XCTAssertEqual(kIOReturnNotPermitted, IOReturnMapper.kIOReturnNotPermitted.rawValue)
        XCTAssertEqual(kIOReturnNoPower, IOReturnMapper.kIOReturnNoPower.rawValue)
        XCTAssertEqual(kIOReturnNoMedia, IOReturnMapper.kIOReturnNoMedia.rawValue)
        XCTAssertEqual(kIOReturnUnformattedMedia, IOReturnMapper.kIOReturnUnformattedMedia.rawValue)
        XCTAssertEqual(kIOReturnUnsupportedMode, IOReturnMapper.kIOReturnUnsupportedMode.rawValue)
        XCTAssertEqual(kIOReturnUnderrun, IOReturnMapper.kIOReturnUnderrun.rawValue)
        XCTAssertEqual(kIOReturnOverrun, IOReturnMapper.kIOReturnOverrun.rawValue)
        XCTAssertEqual(kIOReturnDeviceError, IOReturnMapper.kIOReturnDeviceError.rawValue)
        XCTAssertEqual(kIOReturnNoCompletion, IOReturnMapper.kIOReturnNoCompletion.rawValue)
        XCTAssertEqual(kIOReturnAborted, IOReturnMapper.kIOReturnAborted.rawValue)
        XCTAssertEqual(kIOReturnNoBandwidth, IOReturnMapper.kIOReturnNoBandwidth.rawValue)
        XCTAssertEqual(kIOReturnNotResponding, IOReturnMapper.kIOReturnNotResponding.rawValue)
        XCTAssertEqual(kIOReturnIsoTooOld, IOReturnMapper.kIOReturnIsoTooOld.rawValue)
        XCTAssertEqual(kIOReturnIsoTooNew, IOReturnMapper.kIOReturnIsoTooNew.rawValue)
        XCTAssertEqual(kIOReturnNotFound, IOReturnMapper.kIOReturnNotFound.rawValue)
        XCTAssertEqual(kIOReturnInvalid, IOReturnMapper.kIOReturnInvalid.rawValue)
    }
}
