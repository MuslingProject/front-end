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
    
    @IBOutlet var musicCollectionView: UICollectionView!
    
    var diaryDate: String!
    var diaryTitle: String!
    var content: String!
    var emotion: String!
    var weather: String!
    var musics: [RecMusicModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = false
        
        // 일기 위의 문구
        let date = StringToDate(strDate: diaryDate, format: "yyyy-MM-dd")
        let stringDate = DateToString(date: date!, format: "✏️ yyyy년 MM월 dd일의 기록")
        
        dateLabel.attributedText = NSAttributedString(string: stringDate, attributes: [NSAttributedString.Key.kern: -1.7, NSAttributedString.Key.font: UIFont(name: "Pretendard-ExtraBold", size: 20)!])
        titleLabel.attributedText = NSAttributedString(string: diaryTitle, attributes: [NSAttributedString.Key.font: UIFont(name: "Pretendard-SemiBold", size: 16)!, NSAttributedString.Key.kern: -1])
        emotionLabel.attributedText = NSAttributedString(string: emotion, attributes: [NSAttributedString.Key.font: UIFont(name: "Pretendard-Regular", size: 12)!, NSAttributedString.Key.kern: -0.8])
        weatherLabel.attributedText = NSAttributedString(string: weather, attributes: [NSAttributedString.Key.font: UIFont(name: "Pretendard-Regular", size: 12)!, NSAttributedString.Key.kern: -0.8])
        contentLabel.attributedText = NSAttributedString(string: content, attributes: [NSAttributedString.Key.font: UIFont(name: "Pretendard-Regular", size: 14)!, NSAttributedString.Key.kern: -0.98])
        musicLabel.attributedText = NSAttributedString(string: "👀 이런 노래들을 추천받았어요", attributes: [NSAttributedString.Key.font: UIFont(name: "Pretendard-Bold", size: 14)!, NSAttributedString.Key.kern: -0.98])
        
        
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
        let target = musics[indexPath.row]
        let cell = musicCollectionView.dequeueReusableCell(withReuseIdentifier: MusicCell.cellId, for: indexPath) as! MusicCell
        
        cell.title.attributedText = NSAttributedString(string: target.songTitle, attributes: [NSAttributedString.Key.font: UIFont(name: "Pretendard-SemiBold", size: 13)!, NSAttributedString.Key.kern: -0.7])
        cell.singer.attributedText = NSAttributedString(string: target.singer, attributes: [NSAttributedString.Key.font: UIFont(name: "Pretendard-Regular", size: 11)!, NSAttributedString.Key.kern: -0.7])
        
        // 앨범 커버
        if let imageUrl = URL(string: target.coverImagePath) {
            cell.img.loadImage(from: imageUrl)
        }

        return cell
    }
    
    // UICollectionViewDelegateFlowLayout 상속
    //컬렉션뷰 사이즈 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 258, height: 88)
    }
}
