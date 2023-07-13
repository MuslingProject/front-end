//
//  SignUpViewController.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/04/11.
//

import UIKit
import Alamofire

class SignUpViewController: UIViewController {
    
    
    @IBOutlet var idField: HSUnderLineTextField!
    @IBOutlet var passField: HSUnderLineTextField!
    @IBOutlet var repassField: HSUnderLineTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func nextBtn(_ sender: Any) {
        if idField.text == "" || passField.text == "" || repassField.text == "" {
            let alert = UIAlertController(title: "비어 있는 칸이 있습니다", message: "모두 입력해 주세요", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
        if passField.text != repassField.text {
            let alert = UIAlertController(title: "비밀번호가 일치하지 않습니다", message: "재입력이 올바르게 되었는지 확인해 주세요", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
            
        } else {
            Member.shared.user_id = idField.text
            Member.shared.pwd = passField.text
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
}
