//
//  LoginViewController.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/04/11.
//

import UIKit
import GoogleSignIn

class FirstViewController: UIViewController {
    
    // 구글 계정으로 로그인 선택했을 때
    @IBAction func ggLogin(_ sender: UIButton) {
        // 구글 로그인
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            guard error == nil else { return }
            
            guard let signInResult = signInResult else { return }

            let user = signInResult.user
            let email = user.profile?.email
            
            let dataSave = UserDefaults.standard
            dataSave.setValue(email, forKey: "user_id")
            
            // 프로필 완성 화면으로 전환
            guard let vcName = self.storyboard?.instantiateViewController(withIdentifier: "ProfileVC") else { return }
            self.navigationController?.pushViewController(vcName, animated: true)
        }
    }
    
    
    // 회원가입
    @IBAction func signUp(_ sender: Any) {
        //회원 가입 화면으로 전환
        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "SignUp")
        vcName?.modalPresentationStyle = .fullScreen
        vcName?.modalTransitionStyle = .crossDissolve
        self.present(vcName!, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .secondary
        
        // 자동 로그인
        if UserDefaults.standard.string(forKey: "user_id") != nil {
            let vcName = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC")
            vcName?.modalPresentationStyle = .fullScreen
            vcName?.modalTransitionStyle = .crossDissolve
            self.present(vcName!, animated: true, completion: nil)
        }

    }

}
