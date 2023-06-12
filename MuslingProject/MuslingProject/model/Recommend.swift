//
//  Recommend.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/06/13.
//

import Foundation

struct Recommend {
    let title: String
    let singer: String
    let emotion: String
}

extension Recommend {
    static var data = [
        Music(title: "I AM", singer: "IVE (아이브)", emotion: "사랑/기쁨"),
        Music(title: "Spicy", singer: "aespa", emotion: "사랑/기쁨"),
        Music(title: "After Like", singer: "IVE (아이브)", emotion: "사랑/기쁨")
    ]
}
