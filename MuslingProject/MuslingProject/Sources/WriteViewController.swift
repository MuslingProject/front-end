//
//  WriteViewController.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/05/02.
//

import UIKit
import Alamofire

class WriteViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UITextViewDelegate {
    
    let weather = Category.weather
    var selectWeather = ""
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var weatherLabel: UILabel!
    
    @IBOutlet var diaryTitle: UITextField!
    @IBOutlet var weatherField: UITextField!
    @IBOutlet var textView: UITextView!
    @IBOutlet var datePicker: UIDatePicker!
    
    var pickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.attributedText = NSAttributedString(string: "제목", attributes: [NSAttributedString.Key.font: UIFont(name: "Pretendard-SemiBold", size: 16)!, NSAttributedString.Key.kern: -0.5])
        dateLabel.attributedText = NSAttributedString(string: "날짜", attributes: [NSAttributedString.Key.font: UIFont(name: "Pretendard-SemiBold", size: 16)!, NSAttributedString.Key.kern: -0.5])
        weatherLabel.attributedText = NSAttributedString(string: "날씨", attributes: [NSAttributedString.Key.font: UIFont(name: "Pretendard-SemiBold", size: 16)!, NSAttributedString.Key.kern: -0.5])
        
        // 커스텀 폰트
        let customFont = UIFont(name: "Pretendard-Medium", size: 16)
        
        // NSAttributedString을 사용하여 폰트 속성 설정
        let attributes: [NSAttributedString.Key: Any] = [
            .font: customFont as Any,
            .foregroundColor: UIColor.blue01!, // 원하는 텍스트 색상으로 설정
            .kern: -0.4
        ]
        
        // UIBarButtonItem 생성 및 타이틀 설정
        let barButtonItem = UIBarButtonItem(title: "작성", style: .plain, target: self, action: #selector(writeDiary(_:)))
        barButtonItem.setTitleTextAttributes(attributes, for: .normal) // NSAttributedString 설정
        navigationItem.rightBarButtonItem = barButtonItem

        
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MyTapMethod))

        singleTapGestureRecognizer.numberOfTapsRequired = 1

        singleTapGestureRecognizer.isEnabled = true

        singleTapGestureRecognizer.cancelsTouchesInView = false

        self.view.addGestureRecognizer(singleTapGestureRecognizer)
        
        diaryTitle.attributedText = NSAttributedString(string: diaryTitle.text!, attributes: [NSAttributedString.Key.font: UIFont(name: "Pretendard-Medium", size: 15)!, NSAttributedString.Key.kern: -0.5])
        diaryTitle.attributedPlaceholder  = NSAttributedString(string: "제목을 입력하세요", attributes: [NSAttributedString.Key.font: UIFont(name: "Pretendard-Medium", size: 15)!, NSAttributedString.Key.kern: -0.5])
        
        weatherField.delegate = self
        weatherField.tintColor = .clear // 커서 깜빡임 해결
        weatherField.attributedPlaceholder = NSAttributedString(string: "선택하세요", attributes: [NSAttributedString.Key.font: UIFont(name: "Pretendard-Medium", size: 15)!, NSAttributedString.Key.kern: -0.5])
        
        textView.layer.masksToBounds = true
        textView.clipsToBounds = true
        
        // textview에 delegate 상속
        textView.delegate = self
        
        // 처음 화면이 로드되었을 때 플레이스 홀더처럼 보이게끔 만들어 주기
        textView.text = "오늘 하루 어떤 일이 있으셨나요? 🙂"
        textView.attributedText = NSAttributedString(string: textView.text!, attributes: [NSAttributedString.Key.font: UIFont(name: "Pretendard-Medium", size: 16)!, NSAttributedString.Key.kern: -0.5])
        textView.textColor = UIColor.lightGray

        // 테두리 없애기
        textView.layer.borderColor = UIColor.systemBackground.cgColor
        
        createPickerView(tagNo: 1)
        dismissPickerView()
    }
    
    @objc func writeDiary(_ sender: Any) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let title = diaryTitle.text else { return }
        let date = dateFormatter.string(from: datePicker.date)
        var weather = ""
        switch weatherField.text {
        case "☀️ 맑음": weather = "화창한 날"
        case "🌧️ 비/흐림": weather = "비/흐림"
        case "🌨️ 눈": weather = "눈오는 날"
        default: weather = "화창한 날"
        }
        guard let content = textView.text else { return }
        
        DiaryService.shared.saveDiary(title: title, date: date, weather: weather, content: content) { response in
            switch response {
            case .success(let data):
                if let data = data as? DiaryResponseModel {
                    print("기록 저장 결과 :: \(data.result)")
                    
                    // 노래 추천 화면으로 이동
                    guard let vcName = self.storyboard?.instantiateViewController(withIdentifier: "RecommendVC") as? RecommendViewController else { return }
                    vcName.recommendData = data.recommentdations
                    self.navigationController?.pushViewController(vcName, animated: true)
                }
            case .pathErr:
                print("기록 저장 결과 :: Path Err")
            case .networkFail:
                print("기록 저장 결과 :: Network Err")
            case .requestErr:
                print("기록 저장 결과 :: Request Err")
            case .serverErr:
                print("기록 저장 결과 :: Server Err")
            }
        }
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
        weatherField.attributedText = NSAttributedString(string: weather[row], attributes: [NSAttributedString.Key.font: UIFont(name: "Pretendard-Medium", size: 15)!, NSAttributedString.Key.kern: -0.5])
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
