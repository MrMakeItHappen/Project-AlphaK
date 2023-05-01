//
//  SceneDelegate.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 2/8/23.
//

import UIKit
import TinyConstraints
import Lottie

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let sceneWindow = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: sceneWindow)
        
//        let decisionController = AccountInfoController()
        let decisionController = SimpleLoginController()
//        let decisionController = TabViewController()
        let navigationController = UINavigationController(rootViewController: decisionController)
        navigationController.navigationBar.isHidden = true
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .clear
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.titleTextAttributes = [.font : UIFont.segoeUISemiBold(size: 12)]
        appearance.shadowColor = .clear

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().tintColor = .white
        
        UINavigationBar.appearance().backIndicatorImage = UIImage(named: "KwiksBackArrow")
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(named: "KwiksBackArrow")

        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .selected)
        UITabBar.appearance().barTintColor = .white
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
        
        // iPhone Dimensions
//        let height = UIScreen.main.bounds.height
//        let width = UIScreen.main.bounds.width
//
//        print("-Simulator Device Dimensions-\nDevice Height - \(height)\nDevice Width - \(width)")
    }

    func sceneDidDisconnect(_ scene: UIScene) { }
    func sceneDidBecomeActive(_ scene: UIScene) { }
    func sceneWillResignActive(_ scene: UIScene) { }
    func sceneWillEnterForeground(_ scene: UIScene) { }
    func sceneDidEnterBackground(_ scene: UIScene) { }
}

