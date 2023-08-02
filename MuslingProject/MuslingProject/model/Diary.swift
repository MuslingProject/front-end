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
        Diary(date: "2023-07-01", title: "첫 번째 일기", content: "정부는 예산에 변경을 가할 필요가 있을 때에는 추가경정예산안을 편성하여 국회에 제출할 수 있다. \n\n국회의원이 회기전에 체포 또는 구금된 때에는 현행범인이 아닌 한 국회의 요구가 있으면 회기중 석방된다. 국회의 정기회는 법률이 정하는 바에 의하여 매년 1회 집회되며, 국회의 임시회는 대통령 또는 국회재적의원 4분의 1 이상의 요구에 의하여 집회된다.\n\n대통령이 궐위되거나 사고로 인하여 직무를 수행할 수 없을 때에는 국무총리, 법률이 정한 국무위원의 순서로 그 권한을 대행한다.\n\n법관은 헌법과 법률에 의하여 그 양심에 따라 독립하여 심판한다. 위원은 정당에 가입하거나 정치에 관여할 수 없다. 일반사면을 명하려면 국회의 동의를 얻어야 한다. 국무총리는 국회의 동의를 얻어 대통령이 임명한다. 대법원장과 대법관이 아닌 법관의 임기는 10년으로 하며, 법률이 정하는 바에 의하여 연임할 수 있다.", emotion: "사랑/기쁨", weather: "☀️ 맑았어요"),
        Diary(date: "2023-07-02", title: "두 번째 일기", content: "오늘 맛있는 점심을 먹었다. 돈가스를 먹었는데 너무 맛있었다. 다음에 또 가서 먹고 싶당. 냠냠냠.", emotion: "이별/슬픔", weather: "☁️ 흐렸어요"),
        Diary(date: "2023-07-06", title: "세 번째 일기", content: "오늘 맛있는 점심을 먹었다. 돈가스를 먹었는데 너무 맛있었다. 다음에 또 가서 먹고 싶당. 냠냠냠.", emotion: "우울", weather: "🌧️ 비가 내렸어요"),
        Diary(date: "2023-07-09", title: "네 번째 일기", content: "오늘 맛있는 점심을 먹었다. 돈가스를 먹었는데 너무 맛있었다. 다음에 또 가서 먹고 싶당. 냠냠냠.", emotion: "스트레스/짜증", weather: "❄️ 눈이 내렸어요"),
        Diary(date: "2023-07-11", title: "다섯 번째 일기", content: "오늘 맛있는 점심을 먹었다. 돈가스를 먹었는데 너무 맛있었다. 다음에 또 가서 먹고 싶당. 냠냠냠.", emotion: "멘붕/불안", weather: "☀️ 맑았어요")
    ]
}
