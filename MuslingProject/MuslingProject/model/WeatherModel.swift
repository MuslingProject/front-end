//
//  WeatherModel.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/05/30.
//

import Foundation

struct Weather: Codable {
    let temp: Double
    let icon, main: String
}
