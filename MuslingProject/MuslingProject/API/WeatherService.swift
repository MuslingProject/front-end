//
//  WeatherService.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/07/07.
//

import Foundation
import Alamofire

struct WeatherService {
    static let shared = WeatherService()
    
    func getWeather(lat: Double, lon: Double, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        let url = APIConstants.weatherURL // 날씨 불러오기 url
        let header: HTTPHeaders = [ "Content-Type" : "application/json" ]
        let params: Parameters = [
            "lat": lat,
            "lon": lon
        ]
        
        let dataRequest = AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: header)
        
        print("파라미터: \(params)")
        
        dataRequest.validate(statusCode: 200..<299).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.value else { return }
                print(data)
                completion(judgeWeatherData(status: statusCode, data: data))
            case .failure(let err):
                print(err)
                completion(.networkFail)
            }
        }
        
//        dataRequest.responseData { (response) in
//            switch response.result {
//            case .success:
//                guard let statusCode = response.response?.statusCode else { return }
//                guard let data = response.value else { return }
//                print(data)
//                completion(judgeWeatherData(status: statusCode, data: data))
//
//            case .failure(let err):
//                print(err)
//                completion(.networkFail)
//            }
//        }
    }
    
    // statusCode와 decode 결과에 따라 NetworkResult 반환
    private func judgeWeatherData(status: Int, data: Data) -> NetworkResult<Any> {
        // 통신을 통해 전달받은 데이터를 decode
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(
            WeatherData.self, from: data) else {
            return .pathErr
        }
        print("반환 :: \(decodedData)")
        // statusCode를 통해 통신 결과를 알 수 있음
        switch status {
        case 200:
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
