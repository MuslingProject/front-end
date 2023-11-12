//
//  ProfileViewController.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/04/12.
//

import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var profileImg: UIImageView!
    @IBOutlet var nameLabel: HSUnderLineTextField!
    @IBOutlet var name: UILabel!
    @IBOutlet var nextBtn: UIButton!
    
    var isSelect = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let selectImg = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        profileImg.isUserInteractionEnabled = true
        profileImg.addGestureRecognizer(selectImg)
        
        // 이미지 원형으로 만들기
        profileImg.layer.cornerRadius = profileImg.frame.height/2
        profileImg.layer.borderWidth = 1
        profileImg.clipsToBounds = true
        profileImg.layer.borderColor = UIColor.clear.cgColor
        
        name.attributedText = NSAttributedString(string: "닉네임", attributes: [NSAttributedString.Key.kern: -0.5, NSAttributedString.Key.font: UIFont(name: "Pretendard-Bold", size: 15)!])
        
        nextBtn.setAttributedTitle(NSAttributedString(string: "다음", attributes: [NSAttributedString.Key.font: UIFont(name: "Pretendard-SemiBold", size: 15)!, NSAttributedString.Key.kern: -0.5]), for: .normal)
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
        self.profileImg.image = info[.editedImage] as? UIImage
        
        // img 변수에 저장
        Member.shared.img = self.profileImg.image
        
        // 이미지 피커 컨트롤러 닫기
        picker.dismiss(animated: false)
        
        isSelect = true
    }

    @IBAction func nextBtn(_ sender: Any) {
        if isSelect == false {
            Member.shared.img = UIImage(named: "profile.png")
        }
        if nameLabel.text == "" {
            let alert = UIAlertController(title: "닉네임을 입력해 주세요", message: nil, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        } else {
            Member.shared.name = nameLabel.text
            UserDefaults.standard.setValue(nameLabel.text, forKey: "user_name")
            
            guard let vc = self.storyboard?.instantiateViewController(identifier: "SelectVC") else { return }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
}
