//
//  SceneDelegate.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 2/8/23.
//

import UIKit
import TinyConstraints

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let sceneWindow = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: sceneWindow)
        
//        let decisionController = DecisionController()
        let decisionController = TabViewController()
//        let navigationController = UINavigationController(rootViewController: decisionController)
//        navigationController.navigationBar.isHidden = true
//        navigationController.modalPresentationStyle = .fullScreen

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .clear
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.titleTextAttributes = [.font : UIFont.segoeUISemiBold(size: 12)]
        appearance.shadowColor = .clear

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().tintColor = .white

        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.tabBarGrey], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.black], for: .selected)
        
//        window.rootViewController = navigationController
        window.rootViewController = decisionController
        window.makeKeyAndVisible()
        self.window = window
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

