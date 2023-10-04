//
//  LoginViewController.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/04/11.
//

import UIKit
import GoogleSignIn

class FirstViewController: UIViewController {
    
    weak var sv: UIView!
    
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
        
        // Navigation Bar Title 폰트 설정
        let navigationBarAppearance = UINavigationBarAppearance()
        
        if let customFont = UIFont(name: "Pretendard-Bold", size: 26) {
            navigationBarAppearance.largeTitleTextAttributes = [
                .font: customFont,
                .foregroundColor: UIColor.secondary!
            ]
        } else {
            print("폰트를 로드할 수 없습니다.")
        }

        // 현재 UIViewController의 Navigation Controller 가져오기
        if let navigationController = self.navigationController {
            // 현재 UIViewController의 Navigation Bar Appearance 설정
            //navigationController.navigationBar.tintColor = .secondary
            navigationController.navigationBar.standardAppearance = navigationBarAppearance
            navigationController.navigationBar.scrollEdgeAppearance = nil
        }
        
        // 구글 자동 로그인
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if user != nil && error == nil {
                self.sv = UIViewController.displaySpinner(onView: self.view)
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
                            
                            self.sv.removeFromSuperview()
                        }
                    case .requestErr:
                        print("로그인 결과 :: Request Err")
                        self.sv.removeFromSuperview()
                    case .pathErr:
                        print("로그인 결과 :: decode 실패")
                        self.sv.removeFromSuperview()
                    case .serverErr:
                        print("로그인 결과 :: Server Err")
                        self.sv.removeFromSuperview()
                    case .networkFail:
                        print("로그인 결과 :: Network Err")
                        self.sv.removeFromSuperview()
                    }
                }
            }
        }
        
        // 자동 로그인
        let saveId = UserDefaults.standard.string(forKey: "user_id")
        if saveId?.isEmpty == false {
            self.sv = UIViewController.displaySpinner(onView: self.view)
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
                        
                        self.sv.removeFromSuperview()
                    }
                case .requestErr:
                    print("로그인 결과 :: Request Err")
                    let alert = UIAlertController(title: "오류 발생", message: "잠시 후 다시 시도해 주세요", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "확인", style: .cancel) { _ in
                        self.sv.removeFromSuperview()
                    }
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                case .pathErr:
                    print("로그인 결과 :: decode 실패")
                    let alert = UIAlertController(title: "오류 발생", message: "잠시 후 다시 시도해 주세요", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "확인", style: .cancel) { _ in
                        self.sv.removeFromSuperview()
                    }
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                case .serverErr:
                    print("로그인 결과 :: Server Err")
                    let alert = UIAlertController(title: "서버 오류", message: "잠시 후 다시 시도해 주세요", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "확인", style: .cancel) { _ in
                        self.sv.removeFromSuperview()
                    }
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                case .networkFail:
                    print("로그인 결과 :: Network Err")
                    let alert = UIAlertController(title: "네트워크 오류", message: "네트워크가 원활한 환경에서\n다시 시도해 주세요", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "확인", style: .cancel) { _ in
                        self.sv.removeFromSuperview()
                    }
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }

}