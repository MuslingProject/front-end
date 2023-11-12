//
//  HomeViewController.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/04/17.
//

import UIKit
import CoreLocation
import Alamofire

class HomeViewController: UIViewController {
    
    @IBOutlet var dateLabel: UILabel! // 날짜
    @IBOutlet var weatherLabel: UILabel! // 날씨
    @IBOutlet var noneLabel: UILabel! // 작성되어 있지 않을 때 띄울 문구
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var writeBtn: CSButton!
    
    var locationManager: CLLocationManager?
    var currentLocation: CLLocationCoordinate2D?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .blue01
        navigationController?.navigationBar.backgroundColor = UIColor.clear
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont(name: "Pretendard-Medium", size: 16)!,
            NSAttributedString.Key.kern: -0.5
        ]
        
        IsnoDiary()
        
        guard let name = UserDefaults.standard.string(forKey: "user_name") else { return }
        
        titleLabel.numberOfLines = 2
        titleLabel.attributedText = NSAttributedString(string: "\(name) 님,\n일상을 기록해 보세요 ✍️", attributes: [NSAttributedString.Key.font: UIFont(name: "Pretendard-ExtraBold", size: 26)!, NSAttributedString.Key.kern: -1.7])
        
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
        if UserDefaults.standard.bool(forKey: "todayWrite") == false {
            noneLabel.numberOfLines = 2
            noneLabel.attributedText = NSAttributedString(string: "아직 오늘이 기록이 없어요\n일기를 작성해 주세요!", attributes: [NSAttributedString.Key.kern: -0.7, NSAttributedString.Key.font: UIFont(name: "Pretendard-Regular", size: 14)!])
            noneLabel.textAlignment = .center
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
