//
//  APIConstants.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/07/07.
//

struct APIConstants {
    static let baseURL = "http://54.180.220.34:8080"
    
    // 회원가입 url
    static let userSignUpURL = baseURL + "/users/new-user"
    // 로그인 url
    static let userSignInURL = baseURL + "/users/login"
    // 로그아웃 url
    static let userSignOutURL = baseURL + "/users/logout"
    // 회원 탈퇴 url
    static let unregisterURL = baseURL + "/users"
    // 장르 url
    static let genreURL = baseURL + "/genre"
    // 날씨 불러오기 url
    static let weatherURL = baseURL + "/read/weather"
    // 회원 정보 조회 url
    static let mypageURL = baseURL + "/users"
    // 프로필 사진 수정 url
    static let modifyImageURL = baseURL + "/users/profile"
    // 닉네임 수정 url
    static let modifyNameURL = baseURL + "/users/name"
    // 내 시절 노래 추천 url
    static let modifyRecommendURL = baseURL + "/users/ageRecommendation"
    // 일기 저장
    static let saveDiaryURL = baseURL + "/diaries"
    // 일기 조회
    static let getDiaryURL = baseURL + "/diaries"
    // 찜한 일기 조회
    static let getHeartDiaryURL = baseURL + "/diaries/favorites"
    // 감정 개수 조회
    static let getEmotionURL = baseURL + "/diaries/emotions"
    // 노래 찜하기
    static let saveMusicURL = baseURL + "/songs"
}
