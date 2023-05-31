//
//  LoginViewController.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/04/11.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

class FirstViewController: UIViewController {
    
    // 구글 계정으로 로그인 선택했을 때
    @IBAction func ggLogin(_ sender: UIButton) {
        // 구글 인증
        guard let cliendID = FirebaseApp.app()?.options.clientID else { return }
        _ = GIDConfiguration(clientID: cliendID)

        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            guard error == nil else { return }
            
            guard let signInResult = signInResult else { return }

            let user = signInResult.user
            let email = user.profile?.email
            //let name = user.profile?.name
            
            let dataSave = UserDefaults.standard
            dataSave.setValue(email, forKey: "user_id")

            // 프로필 완성 화면으로 이동
            let vcName = self.storyboard?.instantiateViewController(withIdentifier: "ProfileVC")
            vcName?.modalPresentationStyle = .fullScreen
            vcName?.modalTransitionStyle = .crossDissolve
            self.present(vcName!, animated: true, completion: nil)
        }
    }
    
    // 일반 로그인 선택했을 때
    @IBAction func defaultLogin(_ sender: UIButton) {
//        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC")
//        vcName?.modalPresentationStyle = .fullScreen
//        vcName?.modalTransitionStyle = .crossDissolve
//        self.present(vcName!, animated: true, completion: nil)
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
        if let userId = UserDefaults.standard.string(forKey: "user_id") {
            let vcName = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC")
            vcName?.modalPresentationStyle = .fullScreen
            vcName?.modalTransitionStyle = .crossDissolve
            self.present(vcName!, animated: true, completion: nil)
        }

    }

}
