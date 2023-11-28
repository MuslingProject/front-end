//
//  Music.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/06/06.
//

import Foundation

struct Music {
    let songTitle: String
    let coverImagePath: String
    let singer: String
    let emotion: String?
    let weather: String?
}

extension Music {
    static var data = [
        Music(songTitle: "my future", coverImagePath: "https://image.bugsm.co.kr/album/images/200/9905/990553.jpg?version=20220618014410.0", singer: "Billie Eilish(빌리 아일리시)", emotion: "멘붕/불안", weather: nil),
        Music(songTitle: "Feel Good", coverImagePath: "https://image.bugsm.co.kr/album/images/200/143506/14350652.jpg?version=20220803020230.0", singer: "Polo & Pan", emotion: "멘붕/불안", weather: nil),
        Music(songTitle: "우울증", coverImagePath: "https://image.bugsm.co.kr/album/images/200/205370/20537030.jpg?version=20230201005520.0", singer: "데일리랩(dailylab)", emotion: "우울", weather: nil),
        Music(songTitle: "빌었어", coverImagePath: "https://image.bugsm.co.kr/album/images/200/202917/20291742.jpg?version=20200526103054.0", singer: "창모(CHANGMO)", emotion: "우울", weather: nil),
        Music(songTitle: "여행하듯 꿈을 꾸듯", coverImagePath: "https://image.bugsm.co.kr/album/images/200/205341/20534132.jpg?version=20221215005100.0", singer: "406호 프로젝트", emotion: "사랑/기쁨", weather: nil),
        Music(songTitle: "sweet and sour", coverImagePath: "https://image.bugsm.co.kr/album/images/200/205439/20543910.jpg?version=20230209012341.0", singer: "슈가볼(Sugarbowl) CONNECT 아티스트", emotion: "사랑/기쁨", weather: nil),
        Music(songTitle: "어쩌다 이별", coverImagePath: "https://image.bugsm.co.kr/album/images/200/40839/4083923.jpg?version=20230220120002.0", singer: "유다원", emotion: "이별/슬픔", weather: nil),
        Music(songTitle: "비라도 내리면", coverImagePath: "https://image.bugsm.co.kr/album/images/200/202004/20200405.jpg?version=20190731054415.0", singer: "트리탑스(Tritops)", emotion: "이별/슬픔", weather: nil),
        Music(songTitle: "소우주 (Mikrokosmos)", coverImagePath: "https://image.bugsm.co.kr/album/images/200/202460/20246036.jpg?version=20210428040432.0", singer: "방탄소년단", emotion: "스트레스/짜증", weather: nil),
        Music(songTitle: "Hate you", coverImagePath: "https://image.bugsm.co.kr/album/images/200/203663/20366390.jpg?version=20221209010540.0", singer: "백예린 (Yerin Baek)", emotion: "스트레스/짜증", weather: nil),
        Music(songTitle: "J에게", coverImagePath: "https://image.bugsm.co.kr/album/images/200/18/1866.jpg?version=20211215005359.0", singer: "이선희", emotion: nil, weather: "비/흐림"),
        Music(songTitle: "동네 (응답하라 1988 삽입곡)", coverImagePath: "https://image.bugsm.co.kr/album/images/200/58/5849.jpg?version=20220428164239.0", singer: "김현철", emotion: nil, weather: "비/흐림"),
        Music(songTitle: "12월 24일", coverImagePath: "https://image.bugsm.co.kr/album/images/200/3554/355489.jpg?version=20211216014714.0", singer: "디어(d.ear)", emotion: nil, weather: "눈오는 날"),
        Music(songTitle: "선물", coverImagePath: "https://image.bugsm.co.kr/album/images/200/201074/20107410.jpg?version=20220324021603.0", singer: "멜로망스(MeloMance)", emotion: nil, weather: "눈오는 날"),
        Music(songTitle: "봄사탕", coverImagePath: "https://image.bugsm.co.kr/album/images/200/202398/20239827.jpg?version=20190731055212.0", singer: "Bahn", emotion: nil, weather: "화창한 날"),
        Music(songTitle: "Never Enough", coverImagePath: "https://image.bugsm.co.kr/album/images/200/158057/15805766.jpg?version=20210719164715.0", singer: "Urban Cone(어반 콘)", emotion: nil, weather: "화팡한 날")
        
    ]
}
