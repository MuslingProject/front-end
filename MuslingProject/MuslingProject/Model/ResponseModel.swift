//
//  tokenModel.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/07/08.
//

import Foundation

struct DataModel: Codable {
    let result: String
    let httpStatus: String
    let data: String
}

struct NonDataModel: Codable {
    let result: String
    let httpStatus: String
    let message: String
}

struct MypageModel: Codable {
    let result: String
    let httpStatus: String
    let data: MyData
}

struct NameModifyModel: Codable {
    let result: String
    let httpStatus: String
    let data: NameModel
}

struct NameModel: Codable {
    let oldName: String
    let newName: String
}

struct MyData: Codable {
    let email: String
    let profileImageUrl: String
    let name: String
    let age: String
    let ageRecommendation: Bool
    let preferredGenres: MyGenre
}

struct MyGenre: Codable {
    let indie: Bool
    let balad: Bool
    let rockMetal: Bool
    let dancePop: Bool
    let rapHiphop: Bool
    let rbSoul: Bool
    let forkAcoustic: Bool
}

struct GenreModel: Codable {
    let result: String
    let httpStatus: String
    let data: MyGenre
}

struct DiaryResponseModel: Codable {
    let result: String
    let httpStatus: String
    let data: DiaryModel
    let recommendations: [RecMusicModel]
}

struct DiaryModel: Codable {
    let title: String
    let date: String
    let weather: String
    let content: String
    let mood: String
}

struct RecMusicModel: Codable {
    let songTitle: String
    let coverImagePath: String
    let singer: String
    let emotion: String?
    let weather: String?
}

extension DiaryResponseModel {
    static var data = DiaryResponseModel(result: "success", httpStatus: "OK", data: DiaryModel(title: "기록 제목", date: "2023-11-14", weather: "화창한 날", content: "닐씨 조오타~", mood: "사랑/기쁨"), recommendations: [RecMusicModel(songTitle: "서로로 채워 나갈 순간들", coverImagePath: "https://image.bugsm.co.kr/album/images/200/40843/4084315.jpg?version=20230309003602.0", singer: "마치 (MRCH)", emotion: "사랑/기쁨", weather: nil), RecMusicModel(songTitle: "서로로 채워 나갈 순간들2", coverImagePath: "https://image.bugsm.co.kr/album/images/200/40843/4084315.jpg?version=20230309003602.0", singer: "마치 (MRCH)", emotion: "사랑/기쁨", weather: nil), RecMusicModel(songTitle: "서로로 채워 나갈 순간들3", coverImagePath: "https://image.bugsm.co.kr/album/images/200/40843/4084315.jpg?version=20230309003602.0", singer: "마치 (MRCH)", emotion: "사랑/기쁨", weather: nil), RecMusicModel(songTitle: "Opening Sequence", coverImagePath: "https://image.bugsm.co.kr/album/images/200/40754/4075422.jpg?version=20220521130002.0", singer: "투모로우바이투게더", emotion: nil, weather: "화창한 날"), RecMusicModel(songTitle: "Opening Sequence2", coverImagePath: "https://image.bugsm.co.kr/album/images/200/40754/4075422.jpg?version=20220521130002.0", singer: "투모로우바이투게더", emotion: nil, weather: "화창한 날"), RecMusicModel(songTitle: "Opening Sequence3", coverImagePath: "https://image.bugsm.co.kr/album/images/200/40754/4075422.jpg?version=20220521130002.0", singer: "투모로우바이투게더", emotion: nil, weather: "화창한 날")])
}
