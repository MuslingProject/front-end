//
//  LoginCheck.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/05/31.
//

import UIKit
import Firebase

protocol LoginCheck {
    func isLogin() -> Bool
}

extension LoginCheck {
    func isLogin() -> Bool {
        print(Auth.auth().currentUser?.uid != nil ? "로그인 되어 있음" : "로그인 되어 있지 않음")
        return Auth.auth().currentUser?.uid != nil ? true : false
    }
}
