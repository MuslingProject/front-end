//
//  LoginViewController.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/04/11.
//

import UIKit
import GoogleSignIn

class FirstViewController: UIViewController, UIScrollViewDelegate {
    
    weak var sv: UIView!
    @IBOutlet var ggBtn: UIButton!
    @IBOutlet var normalBtn: UIButton!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var signup: UILabel!
    
    // 스크롤 뷰 데이터
    var images = [ "📝", "🤔", "🎵" ]
    var titles = [ "일상 기록 작성", "감정 분석", "감정 기반 음악 추천" ]
    var scripts = [ "일상 속 기억하고 싶은\n순간들을 기록으로 남겨 보세요", "기록에 담긴 나의 솔직한\n감정을 인공지능이 파악해 줘요", "파악된 감정을 바탕으로\n뮤즐링이 어울리는 음악들을 추천해 드릴게요" ]
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let value = scrollView.contentOffset.x/scrollView.frame.size.width
        setPageControlSelectedPage(currentPage: Int(round(value)))
    }
    
    // 구글 계정으로 로그인 선택했을 때
    @IBAction func ggLogin(_ sender: UIButton) {
        // 구글 로그인
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            guard error == nil else { return }
            
            guard let signInResult = signInResult else { return }

            let user = signInResult.user
            let email = user.profile?.email
            
            Member.shared.user_id = email
            Member.shared.pwd = ""
            
            // 프로필 완성 화면으로 전환
            guard let vcName = self.storyboard?.instantiateViewController(withIdentifier: "ProfileVC") else { return }
            self.navigationController?.pushViewController(vcName, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signup.attributedText = NSAttributedString(string: "회원가입 하기", attributes: [NSAttributedString.Key.kern: -0.77, NSAttributedString.Key.font: UIFont(name: "Pretendard-SemiBold", size: 13)!])
        
        let ggAttributedTitle = NSAttributedString(string: "구글 계정으로 로그인", attributes: [NSAttributedString.Key.font: UIFont(name: "Pretendard-Medium", size: 16)!, NSAttributedString.Key.kern: -0.7])
        ggBtn.setAttributedTitle(ggAttributedTitle, for: .normal)

        let normalAttributedTitle = NSAttributedString(string: "일반 로그인", attributes: [NSAttributedString.Key.font: UIFont(name: "Pretendard-Medium", size: 16)!, NSAttributedString.Key.kern: -0.7, NSAttributedString.Key.foregroundColor: UIColor.white])
        normalBtn.setAttributedTitle(normalAttributedTitle, for: .normal)
        
        // 스크롤뷰 설정
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
        
        // 스크롤뷰
        addContentScrollView()
        setPageControl()
        
        // 회원가입 클릭 시 페이지 이동
        let goSignUp = UITapGestureRecognizer(target: self, action: #selector(goToSignUp))
        signup.isUserInteractionEnabled = true
        signup.addGestureRecognizer(goSignUp)

        // Navigation Bar Title 폰트 설정
        let navigationBarAppearance = UINavigationBarAppearance()
        
        if let customFont = UIFont(name: "Pretendard-Bold", size: 26) {
            navigationBarAppearance.largeTitleTextAttributes = [
                .font: customFont,
                .foregroundColor: UIColor.blue01!,
                .kern: -1
            ]
        } else {
            print("폰트를 로드할 수 없습니다.")
        }

        // 현재 UIViewController의 Navigation Controller 가져오기
        if let navigationController = self.navigationController {
            // 현재 UIViewController의 Navigation Bar Appearance 설정
            navigationController.navigationBar.tintColor = .blue01
            navigationController.navigationBar.standardAppearance = navigationBarAppearance
            navigationController.navigationBar.scrollEdgeAppearance = nil
        }
    }
    
    @objc func goToSignUp() {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "SignUp") else { return }
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    private func addContentScrollView() {
        var contentX: CGFloat = 0.0 // 컨텐츠의 x 좌표를 초기화합니다.
        
        for i in 0..<images.count {
            // 이미지와 레이블을 담을 컨테이너 뷰 생성
            let containerView = UIView()
            
            // titleLabel과 scriptLabel을 생성하고 컨테이너 뷰에 추가
            let imageLabel = UILabel()
            let titleLabel = UILabel()
            let scriptLabel = UILabel()
            
            imageLabel.text = images[i]
            titleLabel.text = titles[i]
            scriptLabel.text = scripts[i]
            
            imageLabel.frame = CGRect(x: containerView.bounds.width/2, y: 110, width: scrollView.bounds.width, height: 96)
            imageLabel.font = UIFont(name: "Pretendard-Bold", size: 80)
            imageLabel.textAlignment = .center
            imageLabel.text = images[i]
            
            
            titleLabel.frame = CGRect(x: containerView.bounds.width/2, y: 0, width: scrollView.bounds.width, height: 30)
            titleLabel.textColor = .blue01
            titleLabel.font = UIFont(name: "Pretendard-Bold", size: 24)
            titleLabel.attributedText = NSMutableAttributedString(string: titles[i], attributes: [NSAttributedString.Key.kern: -1.2])
            titleLabel.textAlignment = .center
            
            scriptLabel.frame = CGRect(x: containerView.bounds.width/2, y: 30, width: scrollView.bounds.width, height: 70)
            scriptLabel.textColor = .text02
            scriptLabel.font = UIFont(name: "Pretendard-Medium", size: 14)
            scriptLabel.numberOfLines = 0
            scriptLabel.lineBreakMode = .byWordWrapping
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = 1.1
            
            scriptLabel.attributedText = NSMutableAttributedString(string: scripts[i], attributes: [NSAttributedString.Key.kern: -0.7, NSAttributedString.Key.paragraphStyle: paragraphStyle])
            
            scriptLabel.textAlignment = .center
            
            containerView.addSubview(imageLabel)
            containerView.addSubview(titleLabel)
            containerView.addSubview(scriptLabel)
            
            // 컨테이너 뷰를 스크롤 뷰에 추가
            containerView.frame = CGRect(x: contentX, y: 0, width: scrollView.bounds.width, height: scrollView.bounds.height)
            scrollView.addSubview(containerView)
            
            contentX += scrollView.bounds.width // x 좌표를 증가시켜 다음 컨텐츠 위치를 지정합니다.
        }
        
        // 스크롤뷰의 contentSize 설정
        scrollView.contentSize.width = scrollView.frame.width * CGFloat(images.count)
    }
    
    private func setPageControl() {
        pageControl.numberOfPages = images.count
    }
    
    private func setPageControlSelectedPage(currentPage:Int) {
        pageControl.currentPage = currentPage
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }

}
