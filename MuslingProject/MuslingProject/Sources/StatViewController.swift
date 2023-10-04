//
//  StatViewController.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/06/28.
//

import UIKit
import Charts

class StatViewController: UIViewController {
    
    let day1 = "2023-09-02"
    let day2 = "2023-09-03"
    let day3 = "2023-09-07"
    let day4 = "2023-09-12"
    let day5 = "2023-09-15"

    let cal = Calendar.current

    lazy var days = [getStringToDate(strDate: day1): "기쁨/사랑",  getStringToDate(strDate: day2): "이별/슬픔", getStringToDate(strDate: day3): "우울", getStringToDate(strDate: day4): "스트레스/짜증", getStringToDate(strDate: day5): "멘붕/불안"]

    // 달력 선언
    lazy var calendarView: UICalendarView = {
        let view = UICalendarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.wantsDateDecorations = true
        view.tintColor = UIColor.secondary!

        return view
    }()

    var selectedDate: DateComponents? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)

        calendarView.delegate = self

        applyConstraints()
        setCalendar()
        reloadDateView(date: Date())
    }

    fileprivate func setCalendar() {
        calendarView.delegate = self

        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
        calendarView.selectionBehavior = dateSelection
    }

    fileprivate func applyConstraints() {
        view.addSubview(calendarView)

        let calendarViewConstraints = [
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            calendarView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30)
        ]

        NSLayoutConstraint.activate(calendarViewConstraints)
    }

    func reloadDateView(date: Date?) {
        if date == nil { return }
        let calendar = Calendar.current
        calendarView.reloadDecorations(forDateComponents: [calendar.dateComponents([.day, .month, .year], from: date!)], animated: true)
    }

    // 문자열 -> Date 형변환 함수
    func getStringToDate(strDate: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = NSTimeZone(name: "Ko_KR") as TimeZone?

        return dateFormatter.date(from: strDate)!
    }


    // navigation bar 배경, 타이틀, item 색상 변경
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .primary

        if let customFont = UIFont(name: "Pretendard-Bold", size: 24) {
            appearance.largeTitleTextAttributes = [
                .font: customFont,
                .foregroundColor: UIColor.white
            ]
        } else {
            print("폰트를 로드할 수 없습니다.")
        }

        if let customFont2 = UIFont(name: "Pretendard-Bold", size: 15) {
            appearance.titleTextAttributes = [
                .font: customFont2,
                .foregroundColor: UIColor.white
            ]
        } else {
            print("폰트를 로드할 수 없습니다.")
        }

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        navigationController?.navigationBar.tintColor = .white

        // navigation bar 그림자 효과
        navigationController?.navigationBar.layer.masksToBounds = false
        navigationController?.navigationBar.layer.shadowColor = UIColor.primary?.cgColor
        navigationController?.navigationBar.layer.shadowOpacity = 0.8
        navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2)
        navigationController?.navigationBar.layer.shadowRadius = 2
    }

}

extension StatViewController: UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {

    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        selection.setSelected(dateComponents, animated: true)
        selectedDate = dateComponents
        reloadDateView(date: Calendar.current.date(from: dateComponents!))
    }

    // 캘린더에 감정 라벨링
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {

        let date = dateComponents.date!

        if days.keys.contains(date) {
            switch days[date] {
            case "기쁨/사랑":
                return .customView {
                    let label = UILabel()
                    label.text = "🥰"
                    label.font = UIFont.systemFont(ofSize: 15)
                    label.textAlignment = .center
                    return label
                }
            case "이별/슬픔":
                return .customView {
                    let label = UILabel()
                    label.text = "😢"
                    label.font = UIFont.systemFont(ofSize: 15)
                    label.textAlignment = .center
                    return label
                }
            case "우울":
                return .customView {
                    let label = UILabel()
                    label.text = "🫠"
                    label.font = UIFont.systemFont(ofSize: 15)
                    label.textAlignment = .center
                    return label
                }
            case "멘붕/불안":
                return .customView {
                    let label = UILabel()
                    label.text = "🤯"
                    label.font = UIFont.systemFont(ofSize: 15)
                    label.textAlignment = .center
                    return label
                }
            case "스트레스/짜증":
                return .customView {
                    let label = UILabel()
                    label.text = "😡"
                    label.font = UIFont.systemFont(ofSize: 15)
                    label.textAlignment = .center
                    return label
                }
            default:
                return nil
            }
        } else {
            return nil
        }
    }
}
