//
//  EditViewController.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/05/16.
//

import UIKit

class ModifyViewController: UIViewController, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var selectAge: UITextField!
    @IBOutlet var script1: UILabel!
    @IBOutlet var genreLabel: UILabel!
    @IBOutlet var script2: UILabel!
    @IBOutlet var ageLabel: UILabel!
    @IBOutlet var recommendLabel: UILabel!
    
    
    @IBOutlet var dancePop: CSButton!
    @IBOutlet var balad: CSButton!
    @IBOutlet var hiphop: CSButton!
    @IBOutlet var indie: CSButton!
    @IBOutlet var metal: CSButton!
    @IBOutlet var rnb: CSButton!
    @IBOutlet var acoustic: CSButton!
    
    var isGenreModify = false
    
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
    
    @IBAction func saveBtn(_ sender: Any) {
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
    
    let ages = ["10대", "20대", "30대", "40대", "50대 이상"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ageLabel.attributedText = NSMutableAttributedString(string: ageLabel.text!, attributes: [NSAttributedString.Key.kern: -0.7, NSAttributedString.Key.font: UIFont(name: "Pretendard-SemiBold", size: 14)!])
        recommendLabel.attributedText = NSMutableAttributedString(string: recommendLabel.text!, attributes: [NSAttributedString.Key.kern: -0.7, NSAttributedString.Key.font: UIFont(name: "Pretendard-SemiBold", size: 14)!])
        
        script1.attributedText = NSMutableAttributedString(string: script1.text!, attributes: [NSAttributedString.Key.kern: -0.7, NSAttributedString.Key.font: UIFont(name: "Pretendard-Medium", size: 13)!])
        
        genreLabel.attributedText = NSAttributedString(string: "선호하는 장르", attributes: [NSAttributedString.Key.kern: -0.7, NSAttributedString.Key.font: UIFont(name: "Pretendard-Bold", size: 19)!])
        
        script2.attributedText = NSMutableAttributedString(string: script2.text!, attributes: [NSAttributedString.Key.kern: -0.7, NSAttributedString.Key.font: UIFont(name: "Pretendard-Medium", size: 14)!])
        
        Genre.shared.balad = false
        Genre.shared.dancePop = false
        Genre.shared.forkAcoustic = false
        Genre.shared.indie = false
        Genre.shared.rapHiphop = false
        Genre.shared.rbSoul = false
        Genre.shared.rockMetal = false
        
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
}
