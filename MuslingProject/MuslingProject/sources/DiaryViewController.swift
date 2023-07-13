//
//  DiaryViewController.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/07/13.
//

import UIKit

class DiaryViewController: UIViewController {
    
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var dateLabel: UILabel!
    
    var diaryTitle: String!
    var diaryDate: String!
    var diaryContent: String!
    var emotion: String!
    var weather: String!
    
    // 더미데이터 불러오기
    let diaries = Diary.data

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navItem.title = diaryTitle
        dateLabel.text = diaryDate
    }

}
