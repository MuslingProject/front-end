//
//  UILabel.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/09/27.
//

import UIKit

extension UILabel {
    // 자간 설정
    @IBInspectable
    var letterSpacing: CGFloat {
        set {
            let attributedString = NSMutableAttributedString(string: text ?? "")
            attributedString.addAttribute(.kern, value: newValue, range: NSRange(location: 0, length: attributedString.length - 1))
            self.attributedText = attributedString
        }
        get {
            if let currentKerning = attributedText?.attribute(.kern, at: 0, effectiveRange: .none) as? CGFloat {
                return currentKerning
            } else {
                return 0
            }
        }
    }

}
