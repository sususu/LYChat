//
//  IMProtobufMessageDecoder.swift
//  Chat
//
//  Created by SuJiang on 2019/10/9.
//  Copyright © 2019 mingshimingjiao. All rights reserved.
//

import UIKit

class IMProtobufMessageDecoder: NSObject, IMContentDecodeProtocol {
    func decode<T>(data: Data) throws -> T {
        do {
            
            let stream = InputStream.init(data: data)
            stream.open()
            var message = Message()
            try BinaryDelimited.merge(into:&message, from: stream)
            stream.close()
            
            
            // 处理消息
            
            
        } catch {
            
        }
    }
}
