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
    func signIn(userId: String, pwd: String, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        let url = APIConstants.userSignInURL // 로그인 url
        let header: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        let body: Parameters = [
            "userId": userId,
            "pwd": pwd
        ]
        
        // 원하는 형식의 http request 생성
        let dataRequest = AF.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header)
        
        // 데이터 통신 시작
        dataRequest.responseData { (response) in
            // 통신 결과에 대한 분기 처리
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.value else { return }
                
                // completion이란 클로저에게 전달할 데이터를 judgeSignInData 함수 통해 결정
                completion(judgeSignInData(status: statusCode, data: data))
            case .failure(let err):
                print(err)
                completion(.networkFail)
            }
        }
    }
    
    func signUp(userId: String, pwd: String, name: String, age: String, profileId: String, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        let url = APIConstants.userSignUpURL
        let header: HTTPHeaders = [ "Content-Type" : "application/json" ]
        let params: Parameters = [
            "userId": userId,
            "pwd": pwd,
            "name": name,
            "age": age,
            "profileId": profileId
        ]
        
        let dataRequest = AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: header)

        dataRequest.responseData { (response) in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.value else { return }
                completion(judgeSignUpData(status: statusCode, data: data))

            case .failure(let err):
                print(err)
                completion(.networkFail)
            }
        }
    }
    
    // 이미지 저장 함수
    func saveImage(imgData: UIImage!, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        let header: HTTPHeaders = [ "Content-Type": "multipart/form-data" ]
        
        let dataRequest = AF.upload(multipartFormData: { multipartFormData in
            // 이미지 추가 (이미지가 비어 있을 경우 고려)
            if let image = imgData.jpegData(compressionQuality: 0.7) {
                multipartFormData.append(image, withName: "image", fileName: "\(image).jpg", mimeType: "image/jpeg")
            } else { }
        }, to: APIConstants.imageSaveURL, method: .post, headers: header)
        
        dataRequest.responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.value else { return }
                
                completion(judgeSaveImage(status: statusCode, data: data))
            case .failure(let err):
                print(err)
                completion(.networkFail)
            }
        }
    }
    
    // 장르 저장 함수
    func saveGenre() {
        guard let token = UserDefaults.standard.string(forKey: "token") else { return }
        
        print("저장돼 있는 토큰 :: \(token)")
        
        let header: HTTPHeaders = [ "X-AUTH-TOKEN" : token ]
        let params: Parameters = [
            "indie": Genre.shared.indie ?? false,
            "balad": Genre.shared.balad ?? false,
            "rockMetal": Genre.shared.rockMetal ?? false,
            "dancePop": Genre.shared.dancePop ?? false,
            "rapHiphop": Genre.shared.rapHiphop ?? false,
            "rbSoul": Genre.shared.rbSoul ?? false,
            "forkAcoustic": Genre.shared.forkAcoustic ?? false
        ]
        
        AF.request(APIConstants.genreURL,
                   method: .post,
                   parameters: params,
                   encoding: JSONEncoding.default,
                   headers: header)
        .validate(statusCode: 200 ..< 299).responseData { response in
            switch response.result {
            case .success(let data):
                guard let decodedData = try? JSONDecoder().decode(TokenModel.self, from: data) else { return }
                print(decodedData.message)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // statusCode와 decode 결과에 따라 NetworkResult 반환
    private func judgeSignInData(status: Int, data: Data) -> NetworkResult<Any> {
        switch status {
        case 200:
            let decoder = JSONDecoder()
            guard let decodedData = try? decoder.decode(TokenModel.self, from: data) else { return .pathErr }
            return .success(decodedData)
        case 400..<500:
            return .requestErr
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
    
    private func judgeSignUpData(status: Int, data: Data) -> NetworkResult<Any> {
        // 통신을 통해 전달받은 데이터를 decode
        switch status {
        case 200:
            let decoder = JSONDecoder()
            guard let decodedData = try? decoder.decode(TokenModel.self, from: data) else { return .pathErr }
            return .success(decodedData)
        case 400..<500:
            return .requestErr
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
    
    private func judgeSaveImage(status: Int, data: Data) -> NetworkResult<Any> {
        // 통신을 통해 전달받은 데이터를 decode
        switch status {
        case 200:
            let decoder = JSONDecoder()
            guard let decodedData = try? decoder.decode(ImageModel.self, from: data) else { return .pathErr }
            Member.shared.profileId = String(decodedData.data)
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
