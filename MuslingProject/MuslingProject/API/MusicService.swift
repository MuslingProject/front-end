//
//  MusicService.swift
//  MuslingProject
//
//  Created by 이나경 on 12/3/23.
//

import Foundation
import Alamofire

struct MusicService {
    static let shared = MusicService()
    
    // 노래 재추천
    func reRecommend(diaryId: Int64, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        guard let token = UserDefaults.standard.string(forKey: "token") else { return }
        
        let header: HTTPHeaders = [ "Content-Type" : "application/json",
                                    "X-AUTH-TOKEN" : token ]
        
        let url = APIConstants.getDiaryURL + "/\(diaryId)/recommendations"
        
        let dataRequest = AF.request(url, method: .put, headers: header)
        
        dataRequest.responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.value else { return }
                completion(judgeReRecommend(status: statusCode, data: data))
                
            case .failure(let err):
                print(err)
                completion(.networkFail)
            }
        }
    }
    
    // 노래 찜하기
    func saveMusics(musics: [SendMusicModel], completion: @escaping (NetworkResult<Any>) -> (Void)) {
        guard let token = UserDefaults.standard.string(forKey: "token") else { return }

        let params = [
            "likes": musics
        ]
        
        do {
            let jsonData = try JSONEncoder().encode(params)
            var request = URLRequest(url: URL(string: APIConstants.saveMusicURL)!)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-AUTH-TOKEN")
            request.httpBody = jsonData

            AF.request(request).responseData { response in
                switch response.result {
                case .success:
                    guard let statusCode = response.response?.statusCode else { return }
                    guard let data = response.value else { return }
                    completion(judgeSaveMusic(status: statusCode, data: data))
                    
                case .failure(let err):
                    print(err)
                    completion(.networkFail)
                }
            }
        } catch {
            print("Error creating JSON data: \(error)")
        }
    }
    
    // 찜한 노래 조회
    func getSaveMusics(completion: @escaping (NetworkResult<Any>) -> (Void)) {
        guard let token = UserDefaults.standard.string(forKey: "token") else { return }
        
        let header: HTTPHeaders = [ "Content-Type" : "application/json",
                                    "X-AUTH-TOKEN" : token ]
        
        let dataRequest = AF.request(APIConstants.saveMusicURL, method: .get, headers: header)
        
        dataRequest.responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.value else { return }
                completion(judgeGetSaveMusic(status: statusCode, data: data))
                
            case .failure(let err):
                print(err)
                completion(.networkFail)
            }
        }
    }
    
    private func judgeReRecommend(status: Int, data: Data) -> NetworkResult<Any> {
        switch status {
        case 200:
            let decoder = JSONDecoder()
            guard let decodedData = try? decoder.decode(ReRecommendModel.self, from: data) else { return .pathErr }
            return .success(decodedData)
        case 400..<500:
            return .requestErr
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
    
    private func judgeSaveMusic(status: Int, data: Data) -> NetworkResult<Any> {
        switch status {
        case 200:
            let decoder = JSONDecoder()
            guard let decodedData = try? decoder.decode(SaveMusicResponseModel.self, from: data) else { return .pathErr }
            return .success(decodedData)
        case 400..<500:
            return .requestErr
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
    
    private func judgeGetSaveMusic(status: Int, data: Data) -> NetworkResult<Any> {
        switch status {
        case 200:
            let decoder = JSONDecoder()
            guard let decodedData = try? decoder.decode(GetMusicModel.self, from: data) else { return .pathErr }
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
