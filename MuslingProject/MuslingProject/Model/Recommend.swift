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
        EmotionMusic(img: "https://image.bugsm.co.kr/album/images/200/203921/20392185.jpg?version=20211013005610.0", title: "DOOL", singer: "미노이(meenoi)", emotion: "사랑/기쁨"),
        EmotionMusic(img: "https://image.bugsm.co.kr/album/images/200/200545/20054544.jpg?version=20190515004930.0", title: "My Dear", singer: "Red Velvet (레드벨벳)", emotion: "사랑/기쁨"),
        EmotionMusic(img: "https://image.bugsm.co.kr/album/images/200/166101/16610139.jpg?version=20230306150744.0", title: "BETELGEUSE", singer: "Yuuri", emotion: "사랑/기쁨")
    ]
    
    static var reData = [
        EmotionMusic(img: "https://image.bugsm.co.kr/album/images/200/3474/347413.jpg?version=20211216020254.0", title: "귀여워 (With 권정열 Of 10cm)", singer: "별", emotion: "사랑/기쁨"),
        EmotionMusic(img: "https://image.bugsm.co.kr/album/images/200/201221/20122134.jpg?version=20220716012243.0", title: "썸 탈꺼야", singer: "볼빨간사춘기", emotion: "사랑/기쁨"),
        EmotionMusic(img: "https://image.bugsm.co.kr/album/images/200/40773/4077389.jpg?version=20220706005646.0", title: "그라데이션", singer: "10CM", emotion: "사랑/기쁨")
    ]
}

extension WeatherMusic {
    static var data = [
        WeatherMusic(img: "https://image.bugsm.co.kr/album/images/200/201049/20104917.jpg?version=20211216040901.0", title: "비도 오고 그래서 (Feat. 신용재)", singer: "헤이즈(Heize)", weather: "흐림/비"),
        WeatherMusic(img: "https://image.bugsm.co.kr/album/images/200/40796/4079641.jpg?version=20220916063541.0", title: "Min (미는 남자)", singer: "검정치마", weather: "흐림/비"),
        WeatherMusic(img: "https://image.bugsm.co.kr/album/images/200/201002/20100228.jpg?version=20210428040321.0", title: "EVERYTHING", singer: "검정치마", weather: "흐림/비")
    ]
    
    static var reData = [
        WeatherMusic(img: "https://image.bugsm.co.kr/album/images/200/6168/616831.jpg?version=20220706024005.0", title: "Thunder", singer: "Imagine Dragons(이매진 드래곤스)", weather: "흐림/비"),
        WeatherMusic(img: "https://image.bugsm.co.kr/album/images/200/201422/20142247.jpg?version=20190910045350.0", title: "너의 온도 (Remind of You)", singer: "청하", weather: "흐림/비"),
        WeatherMusic(img: "https://image.bugsm.co.kr/album/images/200/202371/20237198.jpg?version=20210421045158.0", title: "꿈과 책과 힘과 벽", singer: "잔나비", weather: "흐림/비")
    ]
}
