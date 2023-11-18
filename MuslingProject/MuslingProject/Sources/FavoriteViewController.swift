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
    
    // 더미데이터 불러오기
    let emotionCategory = Category.emotion
    let weatherCategory = Category.weather
    let category = Category.all
    
    // 좋아요한 전체 곡
    let all = Music.data
    
    
    // 감정별 배열
    var happy: [Music] = []
    var sad: [Music] = []
    var stress: [Music] = []
    var unrest: [Music] = []
    var depressed: [Music] = []
    
    // 날씨별 배열
    var sunny: [Music] = []
    var cloud: [Music] = []
    var snow: [Music] = []
    
    let cellSpacingHeight: CGFloat = 50
    
    func classifyMusic() {
        for music in all {
            if let emotion = music.emotion {
                switch emotion {
                case "사랑/기쁨":
                    happy.append(music)
                case "이별/슬픔":
                    sad.append(music)
                case "스트레스/짜증":
                    stress.append(music)
                case "우울":
                    depressed.append(music)
                case "멘붕/불안":
                    unrest.append(music)
                default:
                    break
                }
            } else if let weather = music.weather {
                switch weather {
                case "화창한 날":
                    sunny.append(music)
                case "비/흐림":
                    cloud.append(music)
                case "눈오는 날":
                    snow.append(music)
                default:
                    break
                }
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
        var numberOfRows: Int = 0
        switch currentSegmentIndex {
        case 0:
            if section == 0 {
                numberOfRows = happy.count
            } else if section == 1 {
                numberOfRows = sad.count
            } else if section == 2 {
                numberOfRows = stress.count
            } else if section == 3 {
                numberOfRows = unrest.count
            } else if section == 4 {
                numberOfRows = depressed.count
            } else if section == 5 {
                numberOfRows = sunny.count
            } else if section == 6 {
                numberOfRows = cloud.count
            } else if section == 7 {
                numberOfRows = snow.count
            }
        case 1:
            if section == 0 {
                numberOfRows = happy.count
            } else if section == 1 {
                numberOfRows = sad.count
            } else if section == 2 {
                numberOfRows = stress.count
            } else if section == 3 {
                numberOfRows = unrest.count
            } else if section == 4 {
                numberOfRows = depressed.count
            }
        case 2:
            if section == 0 {
                numberOfRows = sunny.count
            } else if section == 1 {
                numberOfRows = cloud.count
            } else if section == 2 {
                numberOfRows = snow.count
            }
        default:
            numberOfRows = 0
        }
        
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CategoryListCell
        var target: Music?
        
        switch currentSegmentIndex {
        case 0:
            if indexPath.section == 0 {
                target = happy[indexPath.row]
            } else if indexPath.section == 1 {
                target = sad[indexPath.row]
            } else if indexPath.section == 2 {
                target = stress[indexPath.row]
            } else if indexPath.section == 3 {
                target = unrest[indexPath.row]
            } else if indexPath.section == 4 {
                target = depressed[indexPath.row]
            } else if indexPath.section == 5 {
                target = sunny[indexPath.row]
            } else if indexPath.section == 6 {
                target = cloud[indexPath.row]
            } else if indexPath.section == 7 {
                target = snow[indexPath.row]
            }
        case 1:
            if indexPath.section == 0 {
                target = happy[indexPath.row]
            } else if indexPath.section == 1 {
                target = sad[indexPath.row]
            } else if indexPath.section == 2 {
                target = stress[indexPath.row]
            } else if indexPath.section == 3 {
                target = unrest[indexPath.row]
            } else if indexPath.section == 4 {
                target = depressed[indexPath.row]
            }
        case 2:
            if indexPath.section == 0 {
                target = sunny[indexPath.row]
            } else if indexPath.section == 1 {
                target = cloud[indexPath.row]
            } else if indexPath.section == 2 {
                target = snow[indexPath.row]
            }
        default:
            break
        }
        
        cell.title.text = target?.songTitle
        cell.singer.text = target?.singer
        
        if let imageUrl = URL(string: target!.coverImagePath) {
            cell.cover.loadImage(from: imageUrl)
        }
        
        cell.setSpacing()
        cell.roundImg()
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        classifyMusic()
        
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
