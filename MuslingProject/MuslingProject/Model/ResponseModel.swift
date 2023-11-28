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
    
}

struct ShowDiaryModel: Codable {
    let result: String
    let httpStatus: String
    let data: DiaryModel
}

struct GetDiaryModel: Codable {
    let result: String
    let httpStatus: String
    let data: DiaryModelWithPage
}

struct DiaryModelWithPage: Codable {
    let content: [DiaryModel]
    let pageable: pageableModel
    let totalPages: Int
    let totalElements: Int
    let last: Bool
    let number: Int
    let sort: SortModel
    let size: Int
    let numberOfElements: Int
    let first: Bool
    let empty: Bool
}

struct pageableModel: Codable {
    let sort: SortModel
    let offset: Int
    let pageNumber: Int
    let pageSize: Int
    let unpaged: Bool
    let paged: Bool
}

struct SortModel: Codable {
    let empty: Bool
    let sorted: Bool
    let unsorted: Bool
}

struct DiaryModel: Codable {
    let diaryId: Int64
    let title: String
    let date: Date
    let weather: String
    let content: String
    let mood: String
    let recommendations: [RecMusicModel]
}

struct RecMusicModel: Codable {
    let songTitle: String
    let coverImagePath: String
    let singer: String
    let emotion: String?
    let weather: String?
}

struct AgeRecommendModel: Codable {
    let result: String
    let httpStatus: String
    let data: AgeModel
}

struct AgeModel: Codable {
    let oldAgeRecommendation: Bool
    let newAgeRecommendation: Bool
}

extension RecMusicModel {
    static var recommend = [
        RecMusicModel(songTitle: "DOOL", coverImagePath: "https://image.bugsm.co.kr/album/images/200/203921/20392185.jpg?version=20211013005610.0", singer: "미노이(meenoi)", emotion: "사랑/기쁨", weather: nil),
        RecMusicModel(songTitle: "My Dear", coverImagePath: "https://image.bugsm.co.kr/album/images/200/200545/20054544.jpg?version=20190515004930.0", singer: "Red Velvet (레드벨벳)", emotion: "이별/슬픔", weather: nil),
        RecMusicModel(songTitle: "BETELGEUSE", coverImagePath: "https://image.bugsm.co.kr/album/images/200/166101/16610139.jpg?version=20230306150744.0", singer: "Yuuri", emotion: "우울", weather: nil),
        RecMusicModel(songTitle: "난춘 (亂春)", coverImagePath: "https://image.bugsm.co.kr/album/images/200/203236/20323642.jpg?version=20220601225035.0", singer: "새소년", emotion: nil, weather: "화창한 날"),
        RecMusicModel(songTitle: "EVERYTHING", coverImagePath: "https://image.bugsm.co.kr/album/images/200/201002/20100228.jpg?version=20210428040321.0", singer: "검정치마", emotion: nil, weather: "비/흐림"),
        RecMusicModel(songTitle: "폰서트", coverImagePath: "https://image.bugsm.co.kr/album/images/200/201168/20116852.jpg?version=20230110011420.0", singer: "10CM", emotion: nil, weather: "화창한 날")
    ]
}
