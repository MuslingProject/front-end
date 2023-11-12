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
        Music(songTitle: "DOOL", coverImagePath: "https://image.bugsm.co.kr/album/images/200/203921/20392185.jpg?version=20211013005610.0", singer: "미노이(meenoi)", emotion: "사랑/기쁨", weather: nil),
        Music(songTitle: "DOOL2", coverImagePath: "https://image.bugsm.co.kr/album/images/200/203921/20392185.jpg?version=20211013005610.0", singer: "미노이(meenoi)", emotion: "사랑/기쁨", weather: nil),
        Music(songTitle: "My Dear", coverImagePath: "https://image.bugsm.co.kr/album/images/200/200545/20054544.jpg?version=20190515004930.0", singer: "Red Velvet (레드벨벳)", emotion: "이별/슬픔", weather: nil),
        Music(songTitle: "My Dear2", coverImagePath: "https://image.bugsm.co.kr/album/images/200/200545/20054544.jpg?version=20190515004930.0", singer: "Red Velvet (레드벨벳)", emotion: "이별/슬픔", weather: nil),
        Music(songTitle: "BETELGEUSE", coverImagePath: "https://image.bugsm.co.kr/album/images/200/166101/16610139.jpg?version=20230306150744.0", singer: "Yuuri", emotion: "우울", weather: nil),
        Music(songTitle: "BETELGEUSE2", coverImagePath: "https://image.bugsm.co.kr/album/images/200/166101/16610139.jpg?version=20230306150744.0", singer: "Yuuri", emotion: "우울", weather: nil),
        Music(songTitle: "BETELGEUSE3", coverImagePath: "https://image.bugsm.co.kr/album/images/200/166101/16610139.jpg?version=20230306150744.0", singer: "Yuuri", emotion: "멘붕/불안", weather: nil),
        Music(songTitle: "BETELGEUSE4", coverImagePath: "https://image.bugsm.co.kr/album/images/200/166101/16610139.jpg?version=20230306150744.0", singer: "Yuuri", emotion: "스트레스/짜증", weather: nil),
        Music(songTitle: "BETELGEUSE5", coverImagePath: "https://image.bugsm.co.kr/album/images/200/166101/16610139.jpg?version=20230306150744.0", singer: "Yuuri", emotion: "스트레스/짜증", weather: nil),
        Music(songTitle: "비도 오고 그래서 (Feat. 신용재)", coverImagePath: "https://image.bugsm.co.kr/album/images/200/201049/20104917.jpg?version=20211216040901.0", singer: "헤이즈(Heize)", emotion: nil,  weather: "비/흐림"),
        Music(songTitle: "비도 오고 그래서 (Feat. 신용재)2", coverImagePath: "https://image.bugsm.co.kr/album/images/200/201049/20104917.jpg?version=20211216040901.0", singer: "헤이즈(Heize)", emotion: nil,  weather: "화창한 날"),
        Music(songTitle: "비도 오고 그래서 (Feat. 신용재)3", coverImagePath: "https://image.bugsm.co.kr/album/images/200/201049/20104917.jpg?version=20211216040901.0", singer: "헤이즈(Heize)", emotion: nil,  weather: "화창한 날"),
        Music(songTitle: "Min (미는 남자)", coverImagePath: "https://image.bugsm.co.kr/album/images/200/40796/4079641.jpg?version=20220916063541.0", singer: "검정치마", emotion: nil, weather: "눈오는 날"),
        Music(songTitle: "EVERYTHING", coverImagePath: "https://image.bugsm.co.kr/album/images/200/201002/20100228.jpg?version=20210428040321.0", singer: "검정치마", emotion: nil, weather: "비/흐림")
    ]
}
