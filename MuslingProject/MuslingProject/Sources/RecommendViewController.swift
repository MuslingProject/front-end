//
//  RecommendViewController.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/06/13.
//

import UIKit

class RecommendViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var script: UILabel!
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet var recommendBtn: UIButton!
    
    var responseData: DiaryResponseModel?
    var recommendData: [RecMusicModel] = []
    var category: [String] = []
    
    // 감정 노래
    var emotionMusic: [RecMusicModel] = []
    // 날씨 노래
    var weatherMusic: [RecMusicModel] = []
    
    func classifyMusic() {
        for music in recommendData {
            if let emotion = music.emotion {
                emotionMusic.append(music)
            } else if let weather = music.weather {
                weatherMusic.append(music)
            }
        }
        
        switch responseData?.data.mood {
        case "사랑/기쁨":
            category.append("🥰 사랑/기쁨")
        case "이별/슬픔":
            category.append("😢 이별/슬픔")
        case "멘붕/불안":
            category.append("😨 멘붕/불안")
        case "스트레스/짜증":
            category.append("😡 스트레스/짜증")
        case "우울":
            category.append("😞 우울")
        default:
            break
        }
        
        switch responseData?.data.weather {
        case "화창한 날":
            category.append("☀️ 맑음")
        case "비/흐림":
            category.append("🌧️ 비/흐림")
        case "눈오는 날":
            category.append("🌨️ 눈")
        default:
            break
        }
    }
    
    
    // 재추천 버튼
    @IBAction func reRecommnd(_ sender: Any) {
        // 재추천 api 실행
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return category[section]
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.backGray // 원하는 배경색으로 설정하십시오.
        
        let headerLabel = UILabel()
        
        headerLabel.attributedText = NSMutableAttributedString(string: category[section], attributes: [NSAttributedString.Key.kern: -0.6, NSAttributedString.Key.font: UIFont(name: "Pretendard-SemiBold", size: 13)!, NSAttributedString.Key.foregroundColor: UIColor.text02!])
        
        headerView.addSubview(headerLabel)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20), // 왼쪽 여백 설정
            headerLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16), // 오른쪽 여백 설정
            headerLabel.topAnchor.constraint(equalTo: headerView.topAnchor),
            headerLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor)
        ])
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30 // 원하는 높이로 설정하십시오.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return emotionMusic.count
        } else if section == 1 {
            return weatherMusic.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recommend", for: indexPath) as! RecommendCell
        
        if indexPath.section == 0 {
            let target = emotionMusic[indexPath.row]
            cell.title.text = target.songTitle
            cell.singer.text = target.singer
            
            // 앨범 커버
            if let imageUrl = URL(string: target.coverImagePath) {
                cell.img.loadImage(from: imageUrl)
            }
        } else if indexPath.section == 1 {
            let target = weatherMusic[indexPath.row]
            cell.title.text = target.songTitle
            cell.singer.text = target.singer
            // 앨범 커버
            if let imageUrl = URL(string: target.coverImagePath) {
                cell.img.loadImage(from: imageUrl)
            }
        } else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        classifyMusic()
        
        guard let result = responseData?.data.mood else { return }
        
        titleLabel.attributedText = NSAttributedString(string: "분석 결과,\n\(result)의 감정이 느껴져요 🧐", attributes: [NSAttributedString.Key.font: UIFont(name: "Pretendard-ExtraBold", size: 24)!, NSAttributedString.Key.kern: -2.16])
        script.attributedText = NSAttributedString(string: "현재 감정과 날씨에 어울리는 노래들을 골라봤어요", attributes: [NSAttributedString.Key.font: UIFont(name: "Pretendard-Regular", size: 14)!, NSAttributedString.Key.kern: -1.08])

        let attributedString = NSMutableAttributedString(string: "🤔 다시 추천해 주세요")

        attributedString.addAttribute(NSAttributedString.Key.kern, value: -0.84, range: NSRange(location: 0, length: attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "Pretendard-Regular", size: 12)!, range: NSRange(location: 0, length: attributedString.length))

        recommendBtn.setAttributedTitle(attributedString, for: .normal)
        recommendBtn.setAttributedTitle(attributedString, for: .selected)
        
        myTableView.dataSource = self
        myTableView.delegate = self
        
        // 커스텀 폰트
        let customFont = UIFont(name: "Pretendard-SemiBold", size: 16)
        
        // NSAttributedString을 사용하여 폰트 속성 설정
        let attributes: [NSAttributedString.Key: Any] = [
            .font: customFont as Any,
            .foregroundColor: UIColor.blue01! // 원하는 텍스트 색상으로 설정
        ]
        
        // UIBarButtonItem 생성 및 타이틀 설정
        let barButtonItem = UIBarButtonItem(title: nil, style: .plain, target: self, action: #selector(closeBtn(_:)))
        barButtonItem.title = "닫기" // 타이틀 설정
        barButtonItem.setTitleTextAttributes(attributes, for: .normal) // NSAttributedString 설정
        
        navigationItem.rightBarButtonItem = barButtonItem
        
        // 뒤로가기 버튼 숨기기
        navigationItem.hidesBackButton = true
    }
    
    @objc func closeBtn(_ sender: Any) {
        // 홈으로 이동
        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC")
        vcName?.modalPresentationStyle = .fullScreen
        vcName?.modalTransitionStyle = .crossDissolve
        self.present(vcName!, animated: true, completion: nil)
    }
}

// custom Cell
class RecommendCell: UITableViewCell {
    @IBOutlet var img: UIImageView!
    @IBOutlet var title: UILabel!
    @IBOutlet var singer: UILabel!
    @IBOutlet var heart: UIImageView!
    
    @objc func saveMusic(tapGestureRecognizer: UITapGestureRecognizer) {
        if heart.image == UIImage(systemName: "heart") {
            // 찜하기
            heart.image = UIImage(systemName: "heart.fill")
        } else {
            // 찜 취소
            heart.image = UIImage(systemName: "heart")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        img.layer.cornerRadius = 5
        img.layer.masksToBounds = true
        
        let tapImageViewRecognizer = UITapGestureRecognizer(target: self, action: #selector(saveMusic(tapGestureRecognizer:)))
        heart.isUserInteractionEnabled = true
        heart.addGestureRecognizer(tapImageViewRecognizer)
        
        title.attributedText = NSAttributedString(string: title.text!, attributes: [NSAttributedString.Key.font: UIFont(name: "Pretendard-SemiBold", size: 14)!, NSAttributedString.Key.kern: -0.6])
        singer.attributedText = NSAttributedString(string: singer.text!, attributes: [NSAttributedString.Key.font: UIFont(name: "Pretendard-Regular", size: 12)!, NSAttributedString.Key.kern: -0.8])
        
        
    }
    
}
