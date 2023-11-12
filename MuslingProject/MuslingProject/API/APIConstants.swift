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
    // 일기 저장
    static let saveDiaryURL = baseURL + "/diaries"
}
