//
//  EditViewController.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/05/16.
//

import UIKit

class EditViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet var userProfile: UIImageView!
    @IBOutlet var selectAge: UITextField!
    @IBOutlet var nameField: HSUnderLineTextField!
    
    @IBOutlet var dancePop: CSButton!
    @IBOutlet var balad: CSButton!
    @IBOutlet var hiphop: CSButton!
    @IBOutlet var indie: CSButton!
    @IBOutlet var metal: CSButton!
    @IBOutlet var rnb: CSButton!
    @IBOutlet var acoustic: CSButton!
    
    @IBAction func selectKpop(_ sender: Any) {
        select(dancePop)
    }
    
    @IBAction func selectBalad(_ sender: Any) {
        select(balad)
    }
    
    @IBAction func selectHiphop(_ sender: Any) {
        select(hiphop)
    }
    
    @IBAction func selectInde(_ sender: Any) {
        select(indie)
    }
    
    @IBAction func selectMetal(_ sender: Any) {
        select(metal)
    }
        
    @IBAction func selectRnb(_ sender: Any) {
        select(rnb)
    }
    
    @IBAction func selectAcoustic(_ sender: Any) {
        select(acoustic)
    }
    
    let ages = ["10대", "20대", "30대", "40대", "50대 이상"]
    var isModify = false
    
    lazy var doneButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveInfo(_:)))
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
                        if let imageUrl = URL(string: data.data.profile.imageUrl) {
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
        
        selectAge.delegate = self
        selectAge.tintColor = .clear // 커서 깜빡임 해결
        
        createPickerView(tagNo: 2)
        dismissPickerView()
        
        self.doneButton.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = self.doneButton
    }
    
    // 버튼 선택했을 때
    func select(_ sender: UIButton?) {
        if sender?.isSelected != true {
            sender?.isSelected = true
            sender?.backgroundColor = UIColor.systemGray5
            sender?.tintColor = UIColor.white
        } else {
            sender?.isSelected = false
            sender?.backgroundColor = UIColor.white
        }
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
        self.userProfile.image = info[.editedImage] as? UIImage
        Member.shared.img = self.userProfile.image
        // 이미지 변경했다는 bool 변수 True로 변경
        isModify = true
        
        // 이미지 피커 컨트롤러 닫기
        picker.dismiss(animated: false)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
    // 하나의 피커 뷰 안에 몇 개의 선택 가능한 리스트를 표시할 것인지
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ages.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ages[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectAge.text = ages[row]
    }
    
    func createPickerView(tagNo: Int) {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        selectAge.inputView = pickerView
    }
    
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let button = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(doneBtn(_sender:)))
        toolBar.setItems([space, button], animated: true)
        toolBar.isUserInteractionEnabled = true
        selectAge.inputAccessoryView = toolBar
    }
    
    @objc func doneBtn(_sender: Any) {
        self.view.endEditing(true)
    }
    
    @objc func saveInfo(_ sender: Any) {
        // 이미지 저장
        if isModify {
            MypageService.shared.modifyImage(imgData: Member.shared.img) { response in
                switch response {
                case .success(let data):
                    if let data = data as? NonDataModel {
                        print("프로필 사진 수정 결과 :: \(data.message)")
                    }
                    // 마이페이지로 이동
                    NotificationCenter.default.post(name: .dataUpdated, object: nil)
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
        if nameField.text != "" {
            guard let newName = nameField.text else { return }
            MypageService.shared.modifyName(nickname: newName) { response in
                switch response {
                case .success(let data):
                    if let data = data as? NonDataModel {
                        print("닉네임 수정 결과 :: \(data.message)")
                    }
                    // 마이페이지로 이동
                    NotificationCenter.default.post(name: .dataUpdated, object: nil)
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
}
