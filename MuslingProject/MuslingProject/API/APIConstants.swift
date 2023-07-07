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
    // 장르 저장 url
    static let genreURL = baseURL + "/create/genre"
    // 날씨 불러오기 url
    static let weatherURL = baseURL + "/read/weather"
}
