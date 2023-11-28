//
//  SceneDelegate.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/04/11.
//

import UIKit
import GoogleSignIn

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func presentAlertFromCurrentViewController(title: String, message: String) {
        guard let rootViewController = self.window?.rootViewController else { return }
        var currentViewController = rootViewController
        
        while let presentedViewController = currentViewController.presentedViewController {
            currentViewController = presentedViewController
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .cancel, handler: nil)
        alert.addAction(okAction)
        
        currentViewController.present(alert, animated: true, completion: nil)
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else { return }
        let _ = GIDSignIn.sharedInstance.handle(url)
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "LoadingVC")
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = initialViewController
        window?.makeKeyAndVisible()
        
        if let userId = UserDefaults.standard.string(forKey: "user_id") {
            if userId.contains("@gmail.com") {
                // 구글 자동 로그인
                GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
                    if user != nil && error == nil {
                        // 토큰 갱신해 주기
                        guard let userId = UserDefaults.standard.string(forKey: "user_id") else { return }
                        guard let pwd = UserDefaults.standard.string(forKey: "pwd") else { return }
                        SignService.shared.signIn(userId: userId, pwd: pwd) { response in
                            switch response {
                            case .success(let data):
                                if let data = data as? DataModel {
                                    print("로그인 결과 :: \(data.result)")
                                    let dataSave = UserDefaults.standard
                                    // 새로 갱신된 token 저장
                                    dataSave.setValue(data.data, forKey: "token")
                                    dataSave.synchronize()
                                    
                                    DispatchQueue.main.async {
                                        let newRootVC = storyboard.instantiateViewController(withIdentifier: "TabBarVC")
                                        self.window?.rootViewController = newRootVC
                                        self.window?.makeKeyAndVisible()
                                    }
                                }
                            case .requestErr:
                                print("로그인 결과 :: Request Err")
                                DispatchQueue.main.async {
                                    let loginViewController = storyboard.instantiateViewController(withIdentifier: "FirstVC")
                                    self.window?.rootViewController = loginViewController
                                    self.window?.makeKeyAndVisible()
                                    self.presentAlertFromCurrentViewController(title: "오류 발생", message: "잠시 후 다시 시도해 주세요")
                                }
                            case .pathErr:
                                print("로그인 결과 :: decode 실패")
                                DispatchQueue.main.async {
                                    let loginViewController = storyboard.instantiateViewController(withIdentifier: "FirstVC")
                                    self.window?.rootViewController = loginViewController
                                    self.window?.makeKeyAndVisible()
                                    self.presentAlertFromCurrentViewController(title: "오류 발생", message: "잠시 후 다시 시도해 주세요")
                                }
                            case .serverErr:
                                print("로그인 결과 :: Server Err")
                                DispatchQueue.main.async {
                                    let loginViewController = storyboard.instantiateViewController(withIdentifier: "FirstVC")
                                    self.window?.rootViewController = loginViewController
                                    self.window?.makeKeyAndVisible()
                                    self.presentAlertFromCurrentViewController(title: "서버 오류", message: "잠시 후 다시 시도해 주세요")
                                }
                            case .networkFail:
                                print("로그인 결과 :: Network Err")
                                DispatchQueue.main.async {
                                    let loginViewController = storyboard.instantiateViewController(withIdentifier: "FirstVC")
                                    self.window?.rootViewController = loginViewController
                                    self.window?.makeKeyAndVisible()
                                    self.presentAlertFromCurrentViewController(title: "네트워크 오류", message: "잠시 후 다시 시도해 주세요")
                                }
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            let loginViewController = storyboard.instantiateViewController(withIdentifier: "FirstVC")
                            self.window?.rootViewController = loginViewController
                            self.window?.makeKeyAndVisible()
                        }
                    }
                }
            } else {
                // 토큰 갱신해 주기
                guard let userId = UserDefaults.standard.string(forKey: "user_id") else { return }
                guard let pwd = UserDefaults.standard.string(forKey: "pwd") else { return }
                
                SignService.shared.signIn(userId: userId, pwd: pwd) { response in
                    switch response {
                    case .success(let data):
                        if let data = data as? DataModel {
                            print("로그인 결과 :: \(data.result)")
                            let dataSave = UserDefaults.standard
                            // 새로 갱신된 token 저장
                            dataSave.setValue(data.data, forKey: "token")
                            dataSave.synchronize()
                            
                            DispatchQueue.main.async {
                                let newRootVC = storyboard.instantiateViewController(withIdentifier: "TabBarVC")
                                self.window?.rootViewController = newRootVC
                                self.window?.makeKeyAndVisible()
                            }
                        }
                    case .requestErr:
                        print("로그인 결과 :: Request Err")
                        DispatchQueue.main.async {
                            let loginViewController = storyboard.instantiateViewController(withIdentifier: "FirstVC")
                            self.window?.rootViewController = loginViewController
                            self.window?.makeKeyAndVisible()
                            self.presentAlertFromCurrentViewController(title: "오류 발생", message: "잠시 후 다시 시도해 주세요")
                        }
                    case .pathErr:
                        print("로그인 결과 :: decode 실패")
                        DispatchQueue.main.async {
                            let loginViewController = storyboard.instantiateViewController(withIdentifier: "FirstVC")
                            self.window?.rootViewController = loginViewController
                            self.window?.makeKeyAndVisible()
                            self.presentAlertFromCurrentViewController(title: "오류 발생", message: "잠시 후 다시 시도해 주세요")
                        }
                    case .serverErr:
                        print("로그인 결과 :: Server Err")
                        DispatchQueue.main.async {
                            let loginViewController = storyboard.instantiateViewController(withIdentifier: "FirstVC")
                            self.window?.rootViewController = loginViewController
                            self.window?.makeKeyAndVisible()
                            self.presentAlertFromCurrentViewController(title: "서버 오류", message: "잠시 후 다시 시도해 주세요")
                        }
                    case .networkFail:
                        print("로그인 결과 :: Network Err")
                        DispatchQueue.main.async {
                            let loginViewController = storyboard.instantiateViewController(withIdentifier: "FirstVC")
                            self.window?.rootViewController = loginViewController
                            self.window?.makeKeyAndVisible()
                            self.presentAlertFromCurrentViewController(title: "네트워크 오류", message: "잠시 후 다시 시도해 주세요")
                        }
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                let loginViewController = storyboard.instantiateViewController(withIdentifier: "FirstVC")
                self.window?.rootViewController = loginViewController
                self.window?.makeKeyAndVisible()
            }
        }
            
        
        func sceneDidDisconnect(_ scene: UIScene) {
            // Called as the scene is being released by the system.
            // This occurs shortly after the scene enters the background, or when its session is discarded.
            // Release any resources associated with this scene that can be re-created the next time the scene connects.
            // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
        }
        
        func sceneDidBecomeActive(_ scene: UIScene) {
            // Called when the scene has moved from an inactive state to an active state.
            // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        }
        
        func sceneWillResignActive(_ scene: UIScene) {
            // Called when the scene will move from an active state to an inactive state.
            // This may occur due to temporary interruptions (ex. an incoming phone call).
        }
        
        func sceneWillEnterForeground(_ scene: UIScene) {
            // Called as the scene transitions from the background to the foreground.
            // Use this method to undo the changes made on entering the background.
        }
        
        func sceneDidEnterBackground(_ scene: UIScene) {
            // Called as the scene transitions from the foreground to the background.
            // Use this method to save data, release shared resources, and store enough scene-specific state information
            // to restore the scene back to its current state.
        }
    }
}
