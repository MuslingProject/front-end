//
//  ResultViewController.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/05/16.
//

import UIKit

class ResultViewController: UIViewController {

    @IBAction func closeBtn(_ sender: Any) {
        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC")
        vcName?.modalPresentationStyle = .fullScreen
        vcName?.modalTransitionStyle = .crossDissolve
        self.present(vcName!, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
