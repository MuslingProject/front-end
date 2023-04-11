//
//  SignUpViewController.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/04/11.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet var idField: UITextField!
    @IBOutlet var passField: UITextField!
    
    @IBAction func signUp(_ sender: UIButton) {
        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "ProfileVC")
        vcName?.modalPresentationStyle = .fullScreen
        vcName?.modalTransitionStyle = .crossDissolve
        self.present(vcName!, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        idField.layer.cornerRadius = 20
        idField.backgroundColor = UIColor.white
        idField.layer.shadowOpacity = 0.2
        idField.layer.shadowRadius = 3
        idField.layer.shadowOffset = CGSize(width: 0, height: 0)
        idField.layer.shadowColor = UIColor.darkGray.cgColor
        idField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 13, height: 0))
        idField.leftViewMode = .always
        
        passField.layer.cornerRadius = 20
        passField.backgroundColor = UIColor.white
        passField.layer.shadowOpacity = 0.2
        passField.layer.shadowRadius = 3
        passField.layer.shadowOffset = CGSize(width: 0, height: 0)
        passField.layer.shadowColor = UIColor.darkGray.cgColor
        passField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 13, height: 0))
        passField.leftViewMode = .always
    }

}
