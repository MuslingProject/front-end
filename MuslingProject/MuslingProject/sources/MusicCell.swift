//
//  MusicCell.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/07/24.
//

import UIKit

class MusicCell: UICollectionViewCell {
    static let cellId = "music"
    static let className = "MusicCell"

    @IBOutlet var title: UILabel!
    @IBOutlet var singer: UILabel!
    @IBOutlet var img: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //configureRoundedCorners()
        roundImg()
    }
    
    private func configureRoundedCorners() {
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
    
    private func roundImg() {
        img.layer.cornerRadius = 5
        img.layer.masksToBounds = true
    }
}
