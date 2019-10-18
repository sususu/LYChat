//
//  User.swift
//  Chat
//
//  Created by SuJiang on 2019/10/8.
//  Copyright © 2019 mingshimingjiao. All rights reserved.
//

import UIKit

class User : Codable {
    
    static var kUserCacheKey = "kUserCacheKey"

    var id: Int64 = -1
    var name: String = "Unknown"
    var token: String?
    
    static let shared = User()
    
    private init() {
        read()
    }
    
    func isLogin() -> Bool {
        return token != nil
    }
    
    fileprivate func read() {
        guard let data = StorageUtils.getData(forKey: User.kUserCacheKey) else {
            return
        }
        
        do {
            let user = try JSONDecoder().decode(User.self, from: data)
            self.id = user.id
            self.name = user.name
            self.token = user.token
        } catch let err {
            print("user json decode error: \(err)")
        }
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(self)
            StorageUtils.save(data, forKey: User.kUserCacheKey)
        } catch let err {
            print("user json encode error: \(err)")
        }
    }
}
