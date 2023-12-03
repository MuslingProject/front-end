//
//  FavoriteViewController.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/04/17.
//

import UIKit

class FavoriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var favoriteTable: UITableView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var segment: UISegmentedControl!
    @IBOutlet var mainView: UIView!
    
    var currentSegmentIndex = 0
    
    var emotionCategory: [String] = []
    var weatherCategory: [String] = []
    var category: [String] = []
    
    // 좋아요한 전체 곡
    var all: [MusicsModel] = []
    
    @IBOutlet var noDataLabel: UILabel!
    
    // 감정별 배열
    var happy: [MusicsModel] = []
    var sad: [MusicsModel] = []
    var stress: [MusicsModel] = []
    var unrest: [MusicsModel] = []
    var depressed: [MusicsModel] = []
    
    // 날씨별 배열
    var sunny: [MusicsModel] = []
    var cloud: [MusicsModel] = []
    var snow: [MusicsModel] = []
    
    let cellSpacingHeight: CGFloat = 50
    
    func classifyMusic() {
        // 찜한 음악 불러오기 api
        
        emotionCategory.removeAll()
        weatherCategory.removeAll()
        happy.removeAll()
        sad.removeAll()
        stress.removeAll()
        depressed.removeAll()
        unrest.removeAll()
        sunny.removeAll()
        cloud.removeAll()
        snow.removeAll()
        
        MusicService.shared.getSaveMusics() { response in
            switch response {
            case .success(let data):
                if let data = data as? GetMusicModel {
                    print("찜한 음악 조회 결과 :: \(data.result)")
                    self.all = data.data
                    
                    for music in self.all {
                        if let emotion = music.emotion {
                            switch emotion {
                            case "사랑/기쁨":
                                self.happy.append(music)
                            case "이별/슬픔":
                                self.sad.append(music)
                            case "스트레스/짜증":
                                self.stress.append(music)
                            case "우울":
                                self.depressed.append(music)
                            case "멘붕/불안":
                                self.unrest.append(music)
                            default:
                                break
                            }
                        } else if let weather = music.weather {
                            switch weather {
                            case "화창한 날":
                                self.sunny.append(music)
                            case "비/흐림":
                                self.cloud.append(music)
                            case "눈오는 날":
                                self.snow.append(music)
                            default:
                                break
                            }
                        }
                    }
                    
                    let musicCategories = [
                        ("🥰 기쁨/사랑", self.happy),
                        ("😢 이별/슬픔", self.sad),
                        ("😡 스트레스/짜증", self.stress),
                        ("😨 불안/멘붕", self.unrest),
                        ("😞 우울", self.depressed)
                    ]
                    
                    let weatherCategories = [
                        ("☀️ 맑음", self.sunny),
                        ("🌧️ 비/흐림", self.cloud),
                        ("🌨️ 눈", self.snow)
                    ]

                    for (categoryName, musicArray) in musicCategories {
                        if !musicArray.isEmpty {
                            self.emotionCategory.append(categoryName)
                        }
                    }
                    
                    for (categoryName, weatherArray) in weatherCategories {
                        if !weatherArray.isEmpty {
                            self.weatherCategory.append(categoryName)
                        }
                    }
                    
                    self.category = self.emotionCategory + self.weatherCategory
                    
                    if self.category.isEmpty {
                        self.noDataLabel.isHidden = false
                        self.noDataLabel.attributedText = NSAttributedString(string: "아직 찜한 노래가 없어요 😉", attributes: [NSAttributedString.Key.font: UIFont(name: "Pretendard-Regular", size: 14)!, NSAttributedString.Key.kern: -0.8])
                    } else {
                        self.noDataLabel.isHidden = true
                        self.favoriteTable.reloadData()
                    }
                }
            case .pathErr:
                print("찜한 음악 조회 결과 :: Path Err")
            case .networkFail:
                print("찜한 음악 조회 결과 :: Network Err")
            case .requestErr:
                print("찜한 음악 조회 결과 :: Request Err")
            case .serverErr:
                print("찜한 음악 조회 결과 :: Server Err")
            }
        }
    }
    
    
    // MARK: - Section
    func numberOfSections(in tableView: UITableView) -> Int {
        switch currentSegmentIndex {
        case 0:
            return category.count
        case 1:
            return emotionCategory.count
        case 2:
            return weatherCategory.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch currentSegmentIndex {
        case 0:
            return category[section]
        case 1:
            return emotionCategory[section]
        case 2:
            return weatherCategory[section]
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.backGray // 원하는 배경색으로 설정하십시오.
        
        let headerLabel = UILabel()
        var selectedCategory: [String] = []
        
        switch currentSegmentIndex {
        case 0:
            selectedCategory = category
        case 1:
            selectedCategory = emotionCategory
        case 2:
            selectedCategory = weatherCategory
        default:
            selectedCategory = []
        }
        
        headerLabel.attributedText = NSMutableAttributedString(string: selectedCategory[section], attributes: [NSAttributedString.Key.kern: -0.6, NSAttributedString.Key.font: UIFont(name: "Pretendard-Bold", size: 12)!, NSAttributedString.Key.foregroundColor: UIColor.text02!])
        
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
    
    // MARK: - Row Cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var selectedCategoryArray: [MusicsModel] = []
        switch currentSegmentIndex {
        case 0:
            let categoryName = category[section]
            selectedCategoryArray = getCategoryArray(for: categoryName)
        case 1:
            let categoryName = emotionCategory[section]
            selectedCategoryArray = getCategoryArray(for: categoryName)
        case 2:
            let categoryName = weatherCategory[section]
            selectedCategoryArray = getCategoryArray(for: categoryName)
        default:
            break
        }
        
        return selectedCategoryArray.count
    }
    
    private func getCategoryArray(for categoryName: String) -> [MusicsModel] {
        switch categoryName {
        case "🥰 기쁨/사랑":
            return happy
        case "😢 이별/슬픔":
            return sad
        case "😡 스트레스/짜증":
            return stress
        case "😨 불안/멘붕":
            return unrest
        case "😞 우울":
            return depressed
        case "☀️ 맑음":
            return sunny
        case "🌧️ 비/흐림":
            return cloud
        case "🌨️ 눈":
            return snow
        default:
            return []
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CategoryListCell
        var target: MusicsModel?
        var selectedCategoryArray: [MusicsModel] = []
        
        switch currentSegmentIndex {
        case 0:
            let categoryName = category[indexPath.section]
            selectedCategoryArray = getCategoryArray(for: categoryName)
        case 1:
            let categoryName = emotionCategory[indexPath.section]
            selectedCategoryArray = getCategoryArray(for: categoryName)
        case 2:
            let categoryName = weatherCategory[indexPath.section]
            selectedCategoryArray = getCategoryArray(for: categoryName)
        default:
            break
        }
        
        target = selectedCategoryArray[indexPath.row]
        
        cell.title.text = target?.titles
        cell.singer.text = target?.singers
        
        if let imageUrl = URL(string: target!.imgs) {
            cell.cover.loadImage(from: imageUrl)
        }
        
        cell.setSpacing()
        cell.roundImg()
        
        cell.selectionStyle = .none
        return cell
    }
    
    private enum Constants {
        static let segmentedControlHeight: CGFloat = 35
        static let underlineViewColor: UIColor = .text02!
        static let underlineViewHeight: CGFloat = 3
    }
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        currentSegmentIndex = sender.selectedSegmentIndex
        favoriteTable.reloadData()
        changeSegmentedControlLinePosition(for: sender.selectedSegmentIndex)
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        noDataLabel.isHidden = true
        
        classifyMusic()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        favoriteTable.dataSource = self
        favoriteTable.delegate = self
        
        titleLabel.attributedText = NSAttributedString(string: "좋아요한 노래 🎧", attributes: [NSAttributedString.Key.font: UIFont(name: "Pretendard-ExtraBold", size: 26)!, NSAttributedString.Key.kern: -1.7])
        
        mainView.addSubview(segmentedControlContainerView)
        segmentedControlContainerView.addSubview(segment)
        segmentedControlContainerView.addSubview(bottomUnderlineView)
        segment.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        segment.backgroundColor = .clear
        segment.translatesAutoresizingMaskIntoConstraints = false
        
        segment.setiOS12Layout(tintColor: .text01!)
        
        // Constrain the container view to the view controller
        NSLayoutConstraint.activate([
            segmentedControlContainerView.topAnchor.constraint(equalTo: segment.topAnchor),
            segmentedControlContainerView.leadingAnchor.constraint(equalTo: segment.leadingAnchor),
            segmentedControlContainerView.widthAnchor.constraint(equalTo: segment.widthAnchor),
            segmentedControlContainerView.heightAnchor.constraint(equalToConstant: Constants.segmentedControlHeight)
        ])
        
        // Constrain the segmented control to the container view
        NSLayoutConstraint.activate([
            segment.topAnchor.constraint(equalTo: segmentedControlContainerView.topAnchor),
            segment.leadingAnchor.constraint(equalTo: segmentedControlContainerView.leadingAnchor),
            segment.centerXAnchor.constraint(equalTo: segmentedControlContainerView.centerXAnchor),
            segment.centerYAnchor.constraint(equalTo: segmentedControlContainerView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            bottomUnderlineView.bottomAnchor.constraint(equalTo: segment.bottomAnchor),
            bottomUnderlineView.heightAnchor.constraint(equalToConstant: Constants.underlineViewHeight),
            leadingDistanceConstraint
        ])
        
        DispatchQueue.main.async {
            self.changeSegmentedControlLinePosition(for: self.segment.selectedSegmentIndex)
            self.favoriteTable.reloadData()
        }
    }
    
    
    // Change position of the underline
    private func changeSegmentedControlLinePosition(for selectedIndex: Int) {
        let segmentTitle = segment.titleForSegment(at: selectedIndex) ?? ""
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "Pretendard-Bold", size: 14)!]
        let labelSize = (segmentTitle as NSString).size(withAttributes: attributes)
        
        // Remove existing width constraint
        //NSLayoutConstraint.deactivate([bottomUnderlineView.widthAnchor.constraint(equalTo: segment.widthAnchor, multiplier: 1 / CGFloat(segment.numberOfSegments))])
        
        // Calculate new position
        let segmentWidth = segment.frame.width / CGFloat(segment.numberOfSegments)
        let newX = segmentWidth * CGFloat(selectedIndex) + (segmentWidth - labelSize.width) / 2
        
        // Update constraints
        leadingDistanceConstraint.constant = newX
        let newWidthConstraint = bottomUnderlineView.widthAnchor.constraint(equalToConstant: labelSize.width)
        NSLayoutConstraint.activate([newWidthConstraint])
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}

// custom Cell
class CategoryListCell: UITableViewCell {
    @IBOutlet var cover: UIImageView!
    @IBOutlet var title: UILabel!
    @IBOutlet var singer: UILabel!
    
    func setSpacing() {
        title.attributedText = NSAttributedString(string: title.text!, attributes: [NSAttributedString.Key.font: UIFont(name: "Pretendard-SemiBold", size: 14)!, NSAttributedString.Key.kern: -0.5])
        singer.attributedText = NSAttributedString(string: singer.text!, attributes: [NSAttributedString.Key.font: UIFont(name: "Pretendard-Regular", size: 12)!, NSAttributedString.Key.kern: -0.7])
    }
    
    func roundImg() {
        cover.layer.masksToBounds = true
        cover.layer.cornerRadius = 10
    }
}

extension UISegmentedControl {
    func setiOS12Layout(tintColor: UIColor) {
        if #available(iOS 13, *) {
            let background = UIImage(color: .backGray!, size: CGSize(width: 1, height: 32))
            let divider = UIImage(color: .backGray!, size: CGSize(width: 1, height: 32))
            self.setBackgroundImage(background, for: .normal, barMetrics: .default)
            self.setBackgroundImage(background, for: .selected, barMetrics: .default)
            self.setBackgroundImage(background, for: .highlighted, barMetrics: .default)
            self.setBackgroundImage(divider, for: .selected, barMetrics: .default)
            
            self.setDividerImage(divider, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
            
            self.setTitleTextAttributes([.font: UIFont(name: "Pretendard-Bold", size: 15)!, .foregroundColor: UIColor.text02!, .kern: -0.65], for: .normal)
            self.setTitleTextAttributes([.font: UIFont(name: "Pretendard-Bold", size: 15)!, .foregroundColor: UIColor.text02!, .kern: -0.65], for: .selected)
            
        } else {
            self.tintColor = tintColor
        }
    }
}

extension UIImage {
    convenience init(color: UIColor, size: CGSize) {
        UIGraphicsBeginImageContextWithOptions(size, false, 1)
        color.set()
        let context = UIGraphicsGetCurrentContext()!
        context.fill(CGRect(origin: .zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.init(data: image.pngData()!)!
    }
}
