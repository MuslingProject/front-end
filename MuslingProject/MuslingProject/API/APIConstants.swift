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
    // 프로필 사진 저장 url
    static let imageSaveURL = baseURL + "/users/new-user/profile"
    // 로그인 url
    static let userSignInURL = baseURL + "/users/login"
    // 회원 탈퇴 url
    static let userSignOutURL = baseURL + "/users/unregister"
    // 장르 저장 url
    static let genreURL = baseURL + "/genre/create"
    // 날씨 불러오기 url
    static let weatherURL = baseURL + "/read/weather"
    // 회원 정보 조회 url
    static let mypageURL = baseURL + "/mypage"
    // 프로필 사진 수정 url
    static let modifyImageURL = baseURL + "/mypage/image"
    // 닉네임 수정 url
    static let modifyNameURL = baseURL + "/mypage/nickname"
    // 장르 수정 url
    static let modifyGenreURL = baseURL + "/mypage/genre"
}
