//
//  ExtensionVC.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/08/17.
//

import UIKit

class ExtensionVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension UIViewController {
    class func displaySpinner(onView: UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        
        spinnerView.backgroundColor = .white
        
        let ai = UIActivityIndicatorView.init(style: .medium)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        return spinnerView
    }
    
    class func removeSpinner(spinner: UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
}
