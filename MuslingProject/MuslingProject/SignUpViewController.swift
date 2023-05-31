//
//  SignUpViewController.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/04/11.
//

import UIKit
import Alamofire

class SignUpViewController: UIViewController {
    
    
    @IBOutlet var idField: HSUnderLineTextField!
    @IBOutlet var passField: HSUnderLineTextField!
    @IBOutlet var repassField: HSUnderLineTextField!
    
    @IBOutlet var nextBtn: UIButton! {
        didSet {
            self.nextBtn.isEnabled = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.idField.addAction(UIAction(handler: { _ in
            if self.idField.text?.isEmpty == true {
                self.nextBtn.isEnabled = false
            } else {
                self.nextBtn.isEnabled = true
            }
        }), for: .editingChanged)
        
        self.passField.addAction(UIAction(handler: { _ in
            if self.passField.text?.isEmpty == true {
                self.nextBtn.isEnabled = false
            } else {
                self.nextBtn.isEnabled = true
            }
        }), for: .editingChanged)
        
        self.repassField.addAction(UIAction(handler: { _ in
            if self.repassField.text?.isEmpty == true {
                self.nextBtn.isEnabled = false
            } else {
                self.nextBtn.isEnabled = true
            }
        }), for: .editingChanged)
    }

}
