//
//  WriteViewController.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/05/02.
//

import UIKit
import Alamofire

class WriteViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UITextViewDelegate {
    
    let weather = ["☀️ 맑았어요", "☁️ 흐렸어요", "🌧️ 비가 내렸어요", "🌨️ 눈이 내렸어요"]
    var selectWeather = ""
    
    @IBOutlet var diaryTitle: UITextField!
    @IBOutlet var weatherField: UITextField!
    @IBOutlet var textView: UITextView!
    @IBOutlet var datePicker: UIDatePicker!
    
    var pickerView = UIPickerView()
    
    // 작성 navigation bar item
    lazy var writeButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "작성", style: .plain, target: self, action: #selector(writeDiary(_:)))

        button.tintColor = UIColor.white
        return button
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MyTapMethod))

        singleTapGestureRecognizer.numberOfTapsRequired = 1

        singleTapGestureRecognizer.isEnabled = true

        singleTapGestureRecognizer.cancelsTouchesInView = false

        self.view.addGestureRecognizer(singleTapGestureRecognizer)
    
        self.navigationItem.rightBarButtonItem = writeButton
        
        weatherField.delegate = self
        weatherField.tintColor = .clear // 커서 깜빡임 해결
        
        textView.layer.masksToBounds = true
        textView.clipsToBounds = true
        
        // textview에 delegate 상속
        textView.delegate = self
        
        // 처음 화면이 로드되었을 때 플레이스 홀더처럼 보이게끔 만들어 주기
        textView.text = "오늘 하루 어떤 일이 있으셨나요? 🙂"
        textView.textColor = UIColor.lightGray

        // 테두리 없애기
        textView.layer.borderColor = UIColor.systemBackground.cgColor
        
        
        createPickerView(tagNo: 1)
        dismissPickerView()
    }
    
    @objc func writeDiary(_ sender: Any) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        // 다이어리 저장
        let params: Parameters = [
            //"userId": UserDefaults.standard.string(forKey: "user_id")!,
            "userId": "2020111396@gmail.com",
            "title": diaryTitle.text!,
            "content": textView.text!,
            "date": dateFormatter.string(from: datePicker.date),
            "weather": weatherField.text!,
            "musicTitle": "Spicy",
            "musicSinger": "Aespa",
            "musicImg": "www.aaa.com",
            "mood_result": "사랑/기쁨"
        ]
        
        print(params)
        
        // 서버와 통신
//        AF.request("http://54.180.220.34:8080/create/diary",
//                   method: .post,
//                   parameters: params,
//                   encoding: JSONEncoding.default,
//                   headers: nil)
//        .validate(statusCode: 200 ..< 299).responseData { response in
//            switch response.result {
//            case .success(_):
//                print("일기 저장 완료!")
//
//            case .failure(let error):
//                print(error)
//            }
//        }
        
        // 노래 추천 화면으로 이동
        guard let vcName = self.storyboard?.instantiateViewController(withIdentifier: "RecommendVC") else { return }
        self.navigationController?.pushViewController(vcName, animated: true)
    }
        
    @objc func MyTapMethod(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
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
    
    // 텍스트뷰에 입력이 시작되면 플레이스 홀더 지우고 폰트 색상 검정으롭 변경
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    @objc func doneBtn(_sender: Any) {
        self.view.endEditing(true)
    }

}
