//
//  MypageViewController.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/04/17.
//

import UIKit

class MypageViewController: UIViewController {
    
    weak var sv: UIView!
    var genre = ""
    
    @IBOutlet var userProfile: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var genreLabel: UILabel!
    
    @IBAction func signOut(_ sender: Any) {
        let alert = UIAlertController(title: "뮤즐링을 탈퇴하시겠습니까?", message: "탈퇴 시 모든 정보가 사라집니다", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "탈퇴", style: .default) { _ in
            // 회원 탙퇴 api 실행
            self.sv = UIViewController.displaySpinner(onView: self.view)
            guard let userId = UserDefaults.standard.string(forKey: "user_id") else { return }
            SignService.shared.signOut(userId: userId) { response in
                switch response {
                case .success(let data):
                    if let data = data as? NonDataModel {
                        print("회원 탈퇴 결과 :: \(data.message)")
                        self.sv.removeFromSuperview()
                        
                        // 홈 화면으로 넘어가기
                        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "FirstVC")
                        vcName?.modalPresentationStyle = .fullScreen
                        vcName?.modalTransitionStyle = .crossDissolve
                        self.present(vcName!, animated: true, completion: nil)
                    }
                case .pathErr:
                    print("회원 탈퇴 결과 :: Path Err")
                    self.sv.removeFromSuperview()
                case .requestErr:
                    print("회원 탈퇴 결과 :: Request Err")
                    self.sv.removeFromSuperview()
                case .serverErr:
                    print("회원 탈퇴 결과 :: Server Err")
                    self.sv.removeFromSuperview()
                case .networkFail:
                    print("회원 탈퇴 결과 :: Network Fail")
                    self.sv.removeFromSuperview()
                }
            }
        }
        let cancle = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(alertAction)
        alert.addAction(cancle)
        
        alertAction.setValue(UIColor.red, forKey: "titleTextColor")
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 옵저버 등록
        NotificationCenter.default.addObserver(self, selector: #selector(handleProfileUpdate), name: .profileUpdated, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleGenreUpdate), name: .genreUpdated, object: nil)

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
        
        MypageService.shared.showGenre() { response in
            switch response {
            case .success(let data):
                if let data = data as? GenreModel {
                    print("장르 불러오기 결과 :: \(data.message)")
                    
                    let mirror = Mirror(reflecting: data.data)
                    
                    for case let (label?, value) in mirror.children {
                        if value as! Int == 1 {
                            guard let genreName = GenreDescKo[label] else { return }
                            self.genre += "\(genreName) "
                        }
                    }
                    // 장르 Label
                    self.genreLabel.text = self.genre
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
        
        if let customFont = UIFont(name: "Pretendard-Bold", size: 26) {
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
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
    
    @objc func handleProfileUpdate() {
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
    
    @objc func handleGenreUpdate() {
        MypageService.shared.showGenre() { response in
            switch response {
            case .success(let data):
                if let data = data as? GenreModel {
                    print("장르 불러오기 결과 :: \(data.message)")
                    
                    let mirror = Mirror(reflecting: data.data)
                    
                    // 장르 변수 초기화
                    self.genre = ""
                    for case let (label?, value) in mirror.children {
                        if value as! Int == 1 {
                            guard let genreName = GenreDescKo[label] else { return }
                            self.genre += "\(genreName) "
                        }
                    }
                    // 장르 Label
                    self.genreLabel.text = self.genre
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
