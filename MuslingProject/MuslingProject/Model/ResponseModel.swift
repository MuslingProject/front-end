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

struct ReRecommendModel: Codable {
    let result: String
    let httpStatus: String
    let data: [RecMusicModel]
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

struct EmotionModel: Codable {
    let result: String
    let httpStatus: String
    let data: EmotionCounts
}

struct EmotionCountModel: Codable {
    let unrest: Int
    let depressed: Int
    let happy: Int
    let sad: Int
    let stress: Int
}

struct EmotionCounts: Codable {
    let emotionCounts: EmotionCountModel
    let mostFrequentEmotion: String
    let mostFrequentEmotionCount: Int
}

struct SaveMusicResponseModel: Codable {
    let result: String
    let httpStatus: String
    let data: SaveMusicModel
}

struct SaveMusicModel: Codable {
    let likes: [LikesMusicModel]
}

struct GetMusicModel: Codable {
    let result: String
    let httpStatus: String
    let data: [MusicsModel]
}

struct LikesMusicModel: Codable {
    let likeId: Int64
    let titles: String
    let imgs: String
    let singers: String
    let emotion: String?
    let weather: String?
}

struct MusicsModel: Codable {
    let likesId: Int64
    let titles: String
    let imgs: String
    let singers: String
    let emotion: String?
    let weather: String?
}

struct SendMusicModel: Codable {
    let titles: String
    let imgs: String
    let singers: String
    let emotion: String?
    let weather: String?
    
    enum CodingKeys: String, CodingKey {
        case titles, imgs, singers, emotion, weather
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(titles, forKey: .titles)
        try container.encode(imgs, forKey: .imgs)
        try container.encode(singers, forKey: .singers)
        
        // emotions가 nil이면 nil을 유지하고, 값이 있으면 Optional을 제거하고 값을 인코딩합니다.
        if let emotions = emotion {
            try container.encode(emotions, forKey: .emotion)
        } else {
            try container.encodeNil(forKey: .emotion)
        }
        
        // weather에 대해서도 동일하게 처리합니다.
        if let weather = weather {
            try container.encode(weather, forKey: .weather)
        } else {
            try container.encodeNil(forKey: .weather)
        }
    }
}
