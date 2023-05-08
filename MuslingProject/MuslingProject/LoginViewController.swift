//
//  LoginViewController.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/04/11.
//

import UIKit
import GoogleSignIn

class LoginViewController: UIViewController {
    
    // 구글 계정으로 로그인 선택했을 때
    @IBAction func ggLogin(_ sender: UIButton) {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            guard error == nil else { return }
            guard let signInResult = signInResult else { return }
            
            let user = signInResult.user
            let email = user.profile?.email
            let name = user.profile?.name
            
            // 프로필 완성 화면으로 이동
            let vcName = self.storyboard?.instantiateViewController(withIdentifier: "ProfileVC")
            vcName?.modalPresentationStyle = .fullScreen
            vcName?.modalTransitionStyle = .crossDissolve
            self.present(vcName!, animated: true, completion: nil)
        }
    }
    
    // 일반 로그인 선택했을 때
    @IBAction func defaultLogin(_ sender: UIButton) {
        // 회원 가입 화면으로 전환
        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "SignUp")
        vcName?.modalPresentationStyle = .fullScreen
        vcName?.modalTransitionStyle = .crossDissolve
        self.present(vcName!, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
