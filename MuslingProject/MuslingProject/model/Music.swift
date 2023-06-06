//
//  Music.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/06/06.
//

import Foundation

struct Music {
    let title: String
    let singer: String
    let emotion: String
}

extension Music {
    static var data = [
        Music(title: "I AM", singer: "IVE (아이브)", emotion: "사랑/기쁨"),
        Music(title: "Spicy", singer: "aespa", emotion: "사랑/기쁨"),
        Music(title: "After Like", singer: "IVE (아이브)", emotion: "사랑/기쁨"),
        Music(title: "퀸카(Queencard)", singer: "(여자)아이들", emotion: "이별/슬픔"),
        Music(title: "UNFORGIVEN", singer: "LE SSERAFIM(르세라핌)", emotion: "스트레스/짜증"),
        Music(title: "Cupid", singer: "FIFTY FIFTY", emotion: "스트레스/짜증"),
        Music(title: "Teddy Bear", singer: "STAYC (스테이씨)", emotion: "스트레스/짜증"),
        Music(title: "꽃", singer: "지수(JISOO)", emotion: "멘붕/불안"),
        Music(title: "손오공", singer: "세븐틴 (SEVENTEEN)", emotion: "멘붕/불안"),
        Music(title: "Ditto", singer: "NewJeans", emotion: "우울"),
        Music(title: "Hype Boy", singer: "NewJeans", emotion: "우울")
    ]
}
