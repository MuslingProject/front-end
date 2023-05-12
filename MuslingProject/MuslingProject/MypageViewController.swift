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
        
        // navigation bar 배경색, 타이틀 색, button item 색상 변경
        self.navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = UIColor.primary
        self.navigationController?.navigationBar.scrollEdgeAppearance?.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.scrollEdgeAppearance?.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.tintColor = .white
        
        // navigation bar 그림자 효과
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.primary?.cgColor
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.8
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.navigationController?.navigationBar.layer.shadowRadius = 2
        

        // 이미지 원형으로 표시
        userProfile.layer.cornerRadius = userProfile.frame.height/2
        userProfile.layer.borderWidth = 1
        userProfile.clipsToBounds = true
        userProfile.layer.borderColor = UIColor.clear.cgColor
    }
}
