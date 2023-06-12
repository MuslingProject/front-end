//
//  RecommendViewController.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/06/13.
//

import UIKit

class RecommendViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTableView: UITableView!
    
    let musics = Recommend.data
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recommend", for: indexPath) as! RecommendCell
        
        let target = musics[indexPath.row]
        
        cell.title.text = target.title
        cell.singer.text = target.singer
        
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
