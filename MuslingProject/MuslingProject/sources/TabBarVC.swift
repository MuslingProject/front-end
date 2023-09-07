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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 선택했을 때 색상
        self.tabBar.tintColor = UIColor(red: 123/255.0, green: 144/255.0, blue: 177/255.0, alpha: 1.0)
        
        
        // 탭 바 스타일 초기화
        if #available(iOS 13.0, *) {
            let appearance = UITabBarAppearance()

            // 여기에서 원하는 탭 바 스타일 설정
            // 선택되지 않은 상태의 폰트 및 자간 설정
            let normalFont = UIFont(name: "Pretendard-Medium", size: 13)
            let normalSpacing: CGFloat = -0.6
            
            let normalAttributes: [NSAttributedString.Key: Any] = [
                .font: normalFont as Any,
                .kern: normalSpacing
            ]
            
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = normalAttributes
            
            // 선택된 상태의 폰트 및 자간 설정
            let selectedFont = UIFont(name: "Pretendard-Regular", size: 13)
            let selectedSpacing: CGFloat = -0.6

            let selectedAttributes: [NSAttributedString.Key: Any] = [
                .font: selectedFont as Any,
                .kern: selectedSpacing
            ]

            appearance.stackedLayoutAppearance.selected.titleTextAttributes = selectedAttributes
            
            appearance.backgroundColor = UIColor.white
            
            UITabBar.appearance().scrollEdgeAppearance = appearance
            UITabBar.appearance().standardAppearance = appearance
        }
    }

}
