//
//  MypageViewController.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/04/17.
//

import UIKit

class MypageViewController: UIViewController {

    @IBOutlet var userProfile: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 이미지 원형으로 표시
        userProfile.layer.cornerRadius = userProfile.frame.height/2
        userProfile.layer.borderWidth = 1
        userProfile.clipsToBounds = true
        userProfile.layer.borderColor = UIColor.clear.cgColor
    }
    
    // navigation bar 배경, 타이틀, item 색상 변경
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .primary
        appearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        navigationController?.navigationBar.tintColor = .white
        
        // navigation bar 그림자 효과
        navigationController?.navigationBar.layer.masksToBounds = false
        navigationController?.navigationBar.layer.shadowColor = UIColor.primary?.cgColor
        navigationController?.navigationBar.layer.shadowOpacity = 0.8
        navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2)
        navigationController?.navigationBar.layer.shadowRadius = 2
    }
}
