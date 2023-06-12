//
//  RecommendViewController.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/06/13.
//

import UIKit

class RecommendViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTableView: UITableView!
    
    let emotion = EmotionMusic.data
    let weather = WeatherMusic.data
    
    let category = ["기쁨/사랑일 때 🥰", "날씨가 흐림일 때 ☁️"]
    
    let cellSpacingHeight: CGFloat = 50
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return category[section]
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       let myLabel = UILabel()
       myLabel.frame = CGRect(x: 10, y: 16, width: 320, height: 35)
       myLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
       myLabel.font = UIFont.boldSystemFont(ofSize: 15)
       myLabel.textColor = UIColor.darkGray
       
       let headerView = UIView()
       headerView.addSubview(myLabel)
       
       return headerView
   }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return emotion.count
        } else if section == 1 {
            return weather.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recommend", for: indexPath) as! RecommendCell
        
        if indexPath.section == 0 {
            let target = emotion[indexPath.row]
            cell.title.text = target.title
            cell.singer.text = target.singer
        } else if indexPath.section == 1 {
            let target = weather[indexPath.row]
            cell.title.text = target.title
            cell.singer.text = target.singer
        } else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        myTableView.dataSource = self
        myTableView.delegate = self
    }

}

// custom Cell
class RecommendCell: UITableViewCell {
    @IBOutlet var title: UILabel!
    @IBOutlet var singer: UILabel!
}
