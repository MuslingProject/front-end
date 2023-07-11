//
//  LoginViewController.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/05/16.
//

import UIKit
import Alamofire

class SignInViewController: UIViewController {
    
    @IBOutlet var idField: HSUnderLineTextField!
    @IBOutlet var passField: HSUnderLineTextField!
    
    // 로그인 버튼 클릭
    @IBAction func LoginBtn(_ sender: Any) {
        
        // id, pass 필드 비어 있는지 확인
        if idField.text == "" || passField.text == "" {
            let alert = UIAlertController(title: "비어 있는 칸이 있습니다", message: "모두 입력해 주세요", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        } else { // 비어 있지 않다면
            let id = idField.text!
            let pwd = passField.text!
            
            // 로그인
            SignService.shared.signIn(userId: id, pwd: pwd) { response in
                switch response {
                case .success(let data):
                    if let data = data as? TokenModel {
                        print(data.message)
                        switch data.message {
                        case "로그인 성공":
                            Member.shared.user_id = id
                            self.goToMain() // 홈으로 이동
                        case "가입되지 않은 아이디입니다.":
                            print(data.message)
                            // 알림창 띄우기
                        case "아이디 또는 비밀번호가 맞지 않습니다.":
                            print(data.message)
                        default:
                            print("default")
                        }
                    }
                case .pathErr:
                    print("결과 :: Path Err")
                case .requestErr:
                    print("결과 :: Request Err")
                case .serverErr:
                    print("결과 :: Server Err")
                case .networkFail:
                    print("결과 :: Network Fail")
                }
            }
            
            // 자동 로그인을 위해 아이디 저장
            let dataSave = UserDefaults.standard
            dataSave.setValue(id, forKey: "user_id")
            
            UserDefaults.standard.synchronize()
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func goToMain() {
        
        // 홈으로 이동
        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC")
        vcName?.modalPresentationStyle = .fullScreen
        vcName?.modalTransitionStyle = .crossDissolve
        self.present(vcName!, animated: true, completion: nil)
        
        // 자동로그인 위해 UserDefaults에 저장
        let dataSave = UserDefaults.standard
        dataSave.setValue(Member.shared.user_id, forKey: "user_id")
        
        UserDefaults.standard.synchronize()
    }

}
