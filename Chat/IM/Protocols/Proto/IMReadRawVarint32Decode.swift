//
//  IMReadRawVarint32Decode.swift
//  Chat
//
//  Created by SuJiang on 2019/10/9.
//  Copyright © 2019 mingshimingjiao. All rights reserved.
//

import UIKit

class IMReadRawVarint32Decode: NSObject, IMLengthDecodeProtocol {
    
    func decode(data: Data, index:inout Int) throws -> Int32 {
        
        let buffer = data.bytes
        
        var tmp = try readRawByte(buffer: buffer, bufferPos: &index)
        if tmp >= 0 {
            return Int32(tmp)
        }
        
        var result: Int32 = Int32(tmp) & 0x7f
        tmp = try readRawByte(buffer: buffer, bufferPos: &index)
        if tmp >= 0 {
            result |= Int32(tmp) << 7
        } else {
            result |= (Int32(tmp) & 0x7f) << 7
            tmp = try readRawByte(buffer: buffer,bufferPos: &index)
            if tmp >= 0 {
                result |= Int32(tmp) << 14
            } else {
                result |= (Int32(tmp) & 0x7f) << 14
                tmp = try readRawByte(buffer: buffer,bufferPos: &index)
                if (tmp >= 0) {
                    result |= Int32(tmp) << 21
                } else {
                    result |= (Int32(tmp) & 0x7f) << 21;
                    tmp = try readRawByte(buffer: buffer,bufferPos: &index)
                    result |= (Int32(tmp) << 28)
                    if (tmp < 0) {
                        // Discard upper 32 bits.
                        for _ in 0..<5 {
                            let byte = try readRawByte(buffer: buffer,bufferPos: &index)
                            if (byte >= 0) {
                                return result;
                            }
                        }
                                        
                        throw IMError.invalidProtocolbuffer
                    }
                }
            }
        }
        
        return result
    }
    
    
    fileprivate func readRawByte(buffer: [UInt8], bufferPos: inout Int) throws -> Int8 {
        if bufferPos == buffer.count {
            return -1
        }
        
        let res = buffer[Int(bufferPos)]
        bufferPos += 1
        
        var convert: Int8 = 0
        convert = convertTypes(convertValue: res, defaultValue: convert)
        
        return convert;
    }
    
    func convertTypes<T, ReturnType>(convertValue value: T, defaultValue:ReturnType) -> ReturnType {
        var retValue = defaultValue
        var curValue = value
        memcpy(&retValue, &curValue, MemoryLayout<T>.size)
        return retValue
    }
    
}
