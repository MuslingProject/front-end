import UIKit

class TabBarVC: UITabBarController, UITabBarControllerDelegate {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateLabelColors()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.selectedIndex = 0
        
        if let items = tabBar.items {
            for (index, item) in items.enumerated() {
                // 기존 타이틀을 저장하고 숨깁니다.
                let originalTitle = item.title
                item.title = ""
                
                guard let view = item.value(forKey: "view") as? UIView else { continue }
                
                let label = UILabel()
                label.text = originalTitle
                label.font = UIFont(name: "Pretendard-Medium", size: 11)
                label.textAlignment = .center
                
                // 문자 간격 설정
                if let originalTitle = originalTitle {
                    let attributedString = NSMutableAttributedString(string: originalTitle)
                    attributedString.addAttribute(NSAttributedString.Key.kern, value: CGFloat(-0.6), range: NSRange(location: 0, length: attributedString.length))
                    
                    if self.selectedIndex == index {
                        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue01!, range: NSRange(location: 0, length: attributedString.length))
                    } else {
                        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.text02!, range: NSRange(location: 0, length: attributedString.length))
                    }
                    
                    label.attributedText = attributedString
                }
                
                label.sizeToFit()
                label.center = CGPoint(x: view.bounds.midX, y: view.bounds.maxY - label.bounds.midY + 3)
                
                view.addSubview(label)
            }
        }
        updateLabelColors()
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        updateLabelColors()
    }
    
    private func updateLabelColors() {
        if let items = tabBar.items {
            for (index, item) in items.enumerated() {
                guard let view = item.value(forKey: "view") as? UIView else { continue }
                
                // 레이블을 찾습니다.
                for subview in view.subviews {
                    if let label = subview as? UILabel {
                        if index == selectedIndex {
                            // 선택된 탭의 레이블 색상을 변경합니다.
                            let attributedString = NSMutableAttributedString(attributedString: label.attributedText!)
                            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue01!, range: NSRange(location: 0, length: attributedString.length))
                            label.attributedText = attributedString
                        } else {
                            // 다른 탭의 레이블 색상을 기본값으로 설정합니다.
                            let attributedString = NSMutableAttributedString(attributedString: label.attributedText!)
                            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.text02!, range: NSRange(location: 0, length: attributedString.length))
                            label.attributedText = attributedString
                        }
                    }
                }
            }
        }
        
    }
}


