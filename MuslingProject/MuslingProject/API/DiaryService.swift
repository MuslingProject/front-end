//
//  DiaryService.swift
//  MuslingProject
//
//  Created by 이나경 on 11/8/23.
//

import Foundation
import Alamofire

struct DiaryService {
    static let shared = DiaryService()
    
    func saveDiary(title: String, date: String, weather: String, content: String, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        guard let token = UserDefaults.standard.string(forKey: "token") else { return }
        
        let header: HTTPHeaders = [ "Content-Type" : "application/json",
                                    "X-AUTH-TOKEN" : token ]
        
        let params: Parameters = [
            "title": title,
            "date": date,
            "weather": weather,
            "content": content
        ]
        
        let url = APIConstants.saveDiaryURL
        
        let dataRequest = AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: header)
        
        print(dataRequest)
        
        dataRequest.responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.value else { return }
                completion(judgeSaveDiary(status: statusCode, data: data))

            case .failure(let err):
                print(err)
                completion(.networkFail)
            }
        }
    }
    
    func getDiary(diaryId: Int64, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        guard let token = UserDefaults.standard.string(forKey: "token") else { return }
        
        let header: HTTPHeaders = [ "Content-Type" : "application/json",
                                    "X-AUTH-TOKEN" : token ]
        
        let url = APIConstants.getDiaryURL + "/\(diaryId)"
        
        let dataRequest = AF.request(url, method: .get, headers: header)
        
        dataRequest.responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.value else { return }
                completion(judgeGetOneDiary(status: statusCode, data: data))
                
            case .failure(let err):
                print(err)
                completion(.networkFail)
            }
        }
    }
    
    func deleteDiary(diaryId: Int64, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        guard let token = UserDefaults.standard.string(forKey: "token") else { return }
        
        let header: HTTPHeaders = [ "Content-Type" : "application/json",
                                    "X-AUTH-TOKEN" : token ]
        let url = APIConstants.getDiaryURL + "/\(diaryId)"
        
        let dataRequest = AF.request(url, method: .delete, headers: header)
        
        dataRequest.responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.value else { return }
                completion(judgeDeleteDiary(status: statusCode, data: data))
                
            case .failure(let err):
                print(err)
                completion(.networkFail)
            }
        }
    }
    
    func getDiaries(page: Int, size: Int, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        guard let token = UserDefaults.standard.string(forKey: "token") else { return }
        
        let header: HTTPHeaders = [ "Content-Type" : "application/json",
                                    "X-AUTH-TOKEN" : token ]
        
        let params: [String:Any] = [
            "page": page,
            "size": size,
            "sort": "date,desc"
        ]
        
        let dataRequest = AF.request(APIConstants.getDiaryURL, method: .get, parameters: params, encoding: URLEncoding.default, headers: header)
        
        dataRequest.responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.value else { return }
                completion(judgeGetDiary(status: statusCode, data: data))
                
            case .failure(let err):
                print(err)
                completion(.networkFail)
            }
        }
    }
    
    private func judgeDeleteDiary(status: Int, data: Data) -> NetworkResult<Any> {
        switch status {
        case 200:
            let decoder = JSONDecoder()
            let dateFormatter = DateFormatter()
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
    
    private func judgeSaveDiary(status: Int, data: Data) -> NetworkResult<Any> {
        switch status {
        case 200:
            let decoder = JSONDecoder()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            guard let decodedData = try? decoder.decode(DiaryResponseModel.self, from: data) else { return .pathErr }
            return .success(decodedData)
        case 400..<500:
            return .requestErr
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
    
    private func judgeGetDiary(status: Int, data: Data) -> NetworkResult<Any> {
        switch status {
        case 200:
            let decoder = JSONDecoder()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            guard let decodedData = try? decoder.decode(GetDiaryModel.self, from: data) else { return .pathErr }
            return .success(decodedData)
        case 400..<500:
            return .requestErr
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
    
    private func judgeGetOneDiary(status: Int, data: Data) -> NetworkResult<Any> {
        switch status {
        case 200:
            let decoder = JSONDecoder()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            guard let decodedData = try? decoder.decode(ShowDiaryModel.self, from: data) else { return .pathErr }
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
