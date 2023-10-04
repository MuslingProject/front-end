//
//  CSButton.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/04/17.
//

import UIKit

// 버튼 타입을 결정하는 열거형
public enum CSButtonType {
    case shadow
}

class CSButton: UIButton {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        // 스토리보드 방식으로 버튼을 정의했을 때 적용
        self.layer.cornerRadius = 20
        self.layer.borderColor = UIColor.darkGray.cgColor
        self.backgroundColor = UIColor.white
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 2
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowColor = UIColor.darkGray.cgColor
        
    }
}
