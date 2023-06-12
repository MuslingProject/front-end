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
    @IBOutlet var noneLabel: UILabel! // 작성되어 있지 않을 때 띄울 문구
    @IBOutlet var homeTitle: UINavigationItem!

    var locationManager: CLLocationManager?
    var currentLocation: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestAuthorization()
        getWeather()
        noDiary()
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
    
    func noDiary() {
        noneLabel.text = "아직 오늘이 기록이 없어요\n일기를 작성해 주세요!"
    }
    
    func getWeather() {
        let params: Parameters = [
            "lat": LocationService.shared.latitude ?? 0,
            "lon": LocationService.shared.longitude ?? 0
        ]
        
        AF.request("http://54.180.220.34:8080/read/weather",
                   method: .post,
                   parameters: params,
                   encoding: JSONEncoding.default,
                   headers: nil)
        .validate(statusCode: 200 ..< 299).responseData { response in
            switch response.result {
            case .success(let weatherData):
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd (E)"
                let current_date_string = formatter.string(from: Date())
                let weather = try? JSONDecoder().decode(Weather.self, from: weatherData)
                
                self.dateLabel.text = "TODAY \(current_date_string) \(weather!.temp)º \(weather!.main)"
            case .failure(let error):
                print(error)
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
