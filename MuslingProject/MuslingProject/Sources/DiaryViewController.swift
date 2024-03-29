//
//  DiaryViewController.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/07/13.
//

import UIKit

class DiaryViewController: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var emotionLabel: UILabel!
    @IBOutlet var weatherLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var musicLabel: UILabel!
    @IBOutlet var heart: UIImageView!
    
    @IBOutlet var deleteBtn: UIButton!
    
    weak var sv: UIView!
    
    @IBAction func deleteDiary(_ sender: Any) {
        // 일기 삭제하냐는 alert 띄우기
        let alert = UIAlertController(title: "해당 일기를 삭제하시겠습니까?", message: nil, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "삭제", style: .default) { _ in
            // 로딩 화면 띄우기
            self.sv = UIViewController.displaySpinner(onView: self.view)
            DiaryService.shared.deleteDiary(diaryId: self.diaryId) { response in
                switch response {
                case .success(let data):
                    if let data = data as? NonDataModel {
                        print("기록 삭제 결과 :: \(data.result)")
                        // 다시 리스트로 돌아가고 notification center에 등록
                        NotificationCenter.default.post(name: .diaryUpdated, object: nil)
                        // 로딩 화면 끄기
                        self.sv.removeFromSuperview()
                        self.navigationController?.popViewController(animated: false)
                    }
                case .pathErr:
                    print("개별 기록 조회 결과 :: Path Err")
                case .requestErr:
                    print("개별 기록 조회 결과 :: Request Err")
                case .serverErr:
                    print("개별 기록 조회 결과 :: Server Err")
                case .networkFail:
                    print("개별 기록 조회 결과 :: Network Fail")
                }
            }
        }
        
        let cancle = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(alertAction)
        alert.addAction(cancle)
        
        alertAction.setValue(UIColor.red, forKey: "titleTextColor")
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBOutlet var musicTableView: UITableView!

    var diaryId: Int64!
    var date: String!
    var stringDate: String!
    var musics: [RecMusicModel] = []
    var weather: String!
    var mood: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = false
        
        musicTableView.isScrollEnabled = false
        
        musicLabel.attributedText = NSAttributedString(string: "👀 이런 노래들을 추천받았어요", attributes: [NSAttributedString.Key.font: UIFont(name: "Pretendard-Bold", size: 14)!, NSAttributedString.Key.kern: -0.98])
        
        musicTableView.dataSource = self
        musicTableView.delegate = self
        musicTableView.backgroundColor = UIColor.clear // 배경 투명

        DiaryService.shared.getDiary(diaryId: diaryId) { response in
            switch response {
            case .success(let data):
                if let data = data as? ShowDiaryModel {
                    print("개별 기록 조회 결과 :: \(data.result)")
                    
                    DispatchQueue.main.async {
                        self.stringDate = self.DateToString(date: data.data.date, format: "✏️ yyyy년 MM월 dd일의 기록")
                        self.dateLabel.attributedText = NSAttributedString(string: self.stringDate, attributes: [NSAttributedString.Key.kern: -1.7, NSAttributedString.Key.font: UIFont(name: "Pretendard-ExtraBold", size: 20)!])
                        self.titleLabel.attributedText = NSAttributedString(string: data.data.title, attributes: [NSAttributedString.Key.font: UIFont(name: "Pretendard-SemiBold", size: 16)!, NSAttributedString.Key.kern: -1])
                        self.weather = self.transToString(origin: data.data.weather)
                        self.mood = self.transToString(origin: data.data.mood)
                        self.emotionLabel.attributedText = NSAttributedString(string: self.mood, attributes: [NSAttributedString.Key.font: UIFont(name: "Pretendard-Regular", size: 12)!, NSAttributedString.Key.kern: -0.8])
                        self.weatherLabel.attributedText = NSAttributedString(string: self.weather, attributes: [NSAttributedString.Key.font: UIFont(name: "Pretendard-Regular", size: 12)!, NSAttributedString.Key.kern: -0.8])
                        self.contentLabel.attributedText = NSAttributedString(string: data.data.content, attributes: [NSAttributedString.Key.font: UIFont(name: "Pretendard-Regular", size: 14)!, NSAttributedString.Key.kern: -0.98])
                        self.musics = data.data.recommendations
                        
                        if data.data.isFavorited {
                            self.heart.image = UIImage(systemName: "heart.fill")
                        } else {
                            self.heart.image = UIImage(systemName: "heart")
                        }
                        
                        self.musicTableView.reloadData()
                    }
                    
                }
            case .pathErr:
                print("개별 기록 조회 결과 :: Path Err")
            case .requestErr:
                print("개별 기록 조회 결과 :: Request Err")
            case .serverErr:
                print("개별 기록 조회 결과 :: Server Err")
            case .networkFail:
                print("개별 기록 조회 결과 :: Network Fail")
            }
        }
        
        let tapImageViewRecognizer = UITapGestureRecognizer(target: self, action: #selector(saveDiary(tapGestureRecognizer:)))
        heart.isUserInteractionEnabled = true
        heart.addGestureRecognizer(tapImageViewRecognizer)
    }
    
    @objc func saveDiary(tapGestureRecognizer: UITapGestureRecognizer) {
        let isHeartFilled = heart.image == UIImage(systemName: "heart.fill")
        heart.image = UIImage(systemName: isHeartFilled ? "heart" : "heart.fill")
        tapHeartButton(diaryId: diaryId)
    }
    
    func tapHeartButton(diaryId: Int64) {
        DiaryService.shared.favDiary(diaryId: diaryId) { response in
            switch response {
            case .success(let data):
                if let data = data as? NonDataModel {
                    print("일기 찜하기 결과 :: \(data.result)")
                    NotificationCenter.default.post(name: .diaryFavorited, object: nil)
                }
            case .pathErr:
                print("일기 찜하기 결과 :: Path Err")
            case .requestErr:
                print("일기 찜하기 결과 :: Request Err")
            case .serverErr:
                print("일기 찜하기 결과 :: Server Err")
            case .networkFail:
                print("일기 찜하기 결과 :: Network Fail")
            }
        }
    }
    
    func DateToString(date: Date, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        
        return dateFormatter.string(from: date)
    }
    
    func transToString(origin: String) -> String {
        switch origin {
        case "화창한 날":
            return "☀️ 맑았어요"
        case "눈오는 날":
            return  "🌨️ 눈이 내렸어요"
        case "비/흐림":
            return "🌧️ 비 또는 흐렸어요"
        case "사랑/기쁨":
            return "🥰 기뻤어요"
        case "이별/슬픔":
            return "😢 슬펐어요"
        case "우울":
            return "🫠 우울했어요"
        case "멘붕/불안":
            return "🤯 불안했어요"
        case "스트레스/짜증":
            return "😡 짜증났어요"
        default: return ""
        }
    }

}

extension DiaryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let target = musics[indexPath.row]
        let cell = musicTableView.dequeueReusableCell(withIdentifier: MusicCell.cellId, for: indexPath) as! MusicCell
        
        cell.title.attributedText = NSAttributedString(string: target.songTitle, attributes: [NSAttributedString.Key.font: UIFont(name: "Pretendard-SemiBold", size: 13)!, NSAttributedString.Key.kern: -0.7])
        cell.singer.attributedText = NSAttributedString(string: target.singer, attributes: [NSAttributedString.Key.font: UIFont(name: "Pretendard-Regular", size: 11)!, NSAttributedString.Key.kern: -0.7])
        
        // 앨범 커버
        if let imageUrl = URL(string: target.coverImagePath) {
            cell.img.loadImage(from: imageUrl)
        }
        
        cell.selectionStyle = .none
        cell.backgroundColor = .clear

        return cell
    }
}

class MusicCell: UITableViewCell {
    static let cellId = "music"
    static let className = "MusicCell"

    @IBOutlet var title: UILabel!
    @IBOutlet var singer: UILabel!
    @IBOutlet var img: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        roundImg()
    }
    
    private func roundImg() {
        img.layer.cornerRadius = 5
        img.layer.masksToBounds = true
    }
}
