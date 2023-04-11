//
//  LoginViewController.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/04/11.
//

import UIKit

class LoginViewController: UIViewController {
    
    // 카카오 로그인 선택했을 때
    @IBAction func kakaoLogin(_ sender: UIButton) {
    }
    
    // 일반 로그인 선택했을 때
    @IBAction func defaultLogin(_ sender: UIButton) {
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
