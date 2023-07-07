//
//  SignService.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/07/07.
//

import Foundation
import Alamofire

struct SignService {
    static let shared = SignService()
    
    // 로그인 통신에 대한 함수 정의
    // closure을 함수의 파라미터로 받음
    // @escaping - 탈출 클로저
    func signIn(user_id: String, pwd: String, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        let url = APIConstants.userSignInURL // 로그인 url
        let header: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        let body: Parameters = [
            "user_id": user_id,
            "pwd": pwd
        ]
        
        // 원하는 형식의 http request 생성
        let dataRequest = AF.request(url, method: .post, parameters: body, encoding: URLEncoding.default, headers: header)
        
        // 데이터 통신 시작
        dataRequest.responseData { (response) in
            // 통신 결과에 대한 분기 처리
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else {
                    return
                }
                guard let data = response.value else {
                    return
                }
                // completion이란 클로저에게 전달할 데이터를 judgeSignInData 함수 통해 결정
                completion(judgeSignInData(status: statusCode, data: data))
            case .failure(let err):
                print(err)
                completion(.networkFail)
            }
        }
    }
    
    func signUp (userId: String, pwd: String, name: String, age: String, imgData: UIImage?, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        // 헤더 작성 (Content-type 지정)
        let header: HTTPHeaders = [ "Content-Type" : "multipart/form-data" ]
        
        // 파라미터
        let params: Parameters = [
            "user_id": userId,
            "pwd": pwd,
            "name": name,
            "age": age
        ]
        
        print("파라미터 : \(params)")
        
        let dataRequest = AF.upload(multipartFormData: { MultipartFormData in
            for (key, value) in params {
            MultipartFormData.append("\(value)".data(using: .utf8, allowLossyConversion: false)!, withName: key)
                print("추가: \(value)")
        }
            // 이미지 추가 (이미지가 비어 있을 경우 고려)
            if let image = imgData?.jpegData(compressionQuality: 1) {
                MultipartFormData.append(image, withName: "img", fileName: "\(name).jpg", mimeType: "image/jpg")
            }
        }, to: APIConstants.userSignUpURL, usingThreshold: UInt64.init(), method: .post, headers: header)
        
        dataRequest.responseData { (response) in
            // 통신 결과에 대한 분기 처리
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else {
                    return
                }
                guard let data = response.value else {
                    return
                }
                // completion이란 클로저에게 전달할 데이터를 judgeSignInData 함수 통해 결정
                completion(judgeSignUpData(status: statusCode, data: data))
            case .failure(let err):
                print(err)
                completion(.networkFail)
            }
        }
    }
    
    // statusCode와 decode 결과에 따라 NetworkResult 반환
    private func judgeSignInData(status: Int, data: Data) -> NetworkResult<Any> {
        switch status {
        case 200:
            return .success("로그인 성공")
        case 400..<500:
            return .requestErr("요청 오류")
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
    
    private func judgeSignUpData(status: Int, data: Data) -> NetworkResult<Any> {
        switch status {
        case 200:
            return .success("회원가입 성공")
        case 400..<500:
            return .requestErr("요청 오류")
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
}
