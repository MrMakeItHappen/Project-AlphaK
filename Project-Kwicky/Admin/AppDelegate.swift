//
//  AppDelegate.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 2/8/23.
//

import UIKit
import Mixpanel
import AVFoundation
import NotificationCenter
import SDWebImage

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UITabBarControllerDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        print("🟢 DEVICE HEIGHT WATCHER: \(_globalDeviceHeight)")
        
        //setting here and in decision controller
        _globalDeviceWidth = UIScreen.main.bounds.width//requires scene window now when you update
        _globalDeviceHeight = UIScreen.main.bounds.height
        
        //mixpanel integration - only track for production, no need to track debug keys
        if EnvironemntModeHelper.isCurrentEnvironmentDebug() {
            Mixpanel.initialize(token: "", trackAutomaticEvents: true)
        } else {
            Mixpanel.initialize(token: Statics.mixpanelAuthToken, trackAutomaticEvents: true)
            Mixpanel.mainInstance().loggingEnabled = false
        }
        
        //av with mixing for audio on bluetooth - video streaming, call comes in or connects to the car or audio speaker ie. Low Energy Bluetooth (LE)
        do {
            try AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default, options: [.mixWithOthers])
        } catch _ {
            print("catch")
        }
        
        // CONFIGURE PUSH NOTIFICATIONS
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: { _, _ in
            
        })
        
        //remote notes earlier to grab the token, fetch the device ID here also
        application.registerForRemoteNotifications()
        
        //this caches images for a select amounf of time for when we have images
        SDImageCache.shared.config.maxDiskAge = 3600 * 24 * 7 // 1 Week - 60 * 5 ///5 minutes// 3600 * 24 * 7 // 1 Week
        SDImageCache.shared.config.maxMemoryCost = 1024 * 1024 * 4 * 20 // 20 images (1024 * 1024 pixels)
        SDImageCache.shared.config.shouldCacheImagesInMemory = false // Disable memory cache, may cause cell-reusing flash because disk query is async
        SDImageCache.shared.config.shouldUseWeakMemoryCache = false // Disable weak cache, may see blank when return from background because memory cache is purged under pressure
        SDImageCache.shared.config.diskCacheReadingOptions = .mappedIfSafe // Use mmap for disk cache query
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        print(#function)
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        print(#function)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        if let nav = viewController as? UINavigationController {
            if nav.viewControllers.first is VideoController {
                let videoVC = VideoController()
                let navVC = UINavigationController(rootViewController: videoVC)
                navVC.modalPresentationStyle = .fullScreen
                navVC.navigationBar.isHidden = true

                nav.present(navVC, animated: true)
                return false
            }
        }
        return true
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    //this controls how the APSN show - app foreground can be blocked just before the completion if necessary
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions)
                                -> Void) {
        let _ = notification.request.content.userInfo // block here if necessary
        completionHandler([.badge, .sound, .banner])
    }
}

