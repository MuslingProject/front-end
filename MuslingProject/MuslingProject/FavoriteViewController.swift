//
//  FavoriteViewController.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/04/17.
//

import UIKit

class FavoriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var background: UIView!
    @IBOutlet var tableView: UITableView!
    
    // 더미데이터 불러오기
    let categoryList = Category.data
    let cellSpacingHeight: CGFloat = 1

    
    // Section당 Row의 수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // Section의 수
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    // 각 섹션 사이의 간격 설정
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CategoryListCell
        let target = categoryList[indexPath.section]
        
        cell.emoji.text = target.emoji
        cell.title.text = target.emotion
        //cell.backgroundColor = UIColor.clear.withAlphaComponent(0)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // cell에 그림자
//        tableView.layer.shadowColor = UIColor.black.cgColor
//        tableView.layer.shadowOpacity = 0.3
//        tableView.layer.shadowRadius = 5
//        tableView.layer.shadowOffset = CGSize(width: 0, height: 10)
//        tableView.layer.masksToBounds = true
//
          tableView.delegate = self
          tableView.dataSource = self
//        //tableView.backgroundColor = UIColor.clear.withAlphaComponent(0)
    }
    
    // navigation bar 배경, 타이틀, item 색상 변경
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .primary
        appearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
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

    
}

// custom Cell
class CategoryListCell: UITableViewCell {
    @IBOutlet weak var emoji: UILabel!
    @IBOutlet weak var title: UILabel!
    
}
