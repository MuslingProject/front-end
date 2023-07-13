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
    
    let cellSpacingHeight: CGFloat = 0
    
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
                let emotion = target.emotion
                
                switch emotion {
                case "사랑/기쁨":
                    cell.emotion.text = "🥰 사랑/기쁨"
                case "이별/슬픔":
                    cell.emotion.text = "😢 이별/슬픔"
                case "우울":
                    cell.emotion.text = "🫠 우울"
                case "멘붕/불안":
                    cell.emotion.text = "🤯 멘붕/불안"
                case "스트레스/짜증":
                    cell.emotion.text = "😡 스트레스/짜증"
                default:
                    cell.emotion.text = ""
                }
                
                cell.date.text = target.date
                cell.weather.text = target.weather
                cell.title.text = target.title
                cell.content.text = target.content
            }
        }
        return cell
    }
    
    // 데이터 전달
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "diarySegue" {
            if let destination = segue.destination as? DiaryViewController {
                if let selectedIndex =
                    self.tableView.indexPathForSelectedRow {
                    destination.diaryTitle = diaries[selectedIndex[0]].title
                    destination.diaryDate = diaries[selectedIndex[0]].date
                    destination.diaryContent = diaries[selectedIndex[0]].content
                    destination.emotion = diaries[selectedIndex[0]].emotion
                    destination.weather = diaries[selectedIndex[0]].weather
                }
            }
        }
    }

}

// custom Cell
class DiaryCell: UITableViewCell {
    @IBOutlet var date: UILabel!
    @IBOutlet var emotion: UILabel!
    @IBOutlet var weather: UILabel!
    @IBOutlet var title: UILabel!
    @IBOutlet var content: UILabel!
}

