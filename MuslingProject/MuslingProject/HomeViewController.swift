//
//  HomeViewController.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/04/17.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet var dateLabel: UILabel! // 날짜
    @IBOutlet var noneLabel: UILabel! // 작성되어 있지 않을 때 띄울 문구
    @IBOutlet var homeTitle: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormat()
        noDiary()
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
    
    func dateFormat() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd (E)"
        let current_date_string = formatter.string(from: Date())
        dateLabel.text = "TODAY \(current_date_string)"
        dateLabel.font = UIFont.boldSystemFont(ofSize: 13)
        dateLabel.textColor = UIColor.darkGray
    }
    
    func noDiary() {
        noneLabel.text = "아직 오늘이 기록이 없어요\n일기를 작성해 주세요!"
    }

}
