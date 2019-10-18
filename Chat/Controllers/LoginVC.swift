//
//  LoginVC.swift
//  Chat
//
//  Created by SuJiang on 2019/10/8.
//  Copyright © 2019 mingshimingjiao. All rights reserved.
//

import UIKit

class LoginVC: BaseViewController {

    @IBOutlet weak var usernameTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "登录"
        setNavLeftButton(withIcon: "fanhui", sel: #selector(fanhuiAction))
    }


    @objc func fanhuiAction() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }

    @IBAction func loginAction(_ sender: Any) {
        
        
        
    }
    
    
    @IBAction func registerAction(_ sender: Any) {
        
        let vc = RegisterVC()
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}
