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
    @IBOutlet var signUpLabel: UILabel!
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var rePwdLabel: UILabel!
    @IBOutlet var pwdLabel: UILabel!
    @IBOutlet var nextBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpLabel.attributedText = NSMutableAttributedString(string: signUpLabel.text!, attributes: [NSAttributedString.Key.kern: -0.7])
        idLabel.attributedText = NSMutableAttributedString(string: idLabel.text!, attributes: [NSAttributedString.Key.kern: -0.5, NSAttributedString.Key.font: UIFont(name: "Pretendard-Bold", size: 15)!])
        pwdLabel.attributedText = NSMutableAttributedString(string: pwdLabel.text!, attributes: [NSAttributedString.Key.kern: -0.5, NSAttributedString.Key.font: UIFont(name: "Pretendard-Bold", size: 15)!])
        rePwdLabel.attributedText = NSMutableAttributedString(string: rePwdLabel.text!, attributes: [NSAttributedString.Key.kern: -0.5, NSAttributedString.Key.font: UIFont(name: "Pretendard-Bold", size: 15)!])
        nextBtn.setAttributedTitle(NSAttributedString(string: "다음", attributes: [NSAttributedString.Key.font: UIFont(name: "Pretendard-SemiBold", size: 15)!, NSAttributedString.Key.kern: -0.5]), for: .normal)
        
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
            
            guard let vc = self.storyboard?.instantiateViewController(identifier: "ProfileVC") else { return }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
}
