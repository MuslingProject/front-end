//
//  FavoriteViewController.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/04/17.
//

import UIKit

class FavoriteViewController: UITableViewController {
    
    // 더미데이터 불러오기
    let categoryList = Category.emotion
    let musics = Music.data
    
    
    // 감정별 배열
    var happy: [Music] = []
    var sad: [Music] = []
    var stress: [Music] = []
    var unrest: [Music] = []
    var depressed: [Music] = []

    let cellSpacingHeight: CGFloat = 50

    
    // MARK: - Section
    override func numberOfSections(in tableView: UITableView) -> Int {
        return categoryList.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String {
        return categoryList[section]
    }
    
    // 각 섹션 사이의 간격 설정
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    // 헤더 글자 스타일 변경
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let myLabel = UILabel()
        myLabel.frame = CGRect(x: 10, y: 16, width: 320, height: 35)
        myLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        myLabel.font = UIFont.boldSystemFont(ofSize: 15)
        myLabel.textColor = UIColor.darkGray
        
        let headerView = UIView()
        headerView.addSubview(myLabel)
        
        return headerView
    }
    
    // MARK: - Row Cell
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return happy.count
        } else if section == 1 {
            return sad.count
        } else if section == 2 {
            return stress.count
        } else if section == 3 {
            return unrest.count
        } else if section == 4 {
            return depressed.count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CategoryListCell
        
        if indexPath.section == 0 {
            let target = happy[indexPath.row]
            cell.title.text = target.title
            cell.singer.text = target.singer
        } else if indexPath.section == 1 {
            let target = sad[indexPath.row]
            cell.title.text = target.title
            cell.singer.text = target.singer
        } else if indexPath.section == 2 {
            let target = stress[indexPath.row]
            cell.title.text = target.title
            cell.singer.text = target.singer
        } else if indexPath.section == 3 {
            let target = unrest[indexPath.row]
            cell.title.text = target.title
            cell.singer.text = target.singer
        } else if indexPath.section == 4 {
            let target = depressed[indexPath.row]
            cell.title.text = target.title
            cell.singer.text = target.singer
        } else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addMusic()
    }
    
    // navigation bar 배경, 타이틀, item 색상 변경
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .primary
        
        if let customFont = UIFont(name: "Pretendard-Bold", size: 26) {
            appearance.largeTitleTextAttributes = [
                .font: customFont,
                .foregroundColor: UIColor.white
            ]
        } else {
            print("폰트를 로드할 수 없습니다.")
        }
        
        if let customFont2 = UIFont(name: "Pretendard-Bold", size: 15) {
            appearance.titleTextAttributes = [
                .font: customFont2,
                .foregroundColor: UIColor.white
            ]
        } else {
            print("폰트를 로드할 수 없습니다.")
        }
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        navigationController?.navigationBar.tintColor = .white
        
        // navigation bar 그림자 효과
        navigationController?.navigationBar.layer.masksToBounds = false
        navigationController?.navigationBar.layer.shadowColor = UIColor.primary?.cgColor
        navigationController?.navigationBar.layer.shadowOpacity = 0.8
        navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2)
        navigationController?.navigationBar.layer.shadowRadius = 2
    }
    
    func addMusic() {
        for music in musics {
            switch music.emotion {
            case "사랑/기쁨":
                happy.append(music)
                break
            case "이별/슬픔":
                sad.append(music)
                break
            case "스트레스/짜증":
                stress.append(music)
                break
            case "멘붕/불안":
                unrest.append(music)
                break
            case "우울":
                depressed.append(music)
                break
            default:
                break
            }
        }
    }
}

// custom Cell
class CategoryListCell: UITableViewCell {
    @IBOutlet var title: UILabel!
    @IBOutlet var singer: UILabel!
}
