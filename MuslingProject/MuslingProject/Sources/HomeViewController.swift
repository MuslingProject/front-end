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
    @IBOutlet var weatherLabel: UILabel! // 날싸
    @IBOutlet var noneLabel: UILabel! // 작성되어 있지 않을 때 띄울 문구
    @IBOutlet var homeTitle: UINavigationItem!
    
    var locationManager: CLLocationManager?
    var currentLocation: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 배경 이미지 뷰를 생성하고 추가
        let backgroundImage = UIImageView(image: UIImage(named: "backImg.png"))
        backgroundImage.contentMode = .scaleAspectFill // 이미지 크기 조절 옵션 (필요에 따라 변경)
        backgroundImage.frame = view.bounds // 이미지 뷰를 화면 크기에 맞게 설정
        
        // 배경 이미지 뷰를 뷰의 맨 뒤에 추가합니다.
        view.insertSubview(backgroundImage, at: 0)
        
        requestAuthorization()
        WeatherService.shared.getWeather(lat: LocationService.shared.latitude ?? 0, lon: LocationService.shared.longitude ?? 0) { response in
            switch response {
            case .success(let data):
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy년 MM월 dd일 (E)"
                let current_date_string = formatter.string(from: Date())
                
                if let data = data as? WeatherData {
                    print("날씨 불러오기 결과 :: Success")
                    
                    guard let weatherText = weatherDescKo[data.weather] else { return }
                    self.dateLabel.text = "\(current_date_string) \(data.temperature)º"
                    self.weatherLabel.text = weatherText
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
        noDiary()
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
        navigationController?.navigationBar.tintColor = .darkGray
        
        // navigation bar 그림자 효과
        navigationController?.navigationBar.layer.masksToBounds = false
        navigationController?.navigationBar.layer.shadowColor = UIColor.primary?.cgColor
        navigationController?.navigationBar.layer.shadowOpacity = 0.8
        navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2)
        navigationController?.navigationBar.layer.shadowRadius = 2
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
    
    func noDiary() {
        noneLabel.text = "아직 오늘이 기록이 없어요\n일기를 작성해 주세요!"
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