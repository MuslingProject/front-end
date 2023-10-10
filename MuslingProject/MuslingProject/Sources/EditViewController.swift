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
        if Genre.shared.dancePop != true {
            Genre.shared.dancePop = true
        } else {
            Genre.shared.dancePop = false
        }
        isGenreModify = true
    }
    
    @IBAction func selectBalad(_ sender: Any) {
        select(balad)
        if Genre.shared.balad != true {
            Genre.shared.balad = true
        } else {
            Genre.shared.balad = false
        }
        isGenreModify = true
    }
    
    @IBAction func selectHiphop(_ sender: Any) {
        select(hiphop)
        if Genre.shared.rapHiphop != true {
            Genre.shared.rapHiphop = true
        } else {
            Genre.shared.rapHiphop = false
        }
        isGenreModify = true
    }
    
    @IBAction func selectInde(_ sender: Any) {
        select(indie)
        if Genre.shared.indie != true {
            Genre.shared.indie = true
        } else {
            Genre.shared.indie = false
        }
        isGenreModify = true
    }
    
    @IBAction func selectMetal(_ sender: Any) {
        select(metal)
        if Genre.shared.rockMetal != true {
            Genre.shared.rockMetal = true
        } else {
            Genre.shared.rockMetal = false
        }
        isGenreModify = true
    }
        
    @IBAction func selectRnb(_ sender: Any) {
        select(rnb)
        if Genre.shared.rbSoul != true {
            Genre.shared.rbSoul = true
        } else {
            Genre.shared.rbSoul = false
        }
        isGenreModify = true
    }
    
    @IBAction func selectAcoustic(_ sender: Any) {
        select(acoustic)
        if Genre.shared.forkAcoustic != true {
            Genre.shared.forkAcoustic = true
        } else {
            Genre.shared.forkAcoustic = false
        }
        isGenreModify = true
    }
    
    let ages = ["10대", "20대", "30대", "40대", "50대 이상"]
    var isImgModify = false
    var isGenreModify = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 커스텀 폰트
        let customFont = UIFont(name: "Pretendard-SemiBold", size: 16)
        
        // NSAttributedString을 사용하여 폰트 속성 설정
        let attributes: [NSAttributedString.Key: Any] = [
            .font: customFont as Any,
            .foregroundColor: UIColor.white // 원하는 텍스트 색상으로 설정
        ]
        
        // UIBarButtonItem 생성 및 타이틀 설정
        let barButtonItem = UIBarButtonItem(title: nil, style: .plain, target: self, action: #selector(saveInfo(_:)))
        barButtonItem.title = "작성" // 타이틀 설정
        barButtonItem.setTitleTextAttributes(attributes, for: .normal) // NSAttributedString 설정
        
        navigationItem.rightBarButtonItem = barButtonItem
        
        Genre.shared.balad = false
        Genre.shared.dancePop = false
        Genre.shared.forkAcoustic = false
        Genre.shared.indie = false
        Genre.shared.rapHiphop = false
        Genre.shared.rbSoul = false
        Genre.shared.rockMetal = false
        
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
        
        selectAge.delegate = self
        selectAge.tintColor = .clear // 커서 깜빡임 해결
        
        createPickerView(tagNo: 2)
        dismissPickerView()
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
        isImgModify = true
        
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
        
        // 장르 수정
        if isGenreModify {
            let genre = Genre.shared
            MypageService.shared.modifyGenre(indie: genre.indie, balad: genre.balad, rockMetal: genre.rockMetal, dancePop: genre.dancePop, rapHiphop: genre.rapHiphop, rbSoul: genre.rbSoul, forkAcoustic: genre.forkAcoustic) { response in
                switch response {
                case .success(let data):
                    if let data = data as? GenreModel {
                        print("선호 장르 수정 결과 :: \(data.result)")
                    }
                    // 마이페이지로 이동하기
                    NotificationCenter.default.post(name: .genreUpdated, object: nil)
                    self.navigationController?.popViewController(animated: true)
                case .pathErr:
                    print("선호 장르 수정 결과 :: Path Err")
                case .requestErr:
                    print("선호 장르 수정 결과 :: Request Err")
                case .serverErr:
                    print("선호 장르 수정 결과 :: Server Err")
                case .networkFail:
                    print("선호 장르 수정 결과 :: Network Fail")
                }
            }
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
}
