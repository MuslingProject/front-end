//
//  Recommend.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/06/13.
//

import Foundation

struct EmotionMusic {
    let title: String
    let singer: String
    let emotion: String
}

struct WeatherMusic {
    let title: String
    let singer: String
    let weather: String
}

extension EmotionMusic {
    static var data = [
        EmotionMusic(title: "I AM", singer: "IVE (아이브)", emotion: "사랑/기쁨"),
        EmotionMusic(title: "Spicy", singer: "aespa", emotion: "사랑/기쁨"),
        EmotionMusic(title: "After Like", singer: "IVE (아이브)", emotion: "사랑/기쁨")
    ]
}

extension WeatherMusic {
    static var data = [
        WeatherMusic(title: "낯선 이별", singer: "DK(디셈버)", weather: "흐림/비"),
        WeatherMusic(title: "작은 온기", singer: "허각", weather: "흐림/비"),
        WeatherMusic(title: "오랜만이야", singer: "한동근", weather: "흐림/비")
    ]
}
