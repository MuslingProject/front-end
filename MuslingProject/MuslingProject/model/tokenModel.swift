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

struct GenreModel: Codable {
    let status: Int
    let message: String
}
