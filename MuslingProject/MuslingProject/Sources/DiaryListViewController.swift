//
//  DiaryListViewController.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/07/11.
//

import UIKit

class DiaryListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    // 더미데이터 불러오기
    let diaries = Diary.data
    var groupedDiaries: [String: [Diary]] = [:]
    var diaryDates: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.attributedText = NSAttributedString(string: "내 기록 모아보기 📔", attributes: [NSAttributedString.Key.font: UIFont(name: "Pretendard-ExtraBold", size: 26)!, NSAttributedString.Key.kern: -1.7])
        
        tableView.delegate = self
        tableView.dataSource = self
        
        groupDiariesByDate()
    }
    
    func groupDiariesByDate() {
        // 날짜별로 diary 객체 그룹화하기
        for diary in diaries {
            groupedDiaries[diary.date, default: []].append(diary)
        }
        
        // 섹션 헤더로 사용할 날짜 목록
        diaryDates = Array(groupedDiaries.keys).sorted().reversed()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return diaryDates.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.backGray // 원하는 배경색으로 설정하십시오.
        
        let headerLabel = UILabel()
        headerLabel.attributedText = NSMutableAttributedString(string: diaryDates[section], attributes: [NSAttributedString.Key.kern: -0.6, NSAttributedString.Key.font: UIFont(name: "Pretendard-Bold", size: 11)!, NSAttributedString.Key.foregroundColor: UIColor.text03!])
        
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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return diaryDates[section]
    }
    
    // 한 섹션 당 row 수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let date = diaryDates[section]
        return groupedDiaries[date]?.count ?? 0
    }
    
    
    // MARK: = Row Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "diary", for: indexPath) as! DiaryCell
        let date = diaryDates[indexPath.section]
        
        if let diary = groupedDiaries[date]?[indexPath.row] {
            cell.title.attributedText = NSAttributedString(string: diary.title, attributes: [NSAttributedString.Key.font: UIFont(name: "Pretendard-Regular", size: 13)!, NSAttributedString.Key.kern: -0.6])
            
            var emotionStr: String = ""
            
            switch diary.emotion {
            case "사랑/기쁨":
                emotionStr = "🥰 사랑/기쁨"
            case "이별/슬픔":
                emotionStr = "😢 이별/슬픔"
            case "우울":
                emotionStr = "🫠 우울"
            case "멘붕/불안":
                emotionStr = "🤯 멘붕/불안"
            case "스트레스/짜증":
                emotionStr = "😡 스트레스/짜증"
            default:
                emotionStr = ""
            }
            
            cell.emotion.attributedText = NSAttributedString(string: emotionStr, attributes: [NSAttributedString.Key.font: UIFont(name: "Pretendard-Medium", size: 11)!, NSAttributedString.Key.kern: -0.6])
        }
        cell.selectionStyle = .none
        
        return cell
    }
    
    // 데이터 전달
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "diarySegue" {
            if let destination = segue.destination as? DiaryViewController, let selectedIndex = self.tableView.indexPathForSelectedRow {
                let date = diaryDates[selectedIndex.section]
                if let diary = groupedDiaries[date]?[selectedIndex.row] {
                    destination.diaryTitle = diary.title
                    destination.diaryDate = diary.date
                    destination.content = diary.content
                    destination.weather = diary.weather
                    
                    switch diary.weather {
                    case "화창한 날":
                        destination.weather = "☀️ 맑았어요"
                    case "눈오는 날":
                        destination.weather = "🌨️ 눈이 내렸어요"
                    case "비/흐림":
                        destination.weather = "🌧️ 비 또는 흐렸어요"
                    default: destination.weather = ""
                    }
                    
                    switch diary.emotion {
                    case "사랑/기쁨":
                        destination.emotion = "🥰 기뻤어요"
                    case "이별/슬픔":
                        destination.emotion = "😢 슬펐어요"
                    case "우울":
                        destination.emotion = "🫠 우울했어요"
                    case "멘붕/불안":
                        destination.emotion = "🤯 불안했어요"
                    case "스트레스/짜증":
                        destination.emotion = "😡 짜증났어요"
                    default:
                        destination.emotion = ""
                    }
                }
            }
        }
        
    }
}

// custom Cell
class DiaryCell: UITableViewCell {
    @IBOutlet var title: UILabel!
    @IBOutlet var emotion: UILabel!
}
