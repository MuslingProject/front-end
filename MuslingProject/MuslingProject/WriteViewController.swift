//
//  WriteViewController.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/05/02.
//

import UIKit

class WriteViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let weather = ["☀️ 맑았어요", "☁️ 흐렸어요", "🌧️ 비가 내렸어요", "🌨️ 눈이 내렸어요"]
    var selectWeather = ""
    
    @IBOutlet var diaryTitle: UITextField!
    @IBOutlet var weatherField: UITextField!
    
    var pickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createPickerView(tagNo: 1)
        dismissPickerView()
        diaryTitle.underlined()
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
        let button = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(doneBtn(_sender:)))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        weatherField.inputAccessoryView = toolBar
    }
    
    @objc func doneBtn(_sender: Any) {
        self.view.endEditing(true)
    }

}
