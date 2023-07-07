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
            signIn(user_id: id, pwd: pwd)
            
            // 자동 로그인을 위해 아이디 저장
            let dataSave = UserDefaults.standard
            dataSave.setValue(id, forKey: "user_id")
            
            UserDefaults.standard.synchronize()
            
        }
    }
    
    func signIn(user_id: String, pwd: String) {
        let params: Parameters = [
            "user_id": user_id,
            "pwd": pwd
        ]
        
        AF.request(APIConstants.userSignInURL,
                   method: .post,
                   parameters: params,
                   encoding: JSONEncoding.default,
                   headers: nil)
        .validate(statusCode: 200 ..< 299).responseData { response in
            switch response.result {
            case .success(let data):
                print("로그인 성공")
                print("반환: \(data)")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
