//
//  SelectViewController.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/04/12.
//

import UIKit

class SelectViewController: UIViewController {

    @IBOutlet var ageBtn: UIButton!
    @IBOutlet var label: UILabel!
    @IBOutlet var kpop: UIButton!
    @IBOutlet var balad: UIButton!
    @IBOutlet var hiphop: UIButton!
    @IBOutlet var inde: UIButton!
    @IBOutlet var metal: UIButton!
    @IBOutlet var rnb: UIButton!
    
    @IBAction func finishBtn(_ sender: UIButton) {
        // 홈으로 이동
        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC")
        vcName?.modalPresentationStyle = .fullScreen
        vcName?.modalTransitionStyle = .crossDissolve
        self.present(vcName!, animated: true, completion: nil)
    }
    
    let ages = ["10대", "20대", "30대", "40대", "50대 이상"]
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "당신의 취향에 맞게\n노래를 추천해 드릴게요 🎶"
        
    }

}
