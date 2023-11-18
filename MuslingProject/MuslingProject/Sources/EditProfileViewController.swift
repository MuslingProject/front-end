//
//  EditProfileViewController.swift
//  MuslingProject
//
//  Created by 이나경 on 11/17/23.
//

import UIKit

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UITextFieldDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var userProfile: UIImageView!
    @IBOutlet var nameField: HSUnderLineTextField!
    @IBOutlet var nameLabel: UILabel!
    
    var isImgModify = false

    @IBAction func saveBtn(_ sender: Any) {
        // 이미지 수정
        if isImgModify {
            MypageService.shared.modifyImage(imgData: Member.shared.img) { response in
                switch response {
                case .success(let data):
                    if let data = data as? NonDataModel {
                        print("프로필 사진 수정 결과 :: \(data.message)")
                    }
                    // 마이페이지로 이동
                    NotificationCenter.default.post(name: .profileUpdated, object: nil)
                    self.navigationController?.popViewController(animated: true)
                case .pathErr:
                    print("프로필 사진 수정 결과 :: Path Err")
                case .requestErr:
                    print("프로필 사진 수정 결과 :: Request Err")
                case .serverErr:
                    print("프로필 사진 수정 결과 :: Server Err")
                case .networkFail:
                    print("프로필 사진 수정 결과 :: Network Fail")
                }
            }
        }
        
        // 닉네임 수정
        if nameField.text != "" {
            guard let newName = nameField.text else { return }
            MypageService.shared.modifyName(nickname: newName) { response in
                switch response {
                case .success(let data):
                    if let data = data as? NameModifyModel {
                        print("닉네임 수정 결과 :: \(data.result)")
                    }
                    // 마이페이지로 이동
                    NotificationCenter.default.post(name: .profileUpdated, object: nil)
                    self.navigationController?.popViewController(animated: true)
                case .pathErr:
                    print("닉네임 수정 결과 :: Path Err")
                case .requestErr:
                    print("닉네임 수정 결과 :: Request Err")
                case .serverErr:
                    print("닉네임 수정 결과 :: Server Err")
                case .networkFail:
                    print("닉네임 수정 결과 :: Network Fail")
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.attributedText = NSMutableAttributedString(string: nameLabel.text!, attributes: [NSAttributedString.Key.kern: -0.7, NSAttributedString.Key.font: UIFont(name: "Pretendard-SemiBold", size: 14)!])

        if Member.shared.imgURL != nil {
            userProfile.loadImage(from: Member.shared.imgURL)
            // 이미지 원형으로 표시
            userProfile.layer.cornerRadius = self.userProfile.frame.height/2
            userProfile.layer.borderWidth = 1
            userProfile.clipsToBounds = true
            userProfile.layer.borderColor = UIColor.clear.cgColor
        } else {
            // 서버에서 불러오기
            MypageService.shared.getMypage() { response in
                switch response {
                case .success(let data):
                    if let data = data as? MypageModel {
                        print("회원 정보 불러오기 결과 :: Success")
                        
                        // 프로필 사진
                        if let imageUrl = URL(string: data.data.profileImageUrl) {
                            Member.shared.imgURL = imageUrl
                            self.userProfile.loadImage(from: imageUrl)
                        }
                        // 이미지 원형으로 표시
                        self.userProfile.layer.cornerRadius = self.userProfile.frame.height/2
                        self.userProfile.layer.borderWidth = 1
                        self.userProfile.clipsToBounds = true
                        self.userProfile.layer.borderColor = UIColor.clear.cgColor
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
        
        // textField 왼쪽 여백 추가
        nameField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 2.0, height: 0.0))
        nameField.leftViewMode = .always
        
        let selectImg = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        userProfile.isUserInteractionEnabled = true
        userProfile.addGestureRecognizer(selectImg)
    }
    
    @objc func selectImage(sender: UITapGestureRecognizer) {
        let alert = UIAlertController(title: nil, message: "프로필 사진 설정", preferredStyle: .actionSheet)
        // 이미지 피커 인스턴스 생성
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        alert.addAction(UIAlertAction(title: "앨범에서 선택", style: .default) {
            (_) in self.present(picker, animated: false)
        })
        alert.addAction(UIAlertAction(title: "카메라로 촬영", style: .default) {
            (_) in picker.sourceType = .camera
            self.present(picker, animated: true)
        })
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        
        self.present(alert, animated: true)
    }
    
    // 이미지 선택 완료했을 때 호출하는 메소드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 선택한 이미지를 미리보기에 표시
        userProfile.image = info[.editedImage] as? UIImage
        userProfile.layer.cornerRadius = userProfile.frame.height/2
        userProfile.clipsToBounds = true
        
        Member.shared.img = self.userProfile.image
        // 이미지 변경했다는 bool 변수 True로 변경
        isImgModify = true
        
        // 이미지 피커 컨트롤러 닫기
        picker.dismiss(animated: false)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }

}
