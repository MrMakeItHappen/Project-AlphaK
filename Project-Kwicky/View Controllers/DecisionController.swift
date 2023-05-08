//
//  ViewController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 2/8/23.
//

import UIKit

final class DecisionController: BaseViewController {//final - no outside access

    var animationSpeed : CGFloat = 0.08 //make speeds, tints etc global so the application feels the same
    
    //mimic the launch screen logo
    let logo: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "KwiksLogo02")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        return imageView
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backButtonTitle = ""
        self.layoutUI()
        
        //setting here and in app delegate
        _globalDeviceWidth = UIScreen.main.bounds.width
        _globalDeviceHeight = UIScreen.main.bounds.height
        
        //user onboarding model only
        userOnboardingStruct = UserOnboardingStruct()//reset model
        userProfileStruct = UserProfileStruct()//reset model
        
        //check for authentication - stored jwt token in user pref fetched from verify
        ServerKit().onAuth { hasAuth in
            
            if hasAuth {//user has auth - show animation and load user model then tabbarview
                self.logoAnimationTwo { isComplete in
                        ServerKit().onUserModelInitialFill { isComplete in
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                self.perform(#selector(self.handleTabView), with: nil, afterDelay: 0.1)
                        }
                    }
                }
            } else { //user has no auth, animation then simple controller for email/phone selection
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.logoAnimationTwo { isComplete in
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.handleSimpleLoginController()
                        }
                    }
                }
            }
        }
    }
}

//Mark: - Layout UI
extension DecisionController {
   
    private func layoutUI() {
        
        //needs to mimic launch screen
        self.view.addSubview(self.logo)
        self.logo.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 44).isActive = true
        self.logo.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -44).isActive = true
        self.logo.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0).isActive = true
        self.logo.heightAnchor.constraint(equalToConstant: 128).isActive = true
      
    }
    
    //TODO: - basic anim as a filler, needs something better
    @objc func logoAnimationTwo(completion : @escaping ( _ isComplete : Bool)->()) {
        UIView.animate(withDuration: self.animationSpeed, delay: 0, options: .curveEaseIn) {
            UIDevice.vibrateLight()
            self.logo.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        } completion: { complete in
            UIView.animate(withDuration: self.animationSpeed, delay: 0, options: .curveEaseIn) {
                self.logo.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            } completion: { complete in
                UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn) {
                    ///delay
                } completion: { complete in
                    ///vibrate here now
                    UIView.animate(withDuration: self.animationSpeed, delay: 0, options: .curveEaseIn) {
                        UIDevice.vibrateLight()
                        self.logo.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                    } completion: { complete in
                        completion(true)
                    }
                }
            }
        }
    }
}

//MARK: - @objc
extension DecisionController {
    
    //handle simple login if auth is nil (jwt is nil || null from server)
    @objc func handleSimpleLoginController() {
        DispatchQueue.main.async {
            let simpleLoginController = SimpleLoginController()
            let nav = UINavigationController(rootViewController: simpleLoginController)
            nav.modalPresentationStyle = .fullScreen
            self.navigationController?.present(nav, animated: true)
        }
    }
    
    //this is the tab bar
    @objc func handleTabView() {
        DispatchQueue.main.async {
            let tabViewController = TabViewController()
            let nav = UINavigationController(rootViewController: tabViewController)
            nav.navigationBar.isHidden = true
            nav.modalPresentationStyle = .fullScreen
            self.navigationController?.present(nav, animated: true)
        }
    }
}



