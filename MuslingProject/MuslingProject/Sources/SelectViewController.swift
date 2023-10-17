//
//  SelectViewController.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/04/12.
//

import UIKit
import Alamofire

class SelectViewController: ExtensionVC, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    let ages = ["10대", "20대", "30대", "40대", "50대 이상"]
    
    weak var sv: UIView!
    
    @IBOutlet var ageBtn: UITextField!
    @IBOutlet var dancePop: CSButton!
    @IBOutlet var balad: CSButton!
    @IBOutlet var hiphop: CSButton!
    @IBOutlet var indie: CSButton!
    @IBOutlet var metal: CSButton!
    @IBOutlet var rnb: CSButton!
    @IBOutlet var acoustic: CSButton!
    @IBOutlet var recommend: UISwitch!
    
    @IBAction func selectRec(_ sender: Any) {
        if recommend.isOn {
            Member.shared.ageRec = true
            print(Member.shared.ageRec)
        } else {
            Member.shared.ageRec = false
            print(Member.shared.ageRec)
        }
    }
    
    @IBOutlet var label1: UILabel!
    
    @IBAction func finishBtn(_ sender: UIButton) {
        Member.shared.age = ageBtn.text
        if ageBtn.text == "" {
            let alert = UIAlertController(title: "연령대를 선택해 주세요", message: nil, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        } else {
            print(Member.shared.ageRec)
            signUpAPI()
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
        
        Member.shared.ageRec = true
        
        Genre.shared.balad = false
        Genre.shared.dancePop = false
        Genre.shared.forkAcoustic = false
        Genre.shared.indie = false
        Genre.shared.rapHiphop = false
        Genre.shared.rbSoul = false
        Genre.shared.rockMetal = false
        
        //ageBtn.delegate = self
        ageBtn.tintColor = .clear // 커서 깜빡임 해결
        
        createPickerView(tagNo: 2)
        dismissPickerView()
        
        label1.attributedText = NSMutableAttributedString(string: label1.text!, attributes: [NSAttributedString.Key.kern: -0.7])
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
    
    func saveGenre() {
        let genre = Genre.shared
        SignService.shared.saveGenre(indie: genre.indie, balad: genre.balad, rockMetal: genre.rockMetal, dancePop: genre.dancePop, rapHiphop: genre.rapHiphop, rbSoul: genre.rbSoul, forkAcoustic: genre.forkAcoustic) { response in
            switch response {
            case .success(let data):
                if let data = data as? GenreModel {
                    switch data.httpStatus {
                    case "OK":
                        print(data.result)
                        self.sv.removeFromSuperview()
                        self.goToMain()
                    default:
                        print("장르 저장 :: Ect Err")
                    }
                }
            case .requestErr:
                print("장르 저장 :: Request Err")
            case .pathErr:
                print("장르 저장 :: Path Err")
            case .serverErr:
                print("장르 저장 :: Server Err")
            case .networkFail:
                print("장르 저장 :: Network Err")
            }
        }
    }
    
    func signUpAPI() {        
        print(Member.shared)
        
        // 회원가입
        SignService.shared.signUp(member: Member.shared) { response in
            switch response {
            case .success(let key):
                if let data = key as? DataModel {
                    switch data.httpStatus {
                    case "OK":
                        print(data.result)
                        self.signInAPI()
                    default:
                        print(data.result)
                    }
                }
            case .pathErr:
                print("회원가입 결과 :: decode 실패")
            case .requestErr:
                print("회원가입 결과 :: Request Err")
            case .serverErr:
                print("회원가입 결과 :: Server Err")
            case .networkFail:
                print("회원가입 결과 :: Network Fail")
            }
        }
    }
    
    func signInAPI() {
        guard let id = Member.shared.user_id else { return }
        guard let pwd = Member.shared.pwd else { return }
        
        sv = UIViewController.displaySpinner(onView: self.view)
        
        // 로그인
        SignService.shared.signIn(userId: id, pwd: pwd) { response in
            switch response {
            case .success(let data):
                if let data = data as? DataModel {
                    print("로그인 결과 :: \(data.result)")
                    let dataSave = UserDefaults.standard
                    dataSave.setValue(data.data, forKey: "token")
                    dataSave.synchronize()
                    
                    // 장르 저장
                    self.saveGenre()
                }
            case .requestErr:
                print("로그인 결과 :: Request Err")
            case .pathErr:
                print("로그인 결과 :: decode 실패")
            case .serverErr:
                print("로그인 결과 :: Server Err")
            case .networkFail:
                print("로그인 결과 :: Network Err")
            }
        }
    }
    
    func goToMain() {
        // 홈으로 이동
        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC")
        vcName?.modalPresentationStyle = .fullScreen
        vcName?.modalTransitionStyle = .crossDissolve
        self.present(vcName!, animated: true, completion: nil)
        
        // 자동로그인 위해 UserDefaults에 저장
        let dataSave = UserDefaults.standard
        
        // 아이디, 비밀번호 저장
        dataSave.setValue(Member.shared.user_id, forKey: "user_id")
        dataSave.setValue(Member.shared.pwd, forKey: "pwd")
        UserDefaults.standard.synchronize()
    }

}
