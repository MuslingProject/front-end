//
//  TabBarVC.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/04/17.
//

import UIKit

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let items = self.tabBar.items {
            for item in items {
                if let _ = item.title {
                    let attributes: [NSAttributedString.Key: Any] = [
                        .font: UIFont(name: "Pretendard-Medium", size: 12)!,
                        .kern: -0.6
                    ]
                    item.setTitleTextAttributes(attributes, for: .normal)
                    item.setTitleTextAttributes(attributes, for: .selected)
                }
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

}
