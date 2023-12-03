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
    @IBOutlet var segmentControl: UISegmentedControl!
    @IBOutlet var mainView: UIView!
    
    var diaries: [DiaryModel] = []
    var groupedDiaries: [String: [DiaryModel]] = [:]
    var diaryDates: [String] = []
    
    var currentSegmentIndex = 0
    
    private enum Constants {
        static let segmentedControlHeight: CGFloat = 35
        static let underlineViewColor: UIColor = .text02!
        static let underlineViewHeight: CGFloat = 3
    }
    
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        currentSegmentIndex = sender.selectedSegmentIndex
        changeSegmentedControlLinePosition(for: sender.selectedSegmentIndex)
        switch currentSegmentIndex {
        case 0:
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
        case 1:
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // POSIX 기준 시간으로 설정
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
            
            let date1 = "2023-11-30 15:00:00 +0000"
            let date2 = "2023-11-29 15:00:00 +0000"
            
            diaries = [DiaryModel(diaryId: 100, title: "더현대 다녀왔다", date: dateFormatter.date(from: date1)!, weather: "비/흐림", content: "오늘 더현대를 다녀왔는데 진짜 사람들이 너무너무 많았다 ㅠㅠ 웨이팅 다 기다렸는데 내 차례 됐다는 알람이 안 와서 못 들어감.... 너무 아쉬운데 짜증나기도 했다", mood: "멘붕/불안", recommendations: [RecMusicModel(songTitle: "노스텔지아  노스텔지아!", coverImagePath: "https://image.bugsm.co.kr/album/images/200/202742/20274216.jpg?version=20221205000045.0", singer: "사공(Sagong)", emotion: Optional("멘붕/불안"), weather: nil), RecMusicModel(songTitle: "Heavy Rain", coverImagePath: "https://image.bugsm.co.kr/album/images/200/203941/20394109.jpg?version=20210430180003.0", singer: "검정치마", emotion: Optional("멘붕/불안"), weather: nil), RecMusicModel(songTitle: "내가 사랑하는 당신  머문 곳에", coverImagePath: "https://image.bugsm.co.kr/album/images/200/203332/20333219.jpg?version=20221204234506.0", singer: "DANIEL", emotion: Optional("멘붕/불안"), weather: nil), RecMusicModel(songTitle: "Til The End", coverImagePath: "https://image.bugsm.co.kr/album/images/200/204798/20479837.jpg?version=20220716010807.0", singer: "해리안 윤소안(Harryan Yoonsoan)", emotion: nil, weather: Optional("비/흐림")), RecMusicModel(songTitle: "단발머리", coverImagePath: "https://image.bugsm.co.kr/album/images/200/48/4828.jpg?version=20221114173012.0", singer: "조용필", emotion: nil, weather: Optional("비/흐림")), RecMusicModel(songTitle: "내 안의 외로움은 사라져", coverImagePath: "https://image.bugsm.co.kr/album/images/200/205021/20502132.jpg?version=20221028120005.0", singer: "겸(GYE0M)", emotion: nil, weather: Optional("비/흐림"))]), DiaryModel(diaryId: 99, title: "12월 하루 전이라니", date: dateFormatter.date(from: date2)!, weather: "화창한 날", content: "이제 2024년이 다가오고 있다는 게 정말 실감이 난다… 시간이 왜 이렇게 빠른 건지 😞 앞으로 어떻게 해야 할지 걱정이 많이 된다", mood: "이별/슬픔", recommendations: [RecMusicModel(songTitle: "캠퍼스 로망스 (feat. 기리보이)", coverImagePath: "https://image.bugsm.co.kr/album/images/200/200430/20043024.jpg?version=20211225003856.0", singer: "러비 (LOVEY)", emotion: Optional("이별/슬픔"), weather: nil), RecMusicModel(songTitle: "키스미", coverImagePath: "https://image.bugsm.co.kr/album/images/200/3628/362851.jpg?version=20200515002356.0", singer: "참솜(Chamsom) CONNECT 아티스트", emotion: Optional("이별/슬픔"), weather: nil), RecMusicModel(songTitle: "VENOM", coverImagePath: "https://image.bugsm.co.kr/album/images/200/204700/20470052.jpg?version=20230317003326.0", singer: "BVNDIT (밴디트)", emotion: Optional("이별/슬픔"), weather: nil), RecMusicModel(songTitle: "Cameo", coverImagePath: "https://image.bugsm.co.kr/album/images/200/200839/20083983.jpg?version=20210421044041.0", singer: "러블리즈(Lovelyz)", emotion: nil, weather: Optional("화창한 날")), RecMusicModel(songTitle: "Attention", coverImagePath: "https://image.bugsm.co.kr/album/images/200/40780/4078016.jpg?version=20221014011218.0", singer: "NewJeans", emotion: nil, weather: Optional("화창한 날")), RecMusicModel(songTitle: "MAGO", coverImagePath: "https://image.bugsm.co.kr/album/images/200/40135/4013503.jpg?version=20210421042703.0", singer: "여자친구(GFRIEND)", emotion: nil, weather: Optional("화창한 날"))])]
            
            groupDiariesByDate()
            tableView.reloadData()
//            DiaryService.shared.getHeartDiaries(page: 0, size: 50) { response in
//                switch response {
//                case .success(let data):
//                    if let data = data as? GetDiaryModel {
//                        print("찜한 기록 조회 결과 :: \(data.result)")
//                        self.diaries = data.data.content
//                        
//                        if self.diaries.isEmpty {
//                            self.tableView.isHidden = true
//                            self.noDiaryLabel.isHidden = false
//                            self.noDiaryLabel.attributedText = NSAttributedString(string: "아직 아무런 기록이 없어요 🥲", attributes: [NSAttributedString.Key.font: UIFont(name: "Pretendard-Regular", size: 14)!, NSAttributedString.Key.kern: -0.7])
//                        } else {
//                            self.tableView.isHidden = false
//                            self.noDiaryLabel.isHidden = true
//                            self.groupDiariesByDate()
//                            self.tableView.reloadData()
//                        }
//                    }
//                case .pathErr:
//                    print("찜한 기록 조회 결과 :: Path Err")
//                case .requestErr:
//                    print("찜한 기록 조회 결과 :: Request Err")
//                case .serverErr:
//                    print("찜한 기록 조회 결과 :: Server Err")
//                case .networkFail:
//                    print("찜한 기록 조회 결과 :: Network Fail")
//                }
 //           }
        default:
            break
        }
    }
    
    // Container view of the segmented control
    private lazy var segmentedControlContainerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .clear
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    // The underline view below the segmented control
    private lazy var bottomUnderlineView: UIView = {
        let underlineView = UIView()
        underlineView.backgroundColor = Constants.underlineViewColor
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        return underlineView
    }()
    
    private lazy var leadingDistanceConstraint: NSLayoutConstraint = {
        return bottomUnderlineView.leftAnchor.constraint(equalTo: segmentedControlContainerView.leftAnchor)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleDiaryUpdate), name: .diaryUpdated, object: nil)
        
        noDiaryLabel.isHidden = true
        
        titleLabel.attributedText = NSAttributedString(string: "내 기록 모아보기 📔", attributes: [NSAttributedString.Key.font: UIFont(name: "Pretendard-ExtraBold", size: 26)!, NSAttributedString.Key.kern: -1.7])
        
        tableView.delegate = self
        tableView.dataSource = self
        
        mainView.addSubview(segmentedControlContainerView)
        segmentedControlContainerView.addSubview(segmentControl)
        segmentedControlContainerView.addSubview(bottomUnderlineView)
        segmentControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        segmentControl.backgroundColor = .clear
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        
        segmentControl.setiOS12Layout(tintColor: .text01!)
        
        // Constrain the container view to the view controller
        NSLayoutConstraint.activate([
            segmentedControlContainerView.topAnchor.constraint(equalTo: segmentControl.topAnchor),
            segmentedControlContainerView.leadingAnchor.constraint(equalTo: segmentControl.leadingAnchor),
            segmentedControlContainerView.widthAnchor.constraint(equalTo: segmentControl.widthAnchor),
            segmentedControlContainerView.heightAnchor.constraint(equalToConstant: Constants.segmentedControlHeight)
        ])
        
        // Constrain the segmentControled control to the container view
        NSLayoutConstraint.activate([
            segmentControl.topAnchor.constraint(equalTo: segmentedControlContainerView.topAnchor),
            segmentControl.leadingAnchor.constraint(equalTo: segmentedControlContainerView.leadingAnchor),
            segmentControl.centerXAnchor.constraint(equalTo: segmentedControlContainerView.centerXAnchor),
            segmentControl.centerYAnchor.constraint(equalTo: segmentedControlContainerView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            bottomUnderlineView.bottomAnchor.constraint(equalTo: segmentControl.bottomAnchor),
            bottomUnderlineView.heightAnchor.constraint(equalToConstant: Constants.underlineViewHeight),
            leadingDistanceConstraint
        ])
        
        DispatchQueue.main.async {
            self.changeSegmentedControlLinePosition(for: self.segmentControl.selectedSegmentIndex)
            self.tableView.reloadData()
        }
        
        
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
    
    // Change position of the underline
    private func changeSegmentedControlLinePosition(for selectedIndex: Int) {
        // 기존의 너비 제약조건을 비활성화합니다.
        if let widthConstraint = bottomUnderlineView.constraints.first(where: { $0.firstAttribute == .width }) {
            bottomUnderlineView.removeConstraint(widthConstraint)
        }
        
        let segmentTitle = segmentControl.titleForSegment(at: selectedIndex) ?? ""
        let labelSize = (segmentTitle as NSString).size(withAttributes: [.font: UIFont(name: "Pretendard-Bold", size: 14)!])
        
        // 새로운 너비 제약조건을 활성화합니다.
        let newWidthConstraint = bottomUnderlineView.widthAnchor.constraint(equalToConstant: labelSize.width)
        newWidthConstraint.isActive = true
        
        // Calculate new position
        let segmentWidth = segmentControl.frame.width / CGFloat(segmentControl.numberOfSegments)
        let newX = segmentWidth * CGFloat(selectedIndex) + (segmentWidth - labelSize.width) / 2
        
        // Update constraints
        leadingDistanceConstraint.constant = newX
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
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
