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
    @IBOutlet weak var diaryContent: UILabel!
    @IBOutlet weak var emotionLabel: UIButton!
    @IBOutlet weak var weatherLabel: UIButton!
    
    @IBOutlet var musicCollectionView: UICollectionView!
    
    var diaryTitle: String!
    var diaryDate: String!
    var content: String!
    var emotion: String!
    var weather: String!
    
    // 더미데이터 불러오기
    let diaries = Diary.data
    let musics = RecMusic.data

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // navigation bar title 설정
        navItem.title = diaryTitle
        
        // 일기 위의 문구
        let date = StringToDate(strDate: diaryDate, format: "yyyy-MM-dd")
        let stringDate = DateToString(date: date!, format: "📖 yyyy년 MM월 dd일의 기록")
        
        dateLabel.text = stringDate
        
        // 일기 내용 행간 설정
        let attrString = NSMutableAttributedString(string: content)
        let paragraphStyle = NSMutableParagraphStyle()
        let letterSpacing: CGFloat = -0.3
        let lineSpacing: CGFloat = 4
        
        // paragraphyStyle에 자간과 행간 설정
        paragraphStyle.lineSpacing = lineSpacing
        attrString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attrString.length))
        
        // 자간 설정
        attrString.addAttribute(.kern, value: letterSpacing, range: NSRange(location: 0, length: attrString.length))
        
        // label에 NSAttributedString 설정
        diaryContent.attributedText = attrString
        
        diaryContent.backgroundColor = UIColor.white
        
        diaryContent.layer.cornerRadius = 15
        diaryContent.layer.borderColor = UIColor.darkGray.cgColor
        
        diaryContent.layer.shadowOpacity = 0.2
        diaryContent.layer.shadowRadius = 2
        diaryContent.layer.shadowOffset = CGSize(width: 0, height: 0)
        diaryContent.layer.shadowColor = UIColor.darkGray.cgColor
        
        
        emotionLabel.setTitle(emotion, for: .normal)
        weatherLabel.setTitle(weather, for: .normal)
        
        musicCollectionView.dataSource = self
        musicCollectionView.delegate = self
        musicCollectionView.register(UINib(nibName: MusicCell.className, bundle: nil), forCellWithReuseIdentifier: MusicCell.cellId)
    }
    
    func StringToDate(strDate: String, format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        
        if let date = dateFormatter.date(from: strDate) {
            return date
        } else { return nil }
    }
    
    func DateToString(date: Date, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        
        return dateFormatter.string(from: date)
    }

}

extension DiaryViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    // 컬렉션 뷰 개수 설정
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return musics.count
    }
    
    // 컬렉션 뷰 셀 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = musicCollectionView.dequeueReusableCell(withReuseIdentifier: MusicCell.cellId, for: indexPath) as! MusicCell
        cell.img.image = UIImage(named: musics[indexPath.row].img)
        cell.title.text = musics[indexPath.row].title
        cell.singer.text = musics[indexPath.row].singer
        
        return cell
    }
    
    // UICollectionViewDelegateFlowLayout 상속
    //컬렉션뷰 사이즈 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 258, height: 88)
    }
}
