//
//  Recommend.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/06/13.
//

import Foundation

struct EmotionMusic {
    let img: String
    let title: String
    let singer: String
    let emotion: String
}

struct WeatherMusic {
    let img: String
    let title: String
    let singer: String
    let weather: String
}

extension EmotionMusic {
    static var data = [
        EmotionMusic(img: "https://image.bugsm.co.kr/album/images/200/3256/325614.jpg?version=20220428164747.0", title: "Beautiful Day", singer: "어반자카파", emotion: "사랑/기쁨"),
        EmotionMusic(img: "https://image.bugsm.co.kr/album/images/200/2145/214521.jpg?version=20210421040542.0", title: "첫사랑이죠", singer: "아이유(IU), 나윤권", emotion: "사랑/기쁨"),
        EmotionMusic(img: "https://image.bugsm.co.kr/album/images/200/3704/370430.jpg?version=20220718183033.0", title: "콩떡빙수", singer: "AKMU(악뮤)", emotion: "사랑/기쁨")
    ]
}

extension WeatherMusic {
    static var data = [
        WeatherMusic(img: "https://image.bugsm.co.kr/album/images/200/40836/4083667.jpg?version=20230321021053.0", title: "낯선 이별", singer: "DK(디셈버)", weather: "흐림/비"),
        WeatherMusic(img: "https://image.bugsm.co.kr/album/images/200/40673/4067362.jpg?version=20220225005025.0", title: "작은 온기", singer: "허각", weather: "흐림/비"),
        WeatherMusic(img: "https://image.bugsm.co.kr/album/images/200/40841/4084128.jpg?version=20230310012650.0", title: "오랜만이야", singer: "한동근", weather: "흐림/비")
    ]
}
