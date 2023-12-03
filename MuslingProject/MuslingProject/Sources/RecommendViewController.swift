//
//  RecommendViewController.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/06/13.
//

import UIKit

class RecommendViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, RecommendCellDelegate {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var script: UILabel!
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet var recommendBtn: UIButton!
    
    var responseData: DiaryResponseModel?
    var recommendData: [RecMusicModel] = []
    var category: [String] = []
    var saveMusics: [SendMusicModel] = []
    
    // 감정 노래
    var emotionMusic: [RecMusicModel] = []
    // 날씨 노래
    var weatherMusic: [RecMusicModel] = []
    
    func classifyMusic() {
        for music in recommendData {
            if music.emotion != nil {
                emotionMusic.append(music)
            } else if music.weather != nil {
                weatherMusic.append(music)
            }
        }
        
        switch responseData?.data.mood {
        case "사랑/기쁨":
            category.append("기쁠 때는 이런 노래 어때요? 🥰")
        case "이별/슬픔":
            category.append("슬플 때는 이런 노래들이 위로해 줄 거예요 🥺")
        case "멘붕/불안":
            category.append("어질어질 머릿속이 복잡할 때 😰")
        case "스트레스/짜증":
            category.append("스트레스 팍팍 날려버려요 👊")
        case "우울":
            category.append("마음이 좋지 않을 때에는 😞")
        default:
            break
        }
        
        switch responseData?.data.weather {
        case "화창한 날":
            category.append("맑은 날씨와 함께 듣는 노래 ☀️")
        case "비/흐림":
            category.append("우중충한 날씨와 함께 듣는 노래 ☁️")
        case "눈오는 날":
            category.append("창밖의 눈을 감상하며 듣는 노래 ⛄️")
        default:
            break
        }
    }
    
    
    // 재추천 버튼
    @IBAction func reRecommnd(_ sender: Any) {
        // 재추천 api 실행
        guard let diaryId = responseData?.data.diaryId else { return }
        print(diaryId)
        
        MusicService.shared.reRecommend(diaryId: diaryId) { response in
            switch response {
            case .success(let data):
                if let data = data as? ReRecommendModel {
                    print("재추천 결과 :: \(data.result)")
                    self.recommendData = data.data
                    self.emotionMusic.removeAll()
                    self.weatherMusic.removeAll()
                    
                    for music in self.recommendData {
                        if music.emotion != nil {
                            self.emotionMusic.append(music)
                        } else if music.weather != nil {
                            self.weatherMusic.append(music)
                        }
                    }
                    
                    self.myTableView.reloadData()
                }
            case .pathErr:
                print("재추천 결과 :: Path Err")
            case .networkFail:
                print("재추천 결과 :: Network Err")
            case .requestErr:
                print("재추천 결과 :: Request Err")
            case .serverErr:
                print("재추천 결과 :: Server Err")
            }
        }
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
        
        headerLabel.attributedText = NSMutableAttributedString(string: category[section], attributes: [NSAttributedString.Key.kern: -0.7, NSAttributedString.Key.font: UIFont(name: "Pretendard-Medium", size: 14)!, NSAttributedString.Key.foregroundColor: UIColor.text02!])
        
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
        cell.delegate = self
        
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
    
    func didTapHeartButton(in cell: RecommendCell) {
        guard let indexPath = myTableView.indexPath(for: cell) else { return }
        
        let selectedMusic: RecMusicModel = indexPath.section == 0 ? emotionMusic[indexPath.row] : weatherMusic[indexPath.row]
        
        let newMusic = SendMusicModel(titles: selectedMusic.songTitle, imgs: selectedMusic.coverImagePath, singers: selectedMusic.singer, emotion: selectedMusic.emotion, weather: selectedMusic.weather)
        
        if cell.isHeartSelected {
            saveMusics.append(newMusic)
        } else {
            if let index = saveMusics.firstIndex(where: { $0.titles == newMusic.titles && $0.singers == newMusic.singers }) {
                saveMusics.remove(at: index)
            }
        }
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
        // 음악 찜 api 실행
        MusicService.shared.saveMusics(musics: saveMusics) { response in
            switch response {
            case .success(let data):
                if let data = data as? SaveMusicResponseModel {
                    print("음악 찜 결과 :: \(data.result)")
                }
            case .pathErr:
                print("음악 찜 결과 :: Path Err")
            case .networkFail:
                print("음악 찜 결과 :: Network Err")
            case .requestErr:
                print("음악 찜 결과 :: Request Err")
            case .serverErr:
                print("음악 찜 결과 :: Server Err")
            }
        }
        
        // 홈으로 이동
        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC")
        vcName?.modalPresentationStyle = .fullScreen
        vcName?.modalTransitionStyle = .crossDissolve
        self.present(vcName!, animated: true, completion: nil)
    }
}

protocol RecommendCellDelegate: AnyObject {
    func didTapHeartButton(in cell: RecommendCell)
}

// custom Cell
class RecommendCell: UITableViewCell {
    weak var delegate: RecommendCellDelegate?
    
    @IBOutlet var img: UIImageView!
    @IBOutlet var title: UILabel!
    @IBOutlet var singer: UILabel!
    @IBOutlet var heart: UIImageView!
    var isHeartSelected: Bool = false
    
    @objc func saveMusic(tapGestureRecognizer: UITapGestureRecognizer) {
        isHeartSelected.toggle()
        heart.image = isHeartSelected ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        delegate?.didTapHeartButton(in: self)
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
