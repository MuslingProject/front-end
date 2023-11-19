//
//  Category.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/05/23.
//

import UIKit

extension Category {
    static var all = emotion + weather
    static var emotion = ["🥰 기쁨/슬픔", "😢 이별/슬픔", "😡 스트레스/짜증", "😨 불안/멘붕", "😞 우울"]
    static var weather = ["☀️ 맑음", "🌧️ 비/흐림", "🌨️ 눈"]
}
