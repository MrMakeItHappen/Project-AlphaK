//
//  TabViewController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 2/19/23.
//

import UIKit

final class TabViewController: UITabBarController {
    private let homeController = HomeController()
    private let videoController = VideoController()
    private let searchController = SearchController()
    private let inboxController = InboxController()
    private let walletController = WalletController()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.configureTabIcons()
    }

}
//MARK: - Configure
extension TabViewController {
    private func configure() {
        self.tabBar.backgroundColor = .kwiksBackgroundBlack
        self.tabBar.backgroundImage = UIImage()
        self.tabBar.shadowImage = UIImage()
    }
    
    private func configureTabIcons() {
        let adjustedImageSize = CGSize(width: 23, height: 23)

        //First Tab
        let tabOneIcon = UIImage(named: "KwiksLogoIcon")?.resized(to: CGSize(width: 40, height: 40)).withTintColor(.tabBarGrey).withRenderingMode(.alwaysOriginal)
        let tabOneFillIcon = UIImage(named: "KwiksLogoIcon")?.resized(to: CGSize(width: 40, height: 40)).withTintColor(.kwiksGreen).withRenderingMode(.alwaysOriginal)
        
        let tabOne = UINavigationController(rootViewController: homeController)
        tabOne.navigationBar.isHidden = true
        tabOne.tabBarItem = UITabBarItem(title: "Home", image: tabOneIcon, selectedImage: tabOneFillIcon)
        tabOne.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: 0, right: 0)

        //Second Tab
        let tabTwoIcon = UIImage(named: "SearchIcon")?.resized(to: CGSize(width: 30, height: 30)).withTintColor(.tabBarGrey).withRenderingMode(.alwaysOriginal)
        let tabTwoFillIcon = UIImage(named: "SearchIcon")?.resized(to: CGSize(width: 30, height: 30)).withTintColor(.kwiksGreen).withRenderingMode(.alwaysOriginal)

        let tabTwo = UINavigationController(rootViewController: searchController)
        tabTwo.navigationBar.isHidden = true
        tabTwo.tabBarItem = UITabBarItem(title: "Search", image: tabTwoIcon, selectedImage: tabTwoFillIcon)
        tabTwo.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 2, right: 4)

        //Third Tab
        let tabThreeIcon = UIImage(named: "VideoTabBarIcon")?.resized(to: CGSize(width: 60, height: 60)).withTintColor(.tabBarGrey).withRenderingMode(.alwaysOriginal)
        let tabThreeFillIcon = UIImage(named: "VideoTabBarIcon")?.resized(to: CGSize(width: 60, height: 60)).withTintColor(.kwiksGreen).withRenderingMode(.alwaysOriginal)

        let tabThree = UINavigationController(rootViewController: videoController)
        tabThree.navigationBar.isHidden = true
        tabThree.tabBarItem = UITabBarItem(title: "", image: tabThreeIcon, selectedImage: tabThreeFillIcon)
        tabThree.tabBarItem.imageInsets = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
        
        //Fourth Tab
        let tabFourIcon = UIImage(named: "InboxTabBarIcon")?.resized(to: adjustedImageSize).withTintColor(.tabBarGrey).withRenderingMode(.alwaysOriginal)
        let tabFourFillIcon = UIImage(named: "InboxTabBarIcon")?.resized(to: adjustedImageSize).withTintColor(.kwiksGreen).withRenderingMode(.alwaysOriginal)

        let tabFour = UINavigationController(rootViewController: inboxController)
        tabFour.navigationBar.isHidden = true
        tabFour.tabBarItem = UITabBarItem(title: "Inbox", image: tabFourIcon, selectedImage: tabFourFillIcon)
        tabFour.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        //Fifth Tab
        let tabFiveIcon = UIImage(named: "WalletTabBarIcon")?.resized(to: adjustedImageSize).withTintColor(.tabBarGrey).withRenderingMode(.alwaysOriginal)
        let tabFiveFillIcon = UIImage(named: "WalletTabBarIcon")?.resized(to: adjustedImageSize).withTintColor(.kwiksGreen).withRenderingMode(.alwaysOriginal)
        
        let tabFive = UINavigationController(rootViewController: walletController)
        tabFive.navigationBar.isHidden = true
        tabFive.tabBarItem = UITabBarItem(title: "Wallet", image: tabFiveIcon, selectedImage: tabFiveFillIcon)
        tabFive.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        self.viewControllers = [tabOne, tabTwo, tabThree, tabFour, tabFive]
        self.switchTabs(tabIndex: 0)//starts at 0 by default
    }
}
//MARK: - Helpers
extension TabViewController {
    func switchTabs(tabIndex : Int) {
        self.selectedIndex = tabIndex
    }
}
