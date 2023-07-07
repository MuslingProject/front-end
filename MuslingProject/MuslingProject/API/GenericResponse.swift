//
//  GenericResponse.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/07/07.
//

struct GenericResponse<T: Codable>: Codable {
    var message: String
    var data: T?
    
    enum CodingKeys: String, CodingKey {
        // json은 key, data 값을 갖고 있는데 json의 key값을 swift 타입으로 디코딩할 때 이름이 같아야 해서
        // CodingKeys를 통해 data 변수를 key랑 struct를 이어주는 역할
        case message = "message"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        // 데이터로 들어오는 값이 없을 수도 있을 수도 있기 때문에 먼저 처리
        // 데이터가 없을 때 nil로 처리
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = (try? values.decode(String.self, forKey: .message)) ?? ""
        data = (try? values.decode(T.self, forKey: .data)) ?? nil
    }
}
