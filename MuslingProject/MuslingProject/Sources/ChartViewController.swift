//
//  ChartViewController.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/09/27.
//

import UIKit
import Charts

class ChartViewController: UIViewController {
    
    var sv: UIView?
        
    @IBOutlet var chart: BarChartView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var script1: UILabel!
    @IBOutlet var moodScript: UILabel!
    @IBOutlet var muslingScript: UILabel!
    @IBOutlet var reportLabel: UILabel!
    
    var counts: [Int] = []
    var emotions = ["🥰", "😢", "😞", "😨", "😡"]
    var nickname: String = ""
    
    func setChart(dataPoints: [String], values: [Int]) {
        // 데이터 생성
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(values[i]))
            dataEntries.append(dataEntry)
        }
        
        // 데이터 삽입
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "")
        chartDataSet.valueFont = UIFont(name: "Pretendard-Regular", size: 12)!
        chartDataSet.colors = [.blue01!] // 차트 컬러
        
        let chartData = BarChartData(dataSet: chartDataSet)
        chart.data = chartData
        
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0

        let valueFormatter = DefaultValueFormatter(formatter: formatter)
        chartData.setValueFormatter(valueFormatter)
        
        chartData.setValueTextColor(UIColor.text02!)
        chartData.setValueFont(UIFont(name: "Pretendard-Regular", size: 13)!)
        chartData.barWidth = 0.4 // 바 굵기 설정
        
        // 선택, 줌, 드래그 안 되도록
        chart.highlightPerTapEnabled = false
        chart.doubleTapToZoomEnabled = false
        chart.dragEnabled = false
        
        chart.xAxis.labelPosition = .bottom
        chart.xAxis.valueFormatter = IndexAxisValueFormatter(values: emotions)
        chart.xAxis.setLabelCount(dataPoints.count, force: false)
        
        chart.rightAxis.enabled = false
        chart.leftAxis.enabled = false
        
        // x축 세로선 제거
        chart.xAxis.drawGridLinesEnabled = false
        chart.xAxis.drawAxisLineEnabled = false
        chart.xAxis.labelRotatedHeight = 15.0 // 하단 범례 잘리지 않도록 설정해 주기
        chart.xAxis.labelFont = UIFont(name: "Pretendard-Regular", size: 12)!
        
        // 하단의 범례 제거
        chart.legend.enabled = false
        chart.animate(xAxisDuration: 1.0, yAxisDuration: 1.0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 데이터가 없을 때
        chart.noDataText = "🥲 아직 기록 데이터가 없어요"
        chart.noDataFont = UIFont(name: "Pretendard-Regular", size: 13)!
        chart.noDataTextColor = .lightGray
        
        script1.attributedText = NSAttributedString(string: "지금까지 가장 많이 나타난 감정은...", attributes: [NSAttributedString.Key.kern: -1, NSAttributedString.Key.font: UIFont(name: "Pretendard-Medium", size: 15)!])
        
    }
    
    private func getData() {
        if let name = UserDefaults.standard.string(forKey: "user_name") {
            titleLabel.attributedText = NSAttributedString(string: "\(name) 님의\n감정 그래프를 보여드릴게요 👀", attributes: [NSAttributedString.Key.font: UIFont(name: "Pretendard-ExtraBold", size: 26)!, NSAttributedString.Key.kern: -2.34])
            nickname = name
            self.getEmotions()
        } else {
            MypageService.shared.getMypage() { response in
                switch response {
                case .success(let data):
                    if let data = data as? MypageModel {
                        print("회원 정보 불러오기 결과 :: \(data.result)")
                        UserDefaults.standard.setValue(data.data.name, forKey: "user_name")
                        self.titleLabel.attributedText = NSAttributedString(string: "\(data.data.name) 님의\n감정 그래프를 보여드릴게요 👀", attributes: [NSAttributedString.Key.font: UIFont(name: "Pretendard-ExtraBold", size: 26)!, NSAttributedString.Key.kern: -2.34])
                        self.nickname = data.data.name
                        self.getEmotions()
                        }
                    
                case .pathErr:
                    print("회원 정보 불러오기 결과 :: Path Err")
                case .requestErr:
                    print("회원 정보 불러오기 결과 :: Request Err")
                case .serverErr:
                    print("회원 정보 불러오기 결과 :: Server Err")
                case .networkFail:
                    print("회원 정보 불러오기 결과 :: Network Fail")
                }
            }
        }
    }
    
    private func getEmotions() {
        // 감정 개수 세는 api 실행 및 차트에 데이터 적용
        DiaryService.shared.getEmotions() { response in
            switch response {
            case .success(let data):
                if let data = data as? EmotionModel {
                    print("감정 개수 세기 결과 :: \(data.result)")
                    
                    self.counts.removeAll()
                    
                    let emotionCounts = data.data.emotionCounts
                    
                    self.counts.append(emotionCounts.happy)
                    self.counts.append(emotionCounts.sad)
                    self.counts.append(emotionCounts.depressed)
                    self.counts.append(emotionCounts.unrest)
                    self.counts.append(emotionCounts.stress)
                    
                    if self.counts.allSatisfy({ $0 == 0 }) {
                        // 모든 값이 0이면
                        self.moodScript.isHidden = true
                        self.muslingScript.isHidden = true
                        self.script1.isHidden = true
                        self.reportLabel.isHidden = true
                    } else {
                        self.moodScript.isHidden = false
                        self.muslingScript.isHidden = false
                        self.script1.isHidden = false
                        self.reportLabel.isHidden = false
                        
                        self.setChart(dataPoints: self.emotions, values: self.counts)
                        
                        let mostEmotion = data.data.mostFrequentEmotion
                        
                        switch mostEmotion {
                        case "happy":
                            self.moodScript.attributedText = NSAttributedString(string: "사랑/기쁨이에요 😘 ", attributes: [NSAttributedString.Key.kern: -1, NSAttributedString.Key.font: UIFont(name: "Pretendard-Bold", size: 16)!])
                            self.muslingScript.attributedText = NSAttributedString(string: "앞으로도 \(self.nickname) 님에게 사랑스럽고 기쁜 나날들이\n계속되길 바랄게요. 오늘도 좋은 하루 보내요! ☺️ ", attributes: [NSAttributedString.Key.kern: -1,  NSAttributedString.Key.font: UIFont(name: "Pretendard-Medium", size: 15)!])
                        case "sad":
                            self.moodScript.attributedText = NSAttributedString(string: "이별/슬픔이에요 😢 ", attributes: [NSAttributedString.Key.kern: -1, NSAttributedString.Key.font: UIFont(name: "Pretendard-Bold", size: 16)!])
                            self.muslingScript.attributedText = NSAttributedString(string: "앞으로는 \(self.nickname) 님에게 행복한 일들이 계속될 거예요.\n뮤즐링이 응원할게요! 💪 ", attributes: [NSAttributedString.Key.kern: -1,  NSAttributedString.Key.font: UIFont(name: "Pretendard-Medium", size: 15)!])
                        case "depressed":
                            self.moodScript.attributedText = NSAttributedString(string: "우울이에요 😞 ", attributes: [NSAttributedString.Key.kern: -1, NSAttributedString.Key.font: UIFont(name: "Pretendard-Bold", size: 16)!])
                            self.muslingScript.attributedText = NSAttributedString(string: "\(self.nickname) 님! 맛있는 거 먹으면서 텐션 업 해 봐요.\n뮤즐링이 항상 곁에 있을게요. 😚 ", attributes: [NSAttributedString.Key.kern: -1,  NSAttributedString.Key.font: UIFont(name: "Pretendard-Medium", size: 15)!])
                        case "unrest":
                            self.moodScript.attributedText = NSAttributedString(string: "불안/멘붕이에요 😰 ", attributes: [NSAttributedString.Key.kern: -1, NSAttributedString.Key.font: UIFont(name: "Pretendard-Bold", size: 16)!])
                            self.muslingScript.attributedText = NSAttributedString(string: "\(self.nickname) 님 불안해 하지 말아요.\n모든 게 다 잘 될 거예요! 🙂 ", attributes: [NSAttributedString.Key.kern: -1,  NSAttributedString.Key.font: UIFont(name: "Pretendard-Medium", size: 15)!])
                        case "stress":
                            self.moodScript.attributedText = NSAttributedString(string: "스트레스/짜증이에요 😤 ", attributes: [NSAttributedString.Key.kern: -1, NSAttributedString.Key.font: UIFont(name: "Pretendard-Bold", size: 16)!])
                            self.muslingScript.attributedText = NSAttributedString(string: "짜증날 때는 숨을 크게 내쉬어봐요.\n\(self.nickname) 님의 감정이 진정될 거예요. 🙂 ", attributes: [NSAttributedString.Key.kern: -1,  NSAttributedString.Key.font: UIFont(name: "Pretendard-Medium", size: 15)!])
                        default:
                            break
                        }
                    }
                }
            case .pathErr:
                print("감정 개수 세기 결과 :: Path Err")
            case .requestErr:
                print("감정 개수 세기 결과 :: Request Err")
            case .serverErr:
                print("감정 개수 세기 결과 :: Server Err")
            case .networkFail:
                print("감정 개수 세기 결과 :: Network Fail")
            }
        }
    }

}
