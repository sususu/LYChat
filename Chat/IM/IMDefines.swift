//
//  IMDefines.swift
//  Chat
//
//  Created by SuJiang on 2019/10/8.
//  Copyright © 2019 mingshimingjiao. All rights reserved.
//

import Foundation

// MARK: Error 定义

public enum IMError: Error {
    case good               // No error
    case badConfig          // Invalid configuration
    case badParam           // Invalid parameter was passed
    case connectTimeout     // A connect operation timed out
    case readTimeout        // A read operation timed out
    case writeTimeout       // A write operation timed out
    case readMaxedOut       // Reached set maxLength without completing
    case closed             // The remote peer closed the connection
    case badnetwork         // local network is bad
    case unreachable        // server unavailable
    case connecting         // is connecting
    case connected          // is connected
    case disconnected       // is disconnected
    case decodeLength       // decode length error
    case invalidProtocolbuffer  //buffer can not decode
    case illegalState(String)
    case illegalArgument(String)
    case outOfSpace
    case other              // Description provided in userInfo
}

public typealias ErrorBlock = (IMError?)->Void


protocol IMLengthDecodeProtocol {
    func decode(data: Data, index:inout Int) throws -> Int32
}

protocol IMContentDecodeProtocol {
    func decode<T>(data: Data) throws -> T
}
