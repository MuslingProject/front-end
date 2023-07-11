//
//  DiaryListViewController.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/07/11.
//

import UIKit

class DiaryListViewController: UITableViewController {
    
    // 더미데이터 불러오기
    let diaries = Diary.data
    
    let cellSpacingHeight: CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return diaries.count
    }

    // 한 섹션 당 row 수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    // 각 섹션 사이의 간격 설정
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    // MARK: = Row Cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "diary", for: indexPath) as! DiaryCell
        
        for i in 0...diaries.count {
            if indexPath.section == i {
                let target = diaries[i]
                cell.date.text = target.date
                cell.emotion.text = target.emotion
                cell.weather.text = target.weather
                cell.title.text = target.title
                cell.content.text = target.content
            }
        }
        
        
        cell.selectionStyle = .none
        return cell
    }

}

// custom Cell
class DiaryCell: UITableViewCell {
    @IBOutlet var date: UILabel!
    @IBOutlet var emotion: UILabel!
    @IBOutlet var weather: UILabel!
    @IBOutlet var title: UILabel!
    @IBOutlet var content: UILabel!
    @IBAction func showDetail(_ sender: Any) {
        
    }
}

