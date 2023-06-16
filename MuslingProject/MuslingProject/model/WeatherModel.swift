//
//  WeatherModel.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/05/30.
//

import Foundation

struct Weather: Codable {
    let temp: Int
    let icon, main: String
}
