//
//  LoginViewController.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/05/16.
//

import UIKit

class SignInViewController: UIViewController {
    
    @IBOutlet var idField: HSUnderLineTextField!
    @IBOutlet var passField: HSUnderLineTextField!
    
    // 로그인 버튼 클릭
    @IBAction func LoginBtn(_ sender: Any) {
        // 자동 로그인
        let id = idField.text
        
        let dataSave = UserDefaults.standard
        dataSave.setValue(id, forKey: "user_id")
        
        UserDefaults.standard.synchronize()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
