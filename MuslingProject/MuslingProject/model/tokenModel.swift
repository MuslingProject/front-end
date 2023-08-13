//
//  tokenModel.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/07/08.
//

import Foundation

struct ResponseModel: Codable {
    let status: Int
    let message: String
    let data: String
}

struct NonDataModel: Codable {
    let status: Int
    let message: String
}

struct MypageModel: Codable {
    let status: Int
    let message: String
    let data: MyData
}

struct MyData: Codable {
    let name: String
    let profile: ProfileData
}

struct ProfileData: Codable {
    let profileId: Int
    let imageUrl: String
}
