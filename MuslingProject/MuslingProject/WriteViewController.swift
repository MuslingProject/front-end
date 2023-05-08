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
//        pickerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 220)
//        pickerView.delegate = self
//        pickerView.dataSource = self
//
//        // 피커뷰 툴바 추가
//        let pickerToolbar: UIToolbar = UIToolbar()
//        pickerToolbar.barStyle = .default
//        pickerToolbar.isTranslucent = true // 툴바가 반투명인지 여부
//        pickerToolbar.backgroundColor = .lightGray
//        pickerToolbar.sizeToFit() // 서브뷰만큼 툴바 크기를 맞춤
//
//        // 피커뷰 툴바에 확인/취소 버튼 추가
//        let btnDone = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(onPickDone))
//        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
//        let btnCancel = UIBarButtonItem(title: "취소", style: .done, target: self, action: #selector(onPickCancel))
//        // 버튼 추가
//        pickerToolbar.setItems([btnCancel, space, btnDone], animated: true)
//        // 사용자 클릭 이벤트 전달
//        pickerToolbar.isUserInteractionEnabled = true
//        // 피커 뷰 추가
//        weatherField.inputView = pickerView
//        // 피커뷰 툴바 추가
//        weatherField.inputAccessoryView = pickerToolbar
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
        let button = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(doneBtn(_sender:)))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        weatherField.inputAccessoryView = toolBar
    }
    
    @objc func doneBtn(_sender: Any) {
        self.view.endEditing(true)
    }

}
