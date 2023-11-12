//
//  RecommendViewController.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/06/13.
//

import UIKit

class RecommendViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTableView: UITableView!
    
    @IBAction func closeBtn(_ sender: Any) {
        // 홈으로 이동
        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC")
        vcName?.modalPresentationStyle = .fullScreen
        vcName?.modalTransitionStyle = .crossDissolve
        self.present(vcName!, animated: true, completion: nil)
    }
    
    var recommendData: [RecMusicModel] = []
    var category: [String] = []
//    var emotion = EmotionMusic.data
//    var weather = WeatherMusic.data
    
    
    // 재추천 버튼
    @IBAction func reRecommnd(_ sender: Any) {
//        emotion = EmotionMusic.reData
//        weather = WeatherMusic.reData
        
        // 데이터 새로고침
        myTableView.reloadData()
    }
    
    let cellSpacingHeight: CGFloat = 50
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return category[section]
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let myLabel = UILabel()
        myLabel.frame = CGRect(x: 10, y: 16, width: 320, height: 35)
        myLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        let attributedText = NSAttributedString(string: myLabel.text ?? "", attributes: [
            NSAttributedString.Key.font: UIFont(name: "Pretendard-SemiBold", size: 15)!,
            NSAttributedString.Key.kern: -0.7
        ])
        myLabel.attributedText = attributedText
        myLabel.font = UIFont(name: "Pretendard-Medium", size: 16)
        myLabel.textColor = UIColor.darkGray
        
        let headerView = UIView()
        headerView.addSubview(myLabel)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if section == 0 {
//            return emotion.count
//        } else if section == 1 {
//            return weather.count
//        } else {
//            return 0
//        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recommend", for: indexPath) as! RecommendCell
        
//        if indexPath.section == 0 {
//            let target = emotion[indexPath.row]
//            cell.title.text = target.title
//            cell.singer.text = target.singer
//            cell.heartIcon.image = UIImage(systemName: "heart")
//            // 앨범 커버
//            if let imageUrl = URL(string: target.img) {
//                cell.img.loadImage(from: imageUrl)
//            }
//        } else if indexPath.section == 1 {
//            let target = weather[indexPath.row]
//            cell.title.text = target.title
//            cell.singer.text = target.singer
//            cell.heartIcon.image = UIImage(systemName: "heart")
//            // 앨범 커버
//            if let imageUrl = URL(string: target.img) {
//                cell.img.loadImage(from: imageUrl)
//            }
//        } else {
//            return UITableViewCell()
//        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.dataSource = self
        myTableView.delegate = self
        
        myTableView.isScrollEnabled = false
        
        category = ["현재 기쁨/사랑의 감정이시군요? 🥰", "날씨가 흐리거나 비올 땐 이런 노래 어때요? ☁️"]
        
        // 커스텀 폰트
        let customFont = UIFont(name: "Pretendard-SemiBold", size: 16)
        
        // NSAttributedString을 사용하여 폰트 속성 설정
        let attributes: [NSAttributedString.Key: Any] = [
            .font: customFont as Any,
            .foregroundColor: UIColor.white // 원하는 텍스트 색상으로 설정
        ]
        
        // UIBarButtonItem 생성 및 타이틀 설정
        let barButtonItem = UIBarButtonItem(title: nil, style: .plain, target: self, action: #selector(closeBtn(_:)))
        barButtonItem.title = "닫기" // 타이틀 설정
        barButtonItem.setTitleTextAttributes(attributes, for: .normal) // NSAttributedString 설정
        
        navigationItem.rightBarButtonItem = barButtonItem
        
        // 뒤로가기 버튼 숨기기
        navigationItem.hidesBackButton = true
    }
}

// custom Cell
class RecommendCell: UITableViewCell {
    @IBOutlet var img: UIImageView!
    @IBOutlet var title: UILabel!
    @IBOutlet var singer: UILabel!
    @IBOutlet var heartIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(clickHeartIcon))
        heartIcon.addGestureRecognizer(tapGesture)
        heartIcon.isUserInteractionEnabled = true
        
        img.layer.cornerRadius = 5
        img.layer.masksToBounds = true
    }
    
    // 이미지 뷰를 클릭하면 호출되는 함수
    @objc func clickHeartIcon() {
        if heartIcon.image == UIImage(systemName: "heart") {
            heartIcon.image = UIImage(systemName: "heart.fill")
        } else {
            heartIcon.image = UIImage(systemName: "heart")
        }
    }
}
