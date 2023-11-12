////
////  AllEmotionViewController.swift
////  MuslingProject
////
////  Created by 이나경 on 10/18/23.
////
//
//import UIKit
//
//class AllEmotionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        <#code#>
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//    
//    
////    var data: [EmotionMusic] = []
////    
////    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
////        return data.count
////    }
////    
////    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////        let cell = tableView.dequeueReusableCell(withIdentifier: "allRecommend", for: indexPath) as! RecommendCell
////        cell.singer.text = data[indexPath.row].singer
////        cell.title.text = data[indexPath.row].title
////        cell.heartIcon.image = UIImage(systemName: "heart")
////
////        if let imageUrl = URL(string: data[indexPath.row].img) {
////            cell.img.loadImage(from: imageUrl)
////        }
////        
////        cell.selectionStyle = .none
////        
////        return cell
////    }
////    
////    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
////        return 0
////    }
////    
////    
////    @IBOutlet var titleLabel: UILabel!
////    @IBOutlet var tableView: UITableView!
////    
////    override func viewDidLoad() {
////        super.viewDidLoad()
////        
////        data = EmotionMusic.allData
////        
////        tableView.dataSource = self
////        tableView.delegate = self
////        
////        titleLabel.attributedText = NSAttributedString(string: "감정 분석 결과\n오늘은 사랑/기쁨의 감정을 느끼셨네요 🥰", attributes: [NSAttributedString.Key.kern: -0.8])
////        
////    }
//
//}
