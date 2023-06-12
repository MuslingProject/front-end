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
        if idField.text == "" || passField.text == "" {
            let alert = UIAlertController(title: "비어 있는 칸이 있습니다", message: "모두 입력해 주세요", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        } else {
            let id = idField.text
            
            let dataSave = UserDefaults.standard
            dataSave.setValue(id, forKey: "user_id")
            
            UserDefaults.standard.synchronize()
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
