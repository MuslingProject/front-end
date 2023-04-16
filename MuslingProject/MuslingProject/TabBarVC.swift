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

        // 선택했을 때 색상
        self.tabBar.tintColor = UIColor(red: 123/255.0, green: 144/255.0, blue: 177/255.0, alpha: 1.0)
        
        // 그림자 효과 주기
        self.tabBar.layer.shadowColor = UIColor.darkGray.cgColor
        self.tabBar.backgroundColor = UIColor.white
        self.tabBar.layer.shadowOpacity = 0.2
        self.tabBar.layer.shadowRadius = 2
        self.tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
    }

}
