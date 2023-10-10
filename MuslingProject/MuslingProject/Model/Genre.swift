//
//  Genre.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/06/06.
//

class Genre {
    static var shared = Genre()
    var indie: Bool!
    var balad: Bool!
    var rockMetal: Bool!
    var dancePop: Bool!
    var rapHiphop: Bool!
    var rbSoul: Bool!
    var forkAcoustic: Bool!
}


let GenreDescKo: [String: String] = [
    "balad": "🎤 발라드",
    "indie": "🎹 인디",
    "rockMetal": "🎸 락/메탈",
    "dancePop": "🕺 댄스/팝",
    "rapHiphop": "🎧 랩/힙합",
    "rbSoul": "🎵 알앤비",
    "forkAcoustic": "🎶 어쿠스틱"
]