//graveyard
//private let onboardImageView: UIImageView = {
//    let imageView = UIImageView()
//    imageView.translatesAutoresizingMaskIntoConstraints = false
//    imageView.backgroundColor = .clear
//    imageView.contentMode = .scaleAspectFit
//    imageView.isUserInteractionEnabled = false
//    imageView.backgroundColor = .clear
//    imageView.layer.masksToBounds = true
//    imageView.layer.cornerRadius = 0
//    imageView.height(374)
//    imageView.width(374)
//
//    let image = UIImage(named: "OnboardImage01")
//    imageView.image = image
//    return imageView
//}()
//
//private let ellipseOneImageView: UIImageView = {
//    let imageView = UIImageView()
//    imageView.translatesAutoresizingMaskIntoConstraints = false
//    imageView.backgroundColor = .clear
//    imageView.contentMode = .scaleAspectFit
//    imageView.isUserInteractionEnabled = false
//    imageView.backgroundColor = .clear
//    imageView.layer.masksToBounds = true
//    imageView.layer.cornerRadius = 0
//    imageView.height(298)
//    imageView.width(298)
//    imageView.layer.opacity = 0.35
//
//    let image = UIImage(named: "Ellipse 2")
//    imageView.image = image
//    return imageView
//}()
//
//private let ellipseTwoImageView: UIImageView = {
//    let imageView = UIImageView()
//    imageView.translatesAutoresizingMaskIntoConstraints = false
//    imageView.backgroundColor = .clear
//    imageView.contentMode = .scaleAspectFit
//    imageView.isUserInteractionEnabled = false
//    imageView.backgroundColor = .clear
//    imageView.layer.masksToBounds = true
//    imageView.layer.cornerRadius = 0
//    imageView.height(394)
//    imageView.width(394)
//    imageView.layer.opacity = 0.3
//
//    let image = UIImage(named: "Ellipse 3")
//    imageView.image = image
//    return imageView
//}()
//
//private let ellipseThreeImageView: UIImageView = {
//    let imageView = UIImageView()
//    imageView.translatesAutoresizingMaskIntoConstraints = false
//    imageView.backgroundColor = .clear
//    imageView.contentMode = .scaleAspectFit
//    imageView.isUserInteractionEnabled = false
//    imageView.backgroundColor = .clear
//    imageView.layer.masksToBounds = true
//    imageView.layer.cornerRadius = 0
//    imageView.height(490)
//    imageView.width(490)
//    imageView.layer.opacity = 0.2
//
//    let image = UIImage(named: "Ellipse 4")
//    imageView.image = image
//    return imageView
//}()
//
//private let titleLabel: UILabel = {
//    let label = UILabel()
//    label.translatesAutoresizingMaskIntoConstraints = false
//    label.backgroundColor = .clear
//    label.font = UIFont.segoeUIBold(size: 46)
//    label.numberOfLines = 2
//    label.textAlignment = .left
//    label.textColor = UIColor.white
//
//    var paragraphStyle = NSMutableParagraphStyle()
//    paragraphStyle.lineHeightMultiple = 0.87
//    label.attributedText = NSMutableAttributedString(string: "Easy Way to Earn Cash", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
//    return label
//}()
//
//private let subTitleLabel: UILabel = {
//    let label = UILabel()
//    label.translatesAutoresizingMaskIntoConstraints = false
//    label.backgroundColor = .clear
//    label.font = UIFont.segoeUISemiBold(size: 15)
//    label.numberOfLines = 2
//    label.textAlignment = .left
//    label.textColor = UIColor.white
//    label.adjustsFontSizeToFitWidth = true
//
//    var paragraphStyle = NSMutableParagraphStyle()
//    paragraphStyle.lineHeightMultiple = 1.13
//    label.attributedText = NSMutableAttributedString(string: "Kwiks a Revolutionary way to earn money from your videos directly and avoid middlemen", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
//    return label
//}()
//
//private lazy var nextButton: UIButton = {
//    let buttonHeight: CGFloat = 58
//    var configuaration = UIButton.Configuration.plain()
//    configuaration.image = UIImage(named: "Back Icon")
//
//    let button = UIButton(configuration: configuaration, primaryAction: UIAction(handler: { _ in
//        self.didTapNext()
//    }))
//    button.translatesAutoresizingMaskIntoConstraints = false
//    button.layer.cornerRadius = 0
//    button.layer.masksToBounds = true
//    button.backgroundColor = .white
//    button.height(buttonHeight)
//    button.width(buttonHeight)
//    button.layer.cornerRadius = buttonHeight / 2
//    return button
//}()

//
//self.view.addSubview(self.ellipseThreeImageView)
//self.ellipseThreeImageView.topToSuperview(offset: 40)
//self.ellipseThreeImageView.centerXToSuperview()
//
//self.view.addSubview(self.ellipseTwoImageView)
//self.ellipseTwoImageView.centerX(to: self.ellipseThreeImageView)
//self.ellipseTwoImageView.centerY(to: self.ellipseThreeImageView)
//
//self.view.addSubview(self.ellipseOneImageView)
//self.ellipseOneImageView.centerX(to: self.ellipseTwoImageView)
//self.ellipseOneImageView.centerY(to: self.ellipseTwoImageView)
//
//self.view.addSubview(self.onboardImageView)
//self.onboardImageView.centerX(to: self.ellipseOneImageView)
//self.onboardImageView.centerY(to: self.ellipseOneImageView)
//
//self.view.addSubview(self.titleLabel)
//self.titleLabel.topToBottom(of: self.ellipseThreeImageView, offset: 10)
//self.titleLabel.leftToSuperview(offset: 40)
//self.titleLabel.rightToSuperview(offset: -40)
//
//self.view.addSubview(self.subTitleLabel)
//self.subTitleLabel.topToBottom(of: self.titleLabel, offset: 14)
//self.subTitleLabel.leftToSuperview(offset: 40)
//self.subTitleLabel.rightToSuperview(offset: -28)
//
//self.view.addSubview(self.nextButton)
//self.nextButton.topToBottom(of: self.subTitleLabel, offset: 25)
//self.nextButton.left(to: self.subTitleLabel)
//private func addHoverAnimation() {
//    let hover = CABasicAnimation(keyPath: "position")
//
//    hover.isAdditive = true
//    hover.fromValue = NSValue(cgPoint: CGPoint.zero)
//    hover.toValue = NSValue(cgPoint: CGPoint(x: 0.0, y: 9.0))
//    hover.autoreverses = true
//    hover.duration = 2
//    hover.repeatCount = Float.infinity
//    hover.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
//
//    self.onboardImageView.layer.add(hover, forKey: "myHoverAnimation")
//}
//private func addGradientBackground() {
//    let gradientLayer = CAGradientLayer()
//    gradientLayer.colors = [
//        UIColor(red: 0.537, green: 0.839, blue: 0.345, alpha: 1).cgColor,
//        UIColor(red: 0.443, green: 0.733, blue: 0.259, alpha: 1).cgColor
//    ]
//    gradientLayer.locations = [0, 1]
//    gradientLayer.startPoint = CGPoint(x: 0.25, y: 0.5)
//    gradientLayer.endPoint = CGPoint(x: 0.75, y: 0.5)
//    gradientLayer.bounds = view.bounds.insetBy(dx: -0.5*view.bounds.size.width, dy: -0.5*view.bounds.size.height)
//    gradientLayer.position = view.center
//    self.background.layer.addSublayer(gradientLayer)
//
//    self.view.addSubview(self.background)
//    self.background.edgesToSuperview()
//}
