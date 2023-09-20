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
        
        // 탭 바 스타일 설정
        if #available(iOS 13.0, *) {
            let appearance = UITabBarAppearance()
            
            //  폰트 및 자간 설정
            if let customFont = UIFont(name: "Pretendard-Medium", size: 14) {
                appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
                    .font: customFont,
                    .kern: -0.6
                ]
                appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
                    .font: customFont,
                    .kern: -0.6
                ]
            } else {
                print("폰트를 로드할 수 없습니다.")
            }
            
            self.tabBar.standardAppearance = appearance
            self.tabBar.scrollEdgeAppearance = appearance

        } else {
            tabBar.barTintColor = .white
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

}
