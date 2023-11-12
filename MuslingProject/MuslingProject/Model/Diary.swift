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
        Diary(date: "2023-11-10", title: "시험 끝!!!", content: "아 드디어 오늘 시험 끝나서 기분이 너무 좋당 얼른 집 가서 푹 쉬고 싶어!", emotion: "사랑/기쁨", weather: "비/흐림"),
        Diary(date: "2023-11-10", title: "왤케 춥지", content: "우어 개추워 날씨가 추워져서 진심 집 가는 길에 오들오들 떨었다...", emotion: "멘붕/불안", weather: "비/흐림"),
        Diary(date: "2023-11-09", title: "오늘 맛있는 거 먹었다", content: "오늘 맛있는 점심을 먹었다. 돈가스를 먹었는데 너무 맛있었다. 다음에 또 가서 먹고 싶당. 냠냠냠.", emotion: "사랑/기쁨", weather: "화창한 날"),
        Diary(date: "2023-11-09", title: "오늘 맛있는 거 먹었다2", content: "오늘 맛있는 점심을 먹었다. 돈가스를 먹었는데 너무 맛있었다. 다음에 또 가서 먹고 싶당. 냠냠냠.", emotion: "사랑/기쁨", weather: "화창한 날"),
        Diary(date: "2023-11-09", title: "오늘 맛있는 거 먹었다3", content: "오늘 맛있는 점심을 먹었다. 돈가스를 먹었는데 너무 맛있었다. 다음에 또 가서 먹고 싶당. 냠냠냠.", emotion: "사랑/기쁨", weather: "화창한 날"),
        Diary(date: "2023-11-08", title: "취업 어떡하지", content: "이제 4학년인데... 곧 졸업인데... 너무 걱정이다... 나 이렇게 살아도 되는 건가? ㅎㅎ...", emotion: "우울", weather: "비/흐림"),
        Diary(date: "2023-11-08", title: "취업 어떡하지2", content: "이제 4학년인데... 곧 졸업인데... 너무 걱정이다... 나 이렇게 살아도 되는 건가? ㅎㅎ...", emotion: "우울", weather: "비/흐림"),
        Diary(date: "2023-11-08", title: "취업 어떡하지3", content: "이제 4학년인데... 곧 졸업인데... 너무 걱정이다... 나 이렇게 살아도 되는 건가? ㅎㅎ...", emotion: "우울", weather: "눈오는 날"),
    ]
}
