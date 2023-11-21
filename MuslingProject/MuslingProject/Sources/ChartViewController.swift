//
//  ChartViewController.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/09/27.
//

import UIKit
import Charts

class ChartViewController: UIViewController {
        
    @IBOutlet var chart: BarChartView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var script1: UILabel!
    @IBOutlet var moodScript: UILabel!
    @IBOutlet var muslingScript: UILabel!
    
    var emotions = ["🥰", "😢", "😞", "😨", "😡"]
    var counts = [14, 3, 5, 2, 1]
    
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
        chart.xAxis.labelRotatedHeight = 15.0 // 하단 범례 잘리지 않도록 설정해 주기
        chart.xAxis.labelFont = UIFont(name: "Pretendard-Regular", size: 12)!
        
        // 하단의 범례 제거
        chart.legend.enabled = false
        
        chart.animate(xAxisDuration: 1.0, yAxisDuration: 1.0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 옵저버 등록
        NotificationCenter.default.addObserver(self, selector: #selector(handleProfileUpdate), name: .profileUpdated, object: nil)
        
        script1.attributedText = NSAttributedString(string: "지금까지 가장 많이 나타난 감정은...", attributes: [NSAttributedString.Key.kern: -1, NSAttributedString.Key.font: UIFont(name: "Pretendard-Medium", size: 15)!])
        moodScript.attributedText = NSAttributedString(string: "사랑/기쁨이에요 😘 ", attributes: [NSAttributedString.Key.kern: -1, NSAttributedString.Key.font: UIFont(name: "Pretendard-Bold", size: 16)!])
        
        if let name = UserDefaults.standard.string(forKey: "user_name") {
            titleLabel.attributedText = NSAttributedString(string: "\(name) 님의\n감정 그래프를 보여드릴게요 👀", attributes: [NSAttributedString.Key.font: UIFont(name: "Pretendard-ExtraBold", size: 26)!, NSAttributedString.Key.kern: -2.34])
        } else {
            MypageService.shared.getMypage() { response in
                switch response {
                case .success(let data):
                    if let data = data as? MypageModel {
                        print("회원 정보 불러오기 결과 :: \(data.result)")
                        UserDefaults.standard.setValue(data.data.name, forKey: "user_name")
                        self.titleLabel.attributedText = NSAttributedString(string: "\(data.data.name) 님의\n감정 그래프를 보여드릴게요 👀", attributes: [NSAttributedString.Key.font: UIFont(name: "Pretendard-ExtraBold", size: 26)!, NSAttributedString.Key.kern: -2.34])
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
        
        guard let nickname = UserDefaults.standard.string(forKey: "user_name") else { return }
        
        muslingScript.attributedText = NSAttributedString(string: "앞으로도 \(nickname) 님에게 사랑스럽고 기쁜 나날들이\n계속되길 바랄게요. 오늘도 좋은 하루 보내요! ☺️ ", attributes: [NSAttributedString.Key.kern: -1,  NSAttributedString.Key.font: UIFont(name: "Pretendard-Medium", size: 15)!])
        
        chart.noDataText = "🥲 아직 데이터가 없어요"
        chart.noDataFont = UIFont(name: "Pretendard-Regular", size: 20)!
        chart.noDataTextColor = .lightGray
        
        setChart(dataPoints: emotions, values: counts)
    }
    
    @objc func handleProfileUpdate() {
        if let name = UserDefaults.standard.string(forKey: "user_name") {
            titleLabel.attributedText = NSAttributedString(string: "\(name) 님의\n감정 그래프를 보여드릴게요 👀", attributes: [NSAttributedString.Key.font: UIFont(name: "Pretendard-ExtraBold", size: 26)!, NSAttributedString.Key.kern: -2.34])
        } else {
            MypageService.shared.getMypage() { response in
                switch response {
                case .success(let data):
                    if let data = data as? MypageModel {
                        print("회원 정보 불러오기 결과 :: \(data.result)")
                        UserDefaults.standard.setValue(data.data.name, forKey: "user_name")
                        self.titleLabel.attributedText = NSAttributedString(string: "\(data.data.name) 님의\n감정 그래프를 보여드릴게요 👀", attributes: [NSAttributedString.Key.font: UIFont(name: "Pretendard-ExtraBold", size: 26)!, NSAttributedString.Key.kern: -2.34])
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

}
