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
    @IBOutlet var noDiaryLabel: UILabel!
    
    var diaries: [DiaryModel] = []
    var groupedDiaries: [String: [DiaryModel]] = [:]
    var diaryDates: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleDiaryUpdate), name: .diaryUpdated, object: nil)
        
        noDiaryLabel.isHidden = true
        
        titleLabel.attributedText = NSAttributedString(string: "내 기록 모아보기 📔", attributes: [NSAttributedString.Key.font: UIFont(name: "Pretendard-ExtraBold", size: 26)!, NSAttributedString.Key.kern: -1.7])
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        DiaryService.shared.getDiaries(page: 0, size: 50) { response in
            switch response {
            case .success(let data):
                if let data = data as? GetDiaryModel {
                    print("전체 기록 조회 결과 :: \(data.result)")
                    self.diaries = data.data.content
                    
                    if self.diaries.isEmpty {
                        self.tableView.isHidden = true
                        self.noDiaryLabel.isHidden = false
                        self.noDiaryLabel.attributedText = NSAttributedString(string: "아직 아무런 기록이 없어요 🥲", attributes: [NSAttributedString.Key.font: UIFont(name: "Pretendard-Regular", size: 14)!, NSAttributedString.Key.kern: -0.7])
                    } else {
                        self.tableView.isHidden = false
                        self.noDiaryLabel.isHidden = true
                        self.groupDiariesByDate()
                        self.tableView.reloadData()
                    }
                }
            case .pathErr:
                print("전체 기록 조회 결과 :: Path Err")
            case .requestErr:
                print("전체 기록 조회 결과 :: Request Err")
            case .serverErr:
                print("전체 기록 조회 결과 :: Server Err")
            case .networkFail:
                print("전체 기록 조회 결과 :: Network Fail")
            }
        }
    }
    
    // 옵저버 해제
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func handleDiaryUpdate() {
        DiaryService.shared.getDiaries(page: 0, size: 50) { response in
            switch response {
            case .success(let data):
                if let data = data as? GetDiaryModel {
                    print("전체 기록 조회 결과 :: \(data.result)")
                    self.diaries = data.data.content
                    
                    if self.diaries.isEmpty {
                        self.tableView.isHidden = true
                        self.noDiaryLabel.isHidden = false
                        self.noDiaryLabel.attributedText = NSAttributedString(string: "아직 아무런 기록이 없어요 🥲", attributes: [NSAttributedString.Key.font: UIFont(name: "Pretendard-Regular", size: 14)!, NSAttributedString.Key.kern: -0.7])
                    } else {
                        self.noDiaryLabel.isHidden = true
                        self.groupDiariesByDate()
                        self.tableView.reloadData()
                        self.tableView.isHidden = false
                    }
                }
            case .pathErr:
                print("전체 기록 조회 결과 :: Path Err")
            case .requestErr:
                print("전체 기록 조회 결과 :: Request Err")
            case .serverErr:
                print("전체 기록 조회 결과 :: Server Err")
            case .networkFail:
                print("전체 기록 조회 결과 :: Network Fail")
            }
        }
    }
    
    func groupDiariesByDate() {
        groupedDiaries.removeAll()
        // 날짜별로 diary 객체 그룹화하기
        for diary in diaries {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let dateString = formatter.string(from: diary.date)
            groupedDiaries[dateString, default: []].append(diary)
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
            cell.title.attributedText = NSAttributedString(string: diary.title, attributes: [NSAttributedString.Key.font: UIFont(name: "Pretendard-Medium", size: 14)!, NSAttributedString.Key.kern: -0.7])
            
            var emotionStr: String = ""
            
            switch diary.mood {
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
            
            cell.emotion.attributedText = NSAttributedString(string: emotionStr, attributes: [NSAttributedString.Key.font: UIFont(name: "Pretendard-Regular", size: 12)!, NSAttributedString.Key.kern: -0.6])
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
                    
                    destination.diaryId = diary.diaryId

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
