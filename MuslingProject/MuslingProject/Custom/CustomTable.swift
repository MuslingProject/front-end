//
//  CustomTable.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/09/20.
//

import UIKit

class CustomTable: UITableView {
    
    override var intrinsicContentSize: CGSize {
        return self.contentSize
    }
    
    override var contentSize: CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }
    
}
