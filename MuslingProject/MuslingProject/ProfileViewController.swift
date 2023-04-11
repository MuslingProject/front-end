//
//  ProfileViewController.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/04/12.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet var profileImg: UIImageView!
    @IBOutlet var nameField: UITextField!
    
    @IBAction func nextBtn(_ sender: UIButton) {
        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "SelectVC")
        vcName?.modalPresentationStyle = .fullScreen
        vcName?.modalTransitionStyle = .crossDissolve
        self.present(vcName!, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameField.layer.cornerRadius = 20
        nameField.backgroundColor = UIColor.white
        nameField.layer.shadowOpacity = 0.2
        nameField.layer.shadowRadius = 3
        nameField.layer.shadowOffset = CGSize(width: 0, height: 0)
        nameField.layer.shadowColor = UIColor.darkGray.cgColor
        nameField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 13, height: 0))
        nameField.leftViewMode = .always
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
