//
//  MypageViewController.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/04/17.
//

import UIKit

class MypageViewController: UIViewController {

    @IBOutlet var userProfile: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 옵저버 등록
        NotificationCenter.default.addObserver(self, selector: #selector(handleDataUpdate), name: .dataUpdated, object: nil)
        
        MypageService.shared.getMypage() { response in
            switch response {
            case .success(let data):
                if let data = data as? MypageModel {
                    print("회원 정보 불러오기 결과 :: \(data.message)")
                    
                    // 닉네임
                    self.nameLabel.text = data.data.name
                    
                    // 프로필 사진
                    if let imageUrl = URL(string: data.data.profile.imageUrl) {
                        self.userProfile.loadImage(from: imageUrl)
                        Member.shared.imgURL = imageUrl
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
        
        userProfile.layer.cornerRadius = userProfile.frame.height/2
        userProfile.layer.borderWidth = 1
        userProfile.clipsToBounds = true
        userProfile.layer.borderColor = UIColor.clear.cgColor
    }
    
    // 옵저버 해제
    deinit {
        NotificationCenter.default.removeObserver(self)
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
    
    @objc func handleDataUpdate() {
        MypageService.shared.getMypage() { response in
            switch response {
            case .success(let data):
                if let data = data as? MypageModel {
                    print("회원 정보 불러오기 결과 :: \(data.message)")
                    // 닉네임
                    self.nameLabel.text = data.data.name
                    // 프로필 사진
                    if let imageUrl = URL(string: data.data.profile.imageUrl) {
                        self.userProfile.loadImage(from: imageUrl)
                        Member.shared.imgURL = imageUrl
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

}

extension UIImageView {
    func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let data = data,
                let image = UIImage(data: data)
            else {
                print("Failed to load image from \(url): \(String(describing: error))")
                return
            }
            
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
}
