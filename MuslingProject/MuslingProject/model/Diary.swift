//
//  Diary.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/07/11.
//

import Foundation

struct Diary {
    let date: String
    let title: String
    let content: String
    let emotion: String
    let weather: String
}

extension Diary {
    static var data = [
        Diary(date: "2023-07-01", title: "첫 번째 일기", content: "오늘 맛있는 점심을 먹었다. 돈가스를 먹었는데 너무 맛있었다. 다음에 또 가서 먹고 싶당. 냠냠냠.", emotion: "사랑/기쁨", weather: "☀️ 맑았어요"),
        Diary(date: "2023-07-02", title: "두 번째 일기", content: "오늘 맛있는 점심을 먹었다. 돈가스를 먹었는데 너무 맛있었다. 다음에 또 가서 먹고 싶당. 냠냠냠.", emotion: "이별/슬픔", weather: "☁️ 흐렸어요"),
        Diary(date: "2023-07-06", title: "세 번째 일기", content: "오늘 맛있는 점심을 먹었다. 돈가스를 먹었는데 너무 맛있었다. 다음에 또 가서 먹고 싶당. 냠냠냠.", emotion: "우울", weather: "🌧️ 비가 내렸어요"),
        Diary(date: "2023-07-09", title: "네 번째 일기", content: "오늘 맛있는 점심을 먹었다. 돈가스를 먹었는데 너무 맛있었다. 다음에 또 가서 먹고 싶당. 냠냠냠.", emotion: "스트레스/짜증", weather: "❄️ 눈이 내렸어요"),
        Diary(date: "2023-07-11", title: "다섯 번째 일기", content: "오늘 맛있는 점심을 먹었다. 돈가스를 먹었는데 너무 맛있었다. 다음에 또 가서 먹고 싶당. 냠냠냠.", emotion: "멘붕/불안", weather: "☀️ 맑았어요")
    ]
}
