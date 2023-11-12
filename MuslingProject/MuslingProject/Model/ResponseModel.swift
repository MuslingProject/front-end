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
    let profileImageUrl: String
    let name: String
    let age: String
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
    let recommentdations: [RecMusicModel]
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
    let emotion: String
    let weather: String
}
