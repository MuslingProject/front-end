//
//  MypageService.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/08/13.
//

import Foundation
import Alamofire

struct MypageService {
    static let shared = MypageService()
    
    // 마이페이지 관련 통신 함수 정의
    // 회원 정보 조회
    func getMypage(completion: @escaping (NetworkResult<Any>) -> (Void)) {
        guard let token = UserDefaults.standard.string(forKey: "token") else { return }
        
        let header: HTTPHeaders = [ "Content-Type" : "application/json",
                                    "X-AUTH-TOKEN" : token ]
        
        let dataRequest = AF.request(APIConstants.mypageURL, method: .get, headers: header)
        
        dataRequest.responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.value else { return }
                completion(judgeGetMypage(status: statusCode, data: data))
                
            case .failure(let err):
                print(err)
                completion(.networkFail)
            }
        }
    }
    
    // 프로필 사진 수정
    func modifyImage(imgData: UIImage!, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        guard let token = UserDefaults.standard.string(forKey: "token") else { return }
        
        let header: HTTPHeaders = [ "Content-Type": "multipart/form-data",
                                    "X-AUTH-TOKEN" : token ]
        
        let dataRequest = AF.upload(multipartFormData: { multipartFormData in
            // 이미지 추가 (이미지가 비어 있을 경우 고려)
            if let image = imgData.jpegData(compressionQuality: 0.7) {
                multipartFormData.append(image, withName: "image", fileName: "\(image).jpg", mimeType: "image/jpeg")
            } else { }
        }, to: APIConstants.modifyImageURL, method: .patch, headers: header)
        
        dataRequest.responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.value else { return }
                completion(judgeImageModify(status: statusCode, data: data))
            case .failure(let err):
                print(err)
                completion(.networkFail)
            }
        }
    }
    
    // 닉네임 수정
    func modifyName(nickname: String, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        guard let token = UserDefaults.standard.string(forKey: "token") else { return }
        
        let header: HTTPHeaders = [ "Content-Type": "text/plain",
                                    "X-AUTH-TOKEN": token ]
        
        let encoding = PlainStringEncoding(body: nickname)
        
        let dataRequest = AF.request(APIConstants.modifyNameURL, method: .patch, parameters: nil, encoding: encoding, headers: header)
        
        dataRequest.responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.value else { return }
                completion(judgeNameModify(status: statusCode, data: data))
                
            case .failure(let err):
                print(err)
                completion(.networkFail)
            }
        }
    }
    
    // 선호 장르 수정
    func modifyGenre(indie: Bool, balad: Bool, rockMetal: Bool, dancePop: Bool, rapHiphop: Bool, rbSoul: Bool, forkAcoustic: Bool, completion: @escaping (NetworkResult<Any>) -> (Void)) {
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
        
        let dataRequest = AF.request(APIConstants.genreURL, method: .patch, parameters: params, encoding: JSONEncoding.default, headers: header)
        
        dataRequest.responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.value else { return }
                completion(judgeGenreData(status: statusCode, data: data))
                
            case .failure(let err):
                print(err)
                completion(.networkFail)
            }
        }
    }
    
    // 선호 장르 조회
    func showGenre(completion: @escaping (NetworkResult<Any>) -> (Void)) {
        guard let token = UserDefaults.standard.string(forKey: "token") else { return }
        
        let header: HTTPHeaders = [ "X-AUTH-TOKEN" : token ]
        
        let dataRequest = AF.request(APIConstants.genreURL, method: .get, encoding: JSONEncoding.default, headers: header)
        
        dataRequest.responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.value else { return }
                completion(judgeGenreData(status: statusCode, data: data))
                
            case .failure(let err):
                print(err)
                completion(.networkFail)
            }
        }
        
    }
    
    private func judgeGetMypage(status: Int, data: Data) -> NetworkResult<Any> {
        switch status {
        case 200:
            let decoder = JSONDecoder()
            guard let decodedData = try? decoder.decode(MypageModel.self, from: data) else { return .pathErr }
            return .success(decodedData)
        case 400..<500:
            return .requestErr
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
    
    private func judgeGenreData(status: Int, data: Data) -> NetworkResult<Any> {
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
    
    private func judgeNameModify(status: Int, data: Data) -> NetworkResult<Any> {
        switch status {
        case 200:
            let decoder = JSONDecoder()
            guard let decodedData = try? decoder.decode(NameModifyModel.self, from: data) else { return .pathErr }
            return .success(decodedData)
        case 400..<500:
            return .requestErr
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
    
    private func judgeImageModify(status: Int, data: Data) -> NetworkResult<Any> {
        switch status {
        case 200:
            let decoder = JSONDecoder()
            guard let decodedData = try? decoder.decode(NonDataModel.self, from: data) else { return .pathErr }
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

struct PlainStringEncoding: ParameterEncoding {
    private let body: String

    init(body: String) {
        self.body = body
    }

    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try urlRequest.asURLRequest()
        request.httpBody = body.data(using: .utf8)
        return request
    }
}
