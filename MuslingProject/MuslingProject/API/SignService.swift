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
    
    // 일반 로그인
    func signIn(userId: String, pwd: String, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        let url = APIConstants.userSignInURL // 로그인 url
        let header: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        let body: Parameters = [
            "email": userId,
            "pwd": pwd
        ]
        
        // 원하는 형식의 http request 생성
        let dataRequest = AF.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header)
        
        // 데이터 통신 시작
        dataRequest.responseData { response in
            // 통신 결과에 대한 분기 처리
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.value else { return }
                
                // completion이란 클로저에게 전달할 데이터를 judgeSignInData 함수 통해 결정
                completion(judgeSignData(status: statusCode, data: data))
            case .failure(let err):
                print(err)
                completion(.networkFail)
            }
        }
    }
    
//    func signUp(userId: String, pwd: String, name: String, age: String, profileId: String, completion: @escaping (NetworkResult<Any>) -> (Void)) {
//        let url = APIConstants.userSignUpURL
//        let header: HTTPHeaders = [ "Content-Type" : "application/json" ]
//        let params: Parameters = [
//            "userId": userId,
//            "pwd": pwd,
//            "name": name,
//            "age": age,
//            "profileId": profileId
//        ]
//
//        let dataRequest = AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: header)
//
//        dataRequest.responseData { response in
//            switch response.result {
//            case .success:
//                guard let statusCode = response.response?.statusCode else { return }
//                guard let data = response.value else { return }
//                completion(judgeSignData(status: statusCode, data: data))
//
//            case .failure(let err):
//                print(err)
//                completion(.networkFail)
//            }
//        }
//    }
    
    func signUp(member: Member, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        let header: HTTPHeaders = [ "Content-Type": "multipart/form-data" ]
        
        let dataRequest = AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(Data(member.user_id.utf8), withName: "email")
            multipartFormData.append(Data(member.pwd.utf8), withName: "pwd")
            multipartFormData.append(Data(member.name.utf8), withName: "name")
            multipartFormData.append(Data(member.age.utf8), withName: "age")
            // 이미지 추가 (이미지가 비어 있을 경우 고려)
            if let image = member.img.jpegData(compressionQuality: 0.7) {
                multipartFormData.append(image, withName: "file", fileName: "\(image).jpg", mimeType: "image/jpeg")
            }
        }, to: APIConstants.userSignUpURL, method: .post, headers: header)
        
        dataRequest.responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.value else { return }
                
                completion(judgeSignData(status: statusCode, data: data))
            case .failure(let err):
                print(err)
                completion(.networkFail)
            }
        }
    }
    
    // 이미지 저장 함수
//    func saveImage(imgData: UIImage!, completion: @escaping (NetworkResult<Any>) -> (Void)) {
//        let header: HTTPHeaders = [ "Content-Type": "multipart/form-data" ]
//
//        let dataRequest = AF.upload(multipartFormData: { multipartFormData in
//            // 이미지 추가 (이미지가 비어 있을 경우 고려)
//            if let image = imgData.jpegData(compressionQuality: 0.7) {
//                multipartFormData.append(image, withName: "image", fileName: "\(image).jpg", mimeType: "image/jpeg")
//            } else { }
//        }, to: APIConstants.imageSaveURL, method: .post, headers: header)
//
//        dataRequest.responseData { response in
//            switch response.result {
//            case .success:
//                guard let statusCode = response.response?.statusCode else { return }
//                guard let data = response.value else { return }
//
//                completion(judgeSaveImage(status: statusCode, data: data))
//            case .failure(let err):
//                print(err)
//                completion(.networkFail)
//            }
//        }
//    }
    
    // 회원 탈퇴 함수
    func register(userId: String, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        let baseURL = APIConstants.unregisterURL
        let deleteURL = baseURL + "/\(userId)"
        
        let dataRequest = AF.request(deleteURL, method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: nil)
        
        dataRequest.responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.value else { return }
                completion(judgeRegisterData(status: statusCode, data: data))
            case .failure(let err):
                print(err)
                completion(.networkFail)
            }
        }
    }
    
    // 장르 저장 함수
    func saveGenre(indie: Bool, balad: Bool, rockMetal: Bool, dancePop: Bool, rapHiphop: Bool, rbSoul: Bool, forkAcoustic: Bool, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        guard let token = UserDefaults.standard.string(forKey: "token") else { return }
        
        let header: HTTPHeaders = [ "Content-Type" : "application/json",
                                    "X-AUTH-TOKEN" : token ]
        let params: Parameters = [
            "indie": indie,
            "balad": balad,
            "rockMetal": rockMetal,
            "dancePop": dancePop,
            "rapHiphop": rapHiphop,
            "rbSoul": rbSoul,
            "forkAcoustic": forkAcoustic
        ]
        
        print("장르 파라미터 :: \(params)")
        
        let url = APIConstants.genreURL
        
        let dataRequest = AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: header)
        
        dataRequest.responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.value else { return }
                completion(judgeSaveGenre(status: statusCode, data: data))

            case .failure(let err):
                print(err)
                completion(.networkFail)
            }
        }
    
    }
    
    // statusCode와 decode 결과에 따라 NetworkResult 반환
    private func judgeSignData(status: Int, data: Data) -> NetworkResult<Any> {
        switch status {
        case 200:
            let decoder = JSONDecoder()
            guard let decodedData = try? decoder.decode(DataModel.self, from: data) else { return .pathErr }
            return .success(decodedData)
        case 400..<500:
            return .requestErr
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
    
    private func judgeRegisterData(status: Int, data: Data) -> NetworkResult<Any> {
        switch status {
        case 200:
            let decoder = JSONDecoder()
            guard let decodedData = try? decoder.decode(DataModel.self, from: data) else { return .pathErr }
            return .success(decodedData)
        case 400..<500:
            return .requestErr
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
    
    private func judgeSaveGenre(status: Int, data: Data) -> NetworkResult<Any> {
        // 통신을 통해 전달받은 데이터를 decode
        switch status {
        case 200:
            let decoder = JSONDecoder()
            guard let decodedData = try? decoder.decode(GenreModel.self, from: data) else { return .pathErr }
            return .success(decodedData)
        case 400..<500:
            return .requestErr
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
}
