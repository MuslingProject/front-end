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
    @IBOutlet var emotionScript: UILabel!
    
    var emotions = ["🥰", "😢", "🫠", "🤯", "😡"]
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
        chartDataSet.valueFont = UIFont(name: "Pretendard-Regular", size: 15)!
        chartDataSet.colors = [.secondary!] // 차트 컬러
        
        let chartData = BarChartData(dataSet: chartDataSet)
        chart.data = chartData
        
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0

        let valueFormatter = DefaultValueFormatter(formatter: formatter)
        chartData.setValueFormatter(valueFormatter)
        
        chartData.setValueTextColor(UIColor.secondary!)
        chartData.setValueFont(UIFont(name: "Pretendard-Bold", size: 13)!)
        
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
        chart.xAxis.labelFont = UIFont(name: "Pretendard-Regular", size: 16)!
        
        // 하단의 범례 제거
        chart.legend.enabled = false
        
        chart.animate(xAxisDuration: 1.0, yAxisDuration: 1.0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 배경 이미지 뷰를 생성하고 추가
        let backgroundImage = UIImageView(image: UIImage(named: "backImg.png"))
        backgroundImage.contentMode = .scaleAspectFill // 이미지 크기 조절 옵션 (필요에 따라 변경)
        backgroundImage.frame = view.bounds // 이미지 뷰를 화면 크기에 맞게 설정
        
        // 배경 이미지 뷰를 뷰의 맨 뒤에 추가합니다.
        view.insertSubview(backgroundImage, at: 0)
        
        chart.noDataText = "🥲 아직 데이터가 없어요"
        chart.noDataFont = UIFont(name: "Pretendard-Regular", size: 20)!
        chart.noDataTextColor = .lightGray
        
        setChart(dataPoints: emotions, values: counts)
        
        emotionScript.text = "🥰 기분 좋은 날이 14일 있었어요\n😢 슬픈 날이 3일 있었어요\n🫠 우울한 날이 5일 있었어요\n🤯 불안한 날이 2일 있었어요\n😡 짜증나는 날이 1일 있었어요"
        emotionScript.numberOfLines = 5

        // 행간 조절
        let attrStirng = NSMutableAttributedString(string: emotionScript.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10
        attrStirng.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrStirng.length))
        attrStirng.addAttribute(NSAttributedString.Key.kern, value: -0.7, range: NSMakeRange(0, attrStirng.length))
        emotionScript.attributedText = attrStirng

        emotionScript.textColor = UIColor.darkGray
        emotionScript.font = UIFont(name: "Pretendard-Medium", size: 17)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
