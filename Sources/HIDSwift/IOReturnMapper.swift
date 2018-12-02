//
//  IOReturnMapper.swift
//  HIDSwift
//
//  Created by Sherlock, James on 02/12/2018.
//

import Foundation
import IOKit.hid

enum IOReturnMapper: IOReturn {
    case kIOReturnSuccess = 0
    case kIOReturnError = -536870212
    case kIOReturnNoMemory = -536870211
    case kIOReturnNoResources = -536870210
    case kIOReturnIPCError = -536870209
    case kIOReturnNoDevice = -536870208
    case kIOReturnNotPrivileged = -536870207
    case kIOReturnBadArgument = -536870206
    case kIOReturnLockedRead = -536870205
    case kIOReturnLockedWrite = -536870204
    case kIOReturnExclusiveAccess = -536870203
    case kIOReturnBadMessageID = -536870202
    case kIOReturnUnsupported = -536870201
    case kIOReturnVMError = -536870200
    case kIOReturnInternalError = -536870199
    case kIOReturnIOError = -536870198
    case kIOReturnCannotLock = -536870196
    case kIOReturnNotOpen = -536870195
    case kIOReturnNotReadable = -536870194
    case kIOReturnNotWritable = -536870193
    case kIOReturnNotAligned = -536870192
    case kIOReturnBadMedia = -536870191
    case kIOReturnStillOpen = -536870190
    case kIOReturnRLDError = -536870189
    case kIOReturnDMAError = -536870188
    case kIOReturnBusy = -536870187
    case kIOReturnTimeout = -536870186
    case kIOReturnOffline = -536870185
    case kIOReturnNotReady = -536870184
    case kIOReturnNotAttached = -536870183
    case kIOReturnNoChannels = -536870182
    case kIOReturnNoSpace = -536870181
    case kIOReturnPortExists = -536870179
    case kIOReturnCannotWire = -536870178
    case kIOReturnNoInterrupt = -536870177
    case kIOReturnNoFrames = -536870176
    case kIOReturnMessageTooLarge = -536870175
    case kIOReturnNotPermitted = -536870174
    case kIOReturnNoPower = -536870173
    case kIOReturnNoMedia = -536870172
    case kIOReturnUnformattedMedia = -536870171
    case kIOReturnUnsupportedMode = -536870170
    case kIOReturnUnderrun = -536870169
    case kIOReturnOverrun = -536870168
    case kIOReturnDeviceError = -536870167
    case kIOReturnNoCompletion = -536870166
    case kIOReturnAborted = -536870165
    case kIOReturnNoBandwidth = -536870164
    case kIOReturnNotResponding = -536870163
    case kIOReturnIsoTooOld = -536870162
    case kIOReturnIsoTooNew = -536870161
    case kIOReturnNotFound = -536870160
    case kIOReturnInvalid = -536870911
}
