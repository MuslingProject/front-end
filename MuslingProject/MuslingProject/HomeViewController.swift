//
//  HomeViewController.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/04/17.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var noneLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        header()
        dateFormat()
        noDiary()
    }

    func header() {
        let newView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 140))
        newView.backgroundColor = UIColor(red: 123/255.0, green: 144/255.0, blue: 177/255.0, alpha: 1.0)
        newView.layer.cornerRadius = 50
        newView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        self.view.addSubview(newView)
        
        let title = UILabel(frame: CGRect(x: 28, y: 70, width: 300, height: 30))
        title.text = "오늘의 기록 ✍️"
        title.font = UIFont.systemFont(ofSize: 30, weight: .black)
        title.textColor = UIColor.white
        self.view.addSubview(title)
    }
    
    func dateFormat() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let current_date_string = formatter.string(from: Date())
        dateLabel.text = "TODAY " + current_date_string
        dateLabel.font = UIFont.boldSystemFont(ofSize: 13)
        dateLabel.textColor = UIColor.darkGray
    }
    
    func noDiary() {
        noneLabel.text = "아직 오늘이 기록이 없어요\n일기를 작성해 주세요!"
    }

}
