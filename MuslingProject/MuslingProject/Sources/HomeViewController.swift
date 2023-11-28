//
//  HomeViewController.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/04/17.
//

import UIKit
import CoreLocation
import Alamofire

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var dateLabel: UILabel! // 날짜
    @IBOutlet var weatherLabel: UILabel! // 날씨
    @IBOutlet var noneLabel: UILabel! // 작성되어 있지 않을 때 띄울 문구
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var writeBtn: UIButton!
    @IBOutlet var diaryLabel: UILabel!
    @IBOutlet var diaryTableView: UITableView!
    
    var locationManager: CLLocationManager?
    var currentLocation: CLLocationCoordinate2D?
    
    var diaries: [DiaryModel] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diaries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "diary", for: indexPath) as! DiaryCell
        
        cell.title.attributedText = NSAttributedString(string: diaries[indexPath.row].title, attributes: [NSAttributedString.Key.font: UIFont(name: "Pretendard-Medium", size: 14)!, NSAttributedString.Key.kern: -0.7])
        
        var emotionStr: String = ""
        
        switch diaries[indexPath.row].mood {
        case "사랑/기쁨":
            emotionStr = "🥰 사랑/기쁨"
        case "이별/슬픔":
            emotionStr = "😢 이별/슬픔"
        case "우울":
            emotionStr = "🫠 우울"
        case "멘붕/불안":
            emotionStr = "🤯 멘붕/불안"
        case "스트레스/짜증":
            emotionStr = "😡 스트레스/짜증"
        default:
            emotionStr = ""
        }
        
        cell.emotion.attributedText = NSAttributedString(string: emotionStr, attributes: [NSAttributedString.Key.font: UIFont(name: "Pretendard-Regular", size: 12)!, NSAttributedString.Key.kern: -0.6])
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "homeToDiary" {
            if let destination = segue.destination as? DiaryViewController, let selectedIndex = self.diaryTableView.indexPathForSelectedRow {
                let diary = diaries[selectedIndex.row]
                
                destination.diaryId = diary.diaryId
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noneLabel.isHidden = true
        diaryTableView.isHidden = true
        diaryLabel.isHidden = true
        
        IsnoDiary()
        
        diaryTableView.dataSource = self
        diaryTableView.delegate = self
        
        diaryLabel.attributedText = NSAttributedString(string: diaryLabel.text!, attributes: [NSAttributedString.Key.kern: -0.7, NSAttributedString.Key.font: UIFont(name: "Pretendard-Bold", size: 13)!])
        
        
        navigationController?.navigationBar.tintColor = .blue01
        navigationController?.navigationBar.backgroundColor = UIColor.clear
        
        // 옵저버 등록
        NotificationCenter.default.addObserver(self, selector: #selector(handleProfileUpdate), name: .profileUpdated, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleDiaryUpdate), name: .diaryUpdated, object: nil)
        
        titleLabel.numberOfLines = 2
        
        if let name = UserDefaults.standard.string(forKey: "user_name") {
            titleLabel.attributedText = NSAttributedString(string: "\(name) 님,\n일상을 기록해 보세요 ✍️", attributes: [NSAttributedString.Key.font: UIFont(name: "Pretendard-ExtraBold", size: 26)!, NSAttributedString.Key.kern: -1.8])
        } else {
            MypageService.shared.getMypage() { response in
                switch response {
                case .success(let data):
                    if let data = data as? MypageModel {
                        print("회원 정보 불러오기 결과 :: \(data.result)")
                        UserDefaults.standard.setValue(data.data.name, forKey: "user_name")
                        self.titleLabel.attributedText = NSAttributedString(string: "\(data.data.name) 님,\n일상을 기록해 보세요 ✍️", attributes: [NSAttributedString.Key.font: UIFont(name: "Pretendard-ExtraBold", size: 26)!, NSAttributedString.Key.kern: -1.8])
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
        
        requestAuthorization()
        
        WeatherService.shared.getWeather(lat: LocationService.shared.latitude ?? 0, lon: LocationService.shared.longitude ?? 0) { response in
            switch response {
            case .success(let data):
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy년 MM월 dd일 (E)"
                formatter.locale = Locale(identifier: "ko_KR")
                let current_date_string = formatter.string(from: Date())
                
                if let data = data as? WeatherData {
                    print("날씨 불러오기 결과 :: Success")
                    
                    guard let weatherText = weatherDescKo[data.weather] else { return }
                    self.dateLabel.attributedText = NSAttributedString(string: current_date_string, attributes: [NSAttributedString.Key.font: UIFont(name: "Pretendard-SemiBold", size: 14)!, NSAttributedString.Key.kern: -0.56])
                    self.weatherLabel.attributedText = NSAttributedString(string: "\(data.temperature)º \(weatherText)", attributes: [NSAttributedString.Key.font: UIFont(name: "Pretendard-SemiBold", size: 14)!, NSAttributedString.Key.kern: -0.56])
                }
                
            case .pathErr:
                print("날씨 불러오기 결과 :: Path Err")
            case .requestErr:
                print("날씨 불러오기 결과 :: Request Err")
            case .serverErr:
                print("날씨 불러오기 결과 :: Server Err")
            case .networkFail:
                print("날씨 불러오기 결과 :: Network Fail")
            }
        }
    }
    
    func IsnoDiary() {
        
        // 오늘 기록 조회하는 함수 실행
        DiaryService.shared.getDiaries(page: 0, size: 30) { response in
            switch response {
            case .success(let data):
                if let data = data as? GetDiaryModel {
                    print("전체 기록 조회 결과 :: \(data.result)")
                    
                    if data.data.content.isEmpty {
                        self.noneLabel.isHidden = false
                        self.diaryLabel.isHidden = true
                        self.diaryTableView.isHidden = true
                        self.noneLabel.numberOfLines = 2
                        self.noneLabel.attributedText = NSAttributedString(string: "아직 오늘이 기록이 없어요\n연필을 눌러 기록을 작성해 주세요!", attributes: [NSAttributedString.Key.kern: -0.7, NSAttributedString.Key.font: UIFont(name: "Pretendard-Regular", size: 14)!])
                        self.noneLabel.textAlignment = .center
                    } else {
                        self.noneLabel.isHidden = true
                        self.diaryLabel.isHidden = false
                        self.diaryTableView.isHidden = false
                        
                        self.diaries = []
                        
                        for diary in data.data.content {
                            let formatter = DateFormatter()
                            formatter.dateFormat = "yyyy-MM-dd"
                            let todayDate = formatter.string(from: Date())
                            let dateString = formatter.string(from: diary.date)
                            
                            if dateString == todayDate {
                                self.diaries.append(diary)
                            }
                        }
                        self.diaryTableView.reloadData()
                    }
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
    
    // 옵저버 해제
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func handleDiaryUpdate() {
        IsnoDiary()
    }
    
    @objc func handleProfileUpdate() {
        if let nickname = UserDefaults.standard.string(forKey: "user_name") {
            self.titleLabel.numberOfLines = 2
            self.titleLabel.attributedText = NSAttributedString(string: "\(nickname) 님,\n일상을 기록해 보세요 ✍️", attributes: [NSAttributedString.Key.font: UIFont(name: "Pretendard-ExtraBold", size: 26)!, NSAttributedString.Key.kern: -1.8])
        } else {
            MypageService.shared.getMypage() { response in
                switch response {
                case .success(let data):
                    if let data = data as? MypageModel {
                        print("회원 정보 불러오기 결과 :: \(data.result)")
                        
                        self.titleLabel.numberOfLines = 2
                        self.titleLabel.attributedText = NSAttributedString(string: "\(data.data.name) 님,\n일상을 기록해 보세요 ✍️", attributes: [NSAttributedString.Key.font: UIFont(name: "Pretendard-ExtraBold", size: 26)!, NSAttributedString.Key.kern: -1.8])
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

extension HomeViewController: CLLocationManagerDelegate {
    private func requestAuthorization() {
        if locationManager == nil {
            locationManager = CLLocationManager()
            // 정확도 검사
            locationManager!.desiredAccuracy = kCLLocationAccuracyBest
            
            // 앱을 사용할 때 권한 요청
            locationManager!.requestWhenInUseAuthorization()
            locationManager!.delegate = self
            locationManagerDidChangeAuthorization(locationManager!)
        } else {
            // 사용자의 위치가 바뀌고 있는지 확인하는 메소드
            locationManager!.startMonitoringSignificantLocationChanges()
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse {
            currentLocation = locationManager!.location?.coordinate
            LocationService.shared.longitude = currentLocation?.longitude
            LocationService.shared.latitude = currentLocation?.latitude
        }
    }
}
