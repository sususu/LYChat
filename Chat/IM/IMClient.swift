//
//  IMClient.swift
//  Chat
//
//  Created by SuJiang on 2019/10/8.
//  Copyright © 2019 mingshimingjiao. All rights reserved.
//

import UIKit
import CocoaAsyncSocket

enum IMClientState: Int {
    case disconnected
    case connecting
    case connected
}


class IMClient: NSObject, GCDAsyncSocketDelegate {

    fileprivate var socket: GCDAsyncSocket!
    
    var queue: DispatchQueue!
    
    fileprivate var toHost: String?
    fileprivate var toPort: UInt16?
    fileprivate var toUrl: URL?
    
    var state: IMClientState = .disconnected
    
    var connectBlock: ErrorBlock?
    var disconnectBlock: ErrorBlock?
    
    private override init() {
        super.init()
        queue = DispatchQueue(label: "GCDAsyncSocketQueue")
        socket = GCDAsyncSocket(delegate: self, delegateQueue: queue)
        
    }
    
    convenience init(host: String, port: UInt16) {
        self.init()
        self.toHost = host
        self.toPort = port
    }
    
    convenience init(url: URL) {
        self.init()
        self.toUrl = url
    }
    
    func connect(timeout: TimeInterval = -1, callback: ErrorBlock?) {
        
        // 如果正在连接，则直接返回
        if state == .connecting {
            callback?(IMError.connecting)
            return
        }
        
        if state == .connected {
            callback?(IMError.connected)
            return
        }
        
        connectBlock = callback
        do {
            if toHost != nil && toPort != nil {
                try socket.connect(toHost: toHost!, onPort: toPort!, withTimeout: timeout)
            } else {
                try socket.connect(to: toUrl!, withTimeout: timeout)
            }
        } catch let err {
            callback?(socketErrorToLocalError(err))
            return
        }
    }
    
    func disconnect(callback: ErrorBlock?) {
        if socket.isConnected {
            socket.disconnect()
        } else {
            callback?(nil)
        }
        connectBlock = nil
    }
    
    
    // MARK: Socket delegate
    func socket(_ sock: GCDAsyncSocket, didConnectToHost host: String, port: UInt16) {
        print("connected: \(host):\(port)")
        connectBlock?(nil)
        disconnectBlock = nil
        connectBlock = nil
    }
    
    func socketDidDisconnect(_ sock: GCDAsyncSocket, withError err: Error?) {
//        err.customMirror.cod
        var error = socketErrorToLocalError(err)
        // 正常的断开链接
        switch error {
        case IMError.good:
            disconnectBlock?(nil)
            return
        case IMError.other:
            error = IMError.unreachable
        default:
            print("...")
        }
        
        connectBlock?(error)
        disconnectBlock = nil
        connectBlock = nil
    }
    
    func socket(_ sock: GCDAsyncSocket, didWriteDataWithTag tag: Int) {
        
    }
    
    func socket(_ sock: GCDAsyncSocket, didRead data: Data, withTag tag: Int) {
        
    }
    
    func socket(_ sock: GCDAsyncSocket, didReceive trust: SecTrust, completionHandler: @escaping (Bool) -> Void) {
        
        
    }
    
    // MARK: utils
    func socketErrorToLocalError(_ error: Error?) -> IMError {
        if error == nil {
            return IMError.good
        }
        let err = error! as NSError
        switch err.code {
        case 0:
            return IMError.good
        case 1:
            return IMError.badConfig
        case 2:
            return IMError.badParam
        case 3:
            return IMError.connectTimeout
        case 4:
            return IMError.readTimeout
        case 5:
            return IMError.writeTimeout
        case 6:
            return IMError.readMaxedOut
        case 7:
            return IMError.closed
        default:
            return IMError.other
        }
        
    }
    
}
