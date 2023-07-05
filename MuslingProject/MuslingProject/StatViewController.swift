//
//  StatViewController.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/06/28.
//

import UIKit

class StatViewController: UIViewController {
    
    @IBOutlet var scrollView: UIView!
    
    let day1 = "2023-07-02"
    let day2 = "2023-07-03"
    let day3 = "2023-07-30"
    
    let cal = Calendar.current
    
    lazy var days = [ getStringToDate(strDate: day1) : "기쁨/사랑",  getStringToDate(strDate: day2) : "이별/슬픔", getStringToDate(strDate: day3) : "우울" ]
    
    // 달력 선언
    lazy var calendarView: UICalendarView = {
        let view = UICalendarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.wantsDateDecorations = true
        
        return view
    }()
    
    // 감정 개수 타이틀
    lazy var statTitle: UILabel = {
        let label = UILabel()
        label.text = "✍️ 이번 달 감정 통계"
        label.textColor = .secondary
        label.font = .systemFont(ofSize: 25, weight: .semibold)
        
        return label
    }()
    
    fileprivate func TitleConstraints() {
        view.addSubview(statTitle)
        
        statTitle.translatesAutoresizingMaskIntoConstraints = false
        
        let titleViewConstraints = [
            statTitle.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            statTitle.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 30),
        ]
        
        NSLayoutConstraint.activate(titleViewConstraints)
    }
    
    // 이모지 설명 레이블
    lazy var emojiLabel: UILabel = {
        let label = UILabel()
        label.text = "🥰 기분 좋은 날이 14일 있었어요\n😢 슬픈 날이 3일 있었어요\n🫠 우울한 날이 5일 있었어요\n🤯 불안한 날이 2일 있었어요\n😡 짜증나는 날이 1일 있었어요"
        label.numberOfLines = 5
        
        // 행간 조절
        let attrStirng = NSMutableAttributedString(string: label.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10
        attrStirng.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrStirng.length))
        label.attributedText = attrStirng
        
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        
        return label
    }()
    
    fileprivate func LabelConstraints() {
        view.addSubview(emojiLabel)
    
        emojiLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let labelViewConstraints = [
            emojiLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            emojiLabel.topAnchor.constraint(equalTo: statTitle.bottomAnchor, constant: 15)
        ]
        
        NSLayoutConstraint.activate(labelViewConstraints)
    }
    
    var selectedDate: DateComponents? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendarView.delegate = self
        
        applyConstraints()
        setCalendar()
        reloadDateView(date: Date())
        
        TitleConstraints()
        
        // 달력 아래에 레이블 추가
        LabelConstraints()
    }
    
    fileprivate func setCalendar() {
        calendarView.delegate = self
        
        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
        calendarView.selectionBehavior = dateSelection
    }
    
    fileprivate func applyConstraints() {
        view.addSubview(calendarView)
        
        let calendarViewConstraints = [
            calendarView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            calendarView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10)
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
        appearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
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
