//
//  Category.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/05/23.
//

import UIKit

struct Category {
    let emotion: String
    let emoji: String
}

extension Category {
    static var data = [
        Category(emotion: "기쁨/사랑", emoji: "🥰"),
        Category(emotion: "이별/슬픔", emoji: "😢"),
        Category(emotion: "스트레스/짜증", emoji: "😡"),
        Category(emotion: "멘붕/불안", emoji: "🤯"),
        Category(emotion: "우울", emoji: "🫠")
    ]
}
