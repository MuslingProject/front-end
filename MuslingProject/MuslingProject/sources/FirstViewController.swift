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
            
            Member.shared.user_id = email
            Member.shared.pwd = ""
            
            // 프로필 완성 화면으로 전환
            guard let vcName = self.storyboard?.instantiateViewController(withIdentifier: "ProfileVC") else { return }
            self.navigationController?.pushViewController(vcName, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .secondary
        
        // 구글 자동 로그인
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if user != nil && error == nil {
                // 토큰 갱신해 주기
                guard let userId = UserDefaults.standard.string(forKey: "user_id") else { return }
                SignService.shared.ggSignIn(userId: userId) { response in
                    switch response {
                    case .success(let data):
                        if let data = data as? ResponseModel {
                            print("로그인 결과 :: \(data.message)")
                            let dataSave = UserDefaults.standard
                            // 새로 갱신된 token 저장
                            dataSave.setValue(data.data, forKey: "token")
                            dataSave.synchronize()
                            
                            // 홈 화면으로 넘어가기
                            let vcName = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC")
                            vcName?.modalPresentationStyle = .fullScreen
                            vcName?.modalTransitionStyle = .crossDissolve
                            self.present(vcName!, animated: true, completion: nil)
                        }
                    case .requestErr:
                        print("로그인 결과 :: Request Err")
                    case .pathErr:
                        print("로그인 결과 :: decode 실패")
                    case .serverErr:
                        print("로그인 결과 :: Server Err")
                    case .networkFail:
                        print("로그인 결과 :: Network Err")
                    }
                }
            }
        }
        
        // 자동 로그인
        let saveId = UserDefaults.standard.string(forKey: "user_id")
        if saveId?.isEmpty == false {
            // 토큰 갱신해 주기
            guard let userId = UserDefaults.standard.string(forKey: "user_id") else { return }
            guard let pwd = UserDefaults.standard.string(forKey: "pwd") else { return }

            SignService.shared.signIn(userId: userId, pwd: pwd) { response in
                switch response {
                case .success(let data):
                    if let data = data as? ResponseModel {
                        print("로그인 결과 :: \(data.message)")
                        let dataSave = UserDefaults.standard
                        // 새로 갱신된 token 저장
                        dataSave.setValue(data.data, forKey: "token")
                        dataSave.synchronize()
                        
                        // 홈 화면으로 넘어가기
                        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC")
                        vcName?.modalPresentationStyle = .fullScreen
                        vcName?.modalTransitionStyle = .crossDissolve
                        self.present(vcName!, animated: true, completion: nil)
                    }
                case .requestErr:
                    print("로그인 결과 :: Request Err")
                case .pathErr:
                    print("로그인 결과 :: decode 실패")
                case .serverErr:
                    print("로그인 결과 :: Server Err")
                case .networkFail:
                    print("로그인 결과 :: Network Err")
                }
            }
        }

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}
