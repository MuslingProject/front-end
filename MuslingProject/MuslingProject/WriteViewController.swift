//
//  WriteViewController.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/05/02.
//

import UIKit

class WriteViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    let weather = ["☀️ 맑았어요", "☁️ 흐렸어요", "🌧️ 비가 내렸어요", "🌨️ 눈이 내렸어요"]
    var selectWeather = ""
    
    @IBOutlet var diaryTitle: UITextField!
    @IBOutlet var weatherField: UITextField!
    
    @IBAction func WriteBtn(_ sender: Any) {
        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "ResultVC")
        vcName?.modalPresentationStyle = .fullScreen
        vcName?.modalTransitionStyle = .crossDissolve
        self.present(vcName!, animated: true, completion: nil)
//        guard let vcName = self.storyboard?.instantiateViewController(withIdentifier: "ResultVC") else { return }
//        self.navigationController?.pushViewController(vcName, animated: true)
    }
    
    var pickerView = UIPickerView()
    
//    lazy var writeButton: UIBarButtonItem = {
//        let button = UIBarButtonItem(title: "작성", style: .plain, target: self, action: #selector(writeDiary(_:)))
//        return button
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherField.delegate = self
        weatherField.tintColor = .clear // 커서 깜빡임 해결
        
        createPickerView(tagNo: 1)
        dismissPickerView()
        
        //self.writeButton.tintColor = UIColor.white
        //self.navigationItem.rightBarButtonItem = self.writeButton
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
    // 하나의 피커 뷰 안에 몇 개의 선택 가능한 리스트를 표시할 것인지
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return weather.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return weather[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        weatherField.text = weather[row]
    }
    
    func createPickerView(tagNo: Int) {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        weatherField.inputView = pickerView
    }
    
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let button = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(doneBtn(_sender:)))
        toolBar.setItems([space, button], animated: true)
        toolBar.isUserInteractionEnabled = true
        weatherField.inputAccessoryView = toolBar
    }
    
    @objc func doneBtn(_sender: Any) {
        self.view.endEditing(true)
    }
    
//    @objc func writeDiary(_ sender: Any) {
//        // 노래 추천 페이지로 이동 및 다이어리 저장
//        self.performSegue(withIdentifier: "ResultVC", sender: self)
//    }

}
