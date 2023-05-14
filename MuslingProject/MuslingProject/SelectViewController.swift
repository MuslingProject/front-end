//
//  SelectViewController.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/04/12.
//

import UIKit

class SelectViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    let ages = ["10대", "20대", "30대", "40대", "50대 이상"]
    var selectAge = ""

    
    @IBOutlet var ageBtn: UITextField!
    @IBOutlet var label: UILabel!
    @IBOutlet var kpop: UIButton!
    @IBOutlet var balad: UIButton!
    @IBOutlet var hiphop: UIButton!
    @IBOutlet var inde: UIButton!
    @IBOutlet var metal: UIButton!
    @IBOutlet var rnb: UIButton!
    
    @IBAction func finishBtn(_ sender: UIButton) {
        // 홈으로 이동
        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC")
        vcName?.modalPresentationStyle = .fullScreen
        vcName?.modalTransitionStyle = .crossDissolve
        self.present(vcName!, animated: true, completion: nil)
    }
    
    @IBAction func selectKpop(_ sender: Any) {
        select(kpop)
    }
    
    @IBAction func selectBalad(_ sender: Any) {
        select(balad)
    }
    
    @IBAction func selectHiphop(_ sender: Any) {
        select(hiphop)
    }
    
    @IBAction func selectInde(_ sender: Any) {
        select(inde)
    }
    
    @IBAction func selectRock(_ sender: Any) {
        select(metal)
    }
    
    @IBAction func selectRnb(_ sender: Any) {
        select(rnb)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ageBtn.delegate = self
        ageBtn.tintColor = .clear // 커서 깜빡임 해결
        
        createPickerView(tagNo: 2)
        dismissPickerView()
        label.text = "당신의 취향에 맞게\n노래를 추천해 드릴게요 🎶"
        
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

}
