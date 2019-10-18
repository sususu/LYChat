//
//  HomeVC.swift
//  Chat
//
//  Created by SuJiang on 2019/10/8.
//  Copyright © 2019 mingshimingjiao. All rights reserved.
//

import UIKit

class HomeVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "聊天demo"

        setNavLeftButton(text: "添加好友消息", sel: #selector(msgAction))
        
        setNavRightButton(text: "获取好友列表", sel: #selector(getFriendAction))
    
//        IMClient.shared.connect(host: "127.0.0.1", port: 11111) { (error) in
//            
//        }
    }

    override func viewDidAppear(_ animated: Bool) {
        if !User.shared.isLogin() {
            let vc = LoginVC()
            let nav = UINavigationController(rootViewController: vc)
            present(nav, animated: true, completion: nil)
        }
    }
    
    // MARK: 事件处理⌚️
    @objc func msgAction() {
        
    }
    
    @objc func getFriendAction() {
        
    }
}
