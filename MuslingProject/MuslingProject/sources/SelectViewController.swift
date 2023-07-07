//
//  SelectViewController.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/04/12.
//

import UIKit
import Alamofire

class SelectViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    let ages = ["10대", "20대", "30대", "40대", "50대 이상"]
    
    @IBOutlet var ageBtn: UITextField!
    @IBOutlet var dancePop: CSButton!
    @IBOutlet var balad: CSButton!
    @IBOutlet var hiphop: CSButton!
    @IBOutlet var indie: CSButton!
    @IBOutlet var metal: CSButton!
    @IBOutlet var rnb: CSButton!
    @IBOutlet var acoustic: CSButton!
    
    @IBAction func finishBtn(_ sender: UIButton) {
        Member.shared.age = ageBtn.text
        if ageBtn.text == "" {
            let alert = UIAlertController(title: "연령대를 선택해 주세요", message: nil, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        } else {
            // 회원가입
            SignService.shared.signUp(userId: Member.shared.user_id, pwd: Member.shared.pwd, name: Member.shared.name, age: Member.shared.age, imgData: Member.shared.img) { response in
                switch response {
                case .success(let msg):
                    print(msg)
                case .pathErr:
                    print("결과 :: Path Err")
                case .requestErr(let msg):
                    print(msg)
                case .serverErr:
                    print("결과 :: Server Err")
                case .networkFail:
                    print("결과 :: Network Fail")
                }
            }
            saveGenre()
            
            // 자동로그인 위해 UserDefaults에 저장
            let dataSave = UserDefaults.standard
            dataSave.setValue(Member.shared.user_id, forKey: "user_id")
            dataSave.setValue(Member.shared.name, forKey: "nickname")
            
            UserDefaults.standard.synchronize()
            
            // 홈으로 이동
            let vcName = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC")
            vcName?.modalPresentationStyle = .fullScreen
            vcName?.modalTransitionStyle = .crossDissolve
            self.present(vcName!, animated: true, completion: nil)
        }
        
        
    }
    
    @IBAction func selectKpop(_ sender: Any) {
        select(dancePop)
        if Genre.shared.dancePop != true {
            Genre.shared.dancePop = true
        } else {
            Genre.shared.dancePop = false
        }
    }
    
    @IBAction func selectBalad(_ sender: Any) {
        select(balad)
        if Genre.shared.balad != true {
            Genre.shared.balad = true
        } else {
            Genre.shared.balad = false
        }
    }
    
    @IBAction func selectHiphop(_ sender: Any) {
        select(hiphop)
        if Genre.shared.rapHiphop != true {
            Genre.shared.rapHiphop = true
        } else {
            Genre.shared.rapHiphop = false
        }
    }
    
    @IBAction func selectInde(_ sender: Any) {
        select(indie)
        if Genre.shared.indie != true {
            Genre.shared.indie = true
        } else {
            Genre.shared.indie = false
        }
    }
    
    @IBAction func selectRock(_ sender: Any) {
        select(metal)
        if Genre.shared.rockMetal != true {
            Genre.shared.rockMetal = true
        } else {
            Genre.shared.rockMetal = false
        }
    }
    
    @IBAction func selectRnb(_ sender: Any) {
        select(rnb)
        if Genre.shared.rbSoul != true {
            Genre.shared.rbSoul = true
        } else {
            Genre.shared.rbSoul = false
        }
    }
    
    @IBAction func selectAcoustic(_ sender: Any) {
        select(acoustic)
        if Genre.shared.forkAcoustic != true {
            Genre.shared.forkAcoustic = true
        } else {
            Genre.shared.forkAcoustic = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ageBtn.delegate = self
        ageBtn.tintColor = .clear // 커서 깜빡임 해결
        
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
            sender?.tintColor = UIColor.darkGray
        }
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
        ageBtn.text = ages[row]
    }
    
    func createPickerView(tagNo: Int) {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        ageBtn.inputView = pickerView
    }
    
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let button = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(doneBtn(_sender:)))
        toolBar.setItems([space, button], animated: true)
        toolBar.isUserInteractionEnabled = true
        ageBtn.inputAccessoryView = toolBar
    }
    
    @objc func doneBtn(_sender: Any) {
        self.view.endEditing(true)
    }
    
//    func signUp (userId: String, pwd: String, name: String, age: String, imgData: UIImage?) {
//        // 헤더 작성 (Content-type 지정)
//        let header: HTTPHeaders = [ "Content-Type" : "multipart/form-data" ]
//
//        // 파라미터
//        let params: Parameters = [
//            "user_id": userId,
//            "pwd": pwd,
//            "name": name,
//            "age": age
//        ]
//
//        print("파라미터 : \(params)")
//
//        AF.upload(multipartFormData: { MultipartFormData in
//            for (key, value) in params {
//            MultipartFormData.append("\(value)".data(using: .utf8, allowLossyConversion: false)!, withName: key)
//                print("추가: \(value)")
//        }
//            // 이미지 추가 (이미지가 비어 있을 경우 고려)
//            if let image = imgData?.jpegData(compressionQuality: 1) {
//                MultipartFormData.append(image, withName: "img", fileName: "\(name).jpg", mimeType: "image/jpg")
//            }
//        }, to: APIConstants.userSignUpURL, usingThreshold: UInt64.init(), method: .post, headers: header)
//        .validate(statusCode: 200..<299).responseData { response in
//            switch response.result {
//            case .success(_):
//                print("회원가입 성공!")
//            case .failure(let err):
//                print("실패: \(err)")
//            }
//        }
//    }
    
    func saveGenre() {
        let params: Parameters = [
            "memberId": Member.shared.user_id ?? "",
            "indie": Genre.shared.indie ?? false,
            "balad": Genre.shared.balad ?? false,
            "rockMetal": Genre.shared.rockMetal ?? false,
            "dancePop": Genre.shared.dancePop ?? false,
            "rapHiphop": Genre.shared.rapHiphop ?? false,
            "rbSoul": Genre.shared.rbSoul ?? false,
            "forkAcoustic": Genre.shared.forkAcoustic ?? false
        ]
        
        print(params)
        
        AF.request(APIConstants.genreURL,
                   method: .post,
                   parameters: params,
                   encoding: JSONEncoding.default,
                   headers: nil)
        .validate(statusCode: 200 ..< 299).responseData { response in
            switch response.result {
            case .success(let data):
                print(data)
                print("선호 장르 저장 완료!")
            case .failure(let error):
                print(error)
            }
        }
    }

}
