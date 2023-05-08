//
//  SelectUsernameController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 2/19/23.
//

import UIKit
import KwiksSystemsPopups

final class SelectUsernameController: BaseViewController {
    private let availableIcon = UIImage(named: "CheckmarkSelected")
    private let unavailableIcon = UIImage(systemName: "x.circle.fill")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
    var isApproved:Bool = false
    let kwiksPopUp = KwiksSystemPopups()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Create username"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.interSemiBold(size: 32)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor.black
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Choose a username for your new account. You can always change it later."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.interRegular(size: 18)
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0.6392156863, green: 0.6392156863, blue: 0.6392156863, alpha: 1)
        return label
    }()
    
    private lazy var usernameTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        let placeholder = "ex. Kwiks"
        textField.placeholder = placeholder
        textField.textAlignment = .left
        textField.textColor = .black
        textField.font = UIFont.interMedium(size: 20)
        textField.autocorrectionType = .no
        textField.delegate = self
        textField.backgroundColor = UIColor(red: 0.958, green: 0.958, blue: 0.958, alpha: 1)
        textField.returnKeyType = .done
        textField.keyboardType = .namePhonePad
        textField.layer.cornerRadius = 10
        textField.leftViewMode = .always
        textField.layer.borderColor = UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 1).cgColor
        textField.layer.borderWidth = 1
        textField.clipsToBounds = true
        textField.layer.masksToBounds = true
        textField.height(60)
        textField.setLeftPaddingPoints(30)
        textField.setRightPaddingPoints(40)
        textField.addTarget(self, action: #selector(forceLowerCase(sender:)), for: .editingChanged)
        return textField
    }()
   
    private let checkmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 0
        imageView.height(20)
        imageView.width(20)
        return imageView
    }()
    
    private lazy var confirmButton: UIButton = {
        let icon = UIImage(named: "LoginIcon")
        var attributeContainer = AttributeContainer()
        attributeContainer.font = .interRegular(size: 16)
        
        var configuration = UIButton.Configuration.plain()
        configuration.cornerStyle = .capsule
        configuration.image = icon
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 10
        configuration.attributedTitle = AttributedString("Confirm", attributes: attributeContainer)
        
        let button = UIButton(configuration: configuration, primaryAction: UIAction(handler: { _ in
            self.didTapConfirm()
        }))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.backgroundColor = #colorLiteral(red: 0.7764705882, green: 0.7764705882, blue: 0.7764705882, alpha: 1)
        button.tintColor = .black
        button.layer.cornerRadius = 25
        button.height(50)
        button.isEnabled = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.enableConfirmButton(should: false)//default - not enabled
        self.layoutUI()
    }
}
//MARK: - Layout UI
extension SelectUsernameController {
    private func layoutUI() {
        self.view.addSubview(self.titleLabel)
        self.titleLabel.topToSuperview(offset: 126)
        self.titleLabel.leftToSuperview(offset: 40)
        
        self.view.addSubview(self.subTitleLabel)
        self.subTitleLabel.topToBottom(of: self.titleLabel, offset: 20)
        self.subTitleLabel.left(to: self.titleLabel)
        self.subTitleLabel.rightToSuperview(offset: -40)
        
        self.view.addSubview(self.usernameTextField)
        self.usernameTextField.topToBottom(of: self.subTitleLabel, offset: 55)
        self.usernameTextField.leftToSuperview(offset: 30)
        self.usernameTextField.rightToSuperview(offset: -30)
        
        self.view.addSubview(self.checkmarkImageView)
        self.checkmarkImageView.centerY(to: self.usernameTextField)
        self.checkmarkImageView.right(to: self.usernameTextField, offset: -20)
        
        self.view.addSubview(self.confirmButton)
        self.confirmButton.topToBottom(of: self.usernameTextField, offset: 30)
        self.confirmButton.left(to: self.usernameTextField)
        self.confirmButton.right(to: self.usernameTextField)
    }
}
//MARK: - @objc
extension SelectUsernameController {
   
    @objc func didTapConfirm() {
        //resignation()
        self.usernameTextField.resignFirstResponder()
        
        if isApproved {//bool to toggle whether request was good/bad
            
            self.mainLoadingScreen.callMainLoadingScreen(lottiAnimationName: Statics.mainLoadingScreen, isCentered: true)
            
            let full_name = userOnboardingStruct.full_name ?? "nil"
            let birthdate = userOnboardingStruct.birthdate ?? "nil"
            let email = userOnboardingStruct.email ?? "nil"
            let userName = userOnboardingStruct.user_name ?? "nil"
            
            var type:String = ""
            
            if full_name != "nil" &&
                birthdate != "nil" &&
                email != "nil" &&
                userName != "nil" {
                
                if _loginTrajectory == .fromEmail {
                    type="email"
                    userProfileStruct.email = email
                } else {
                    type="phone"
                    userProfileStruct.phone = email
                }
                
                let values : [String:String] = [
                    "name":full_name,
                    "\(type)":email,//this could be phone or email in the email node which has both :)
                    "birthdate":birthdate,
                    "username":userName,
                    "sign_up_method":type
                ]
                
                ServerKit().onUserObjectUpdate(values: values) { onSuccess, object in
                    
                    if onSuccess {//we are now fully finished, update the users real model and go to the tab bar view
                        self.mainLoadingScreen.cancelMainLoadingScreen()
                        
                        userProfileStruct.full_name = full_name
                        userProfileStruct.dob = birthdate
                        userProfileStruct.sign_up_method = type
                        userProfileStruct.user_name = userName
                        //model is filled manually since we are right here
                        self.handleHomeController()//tabbarview
                    } else {
                        self.mainLoadingScreen.cancelMainLoadingScreen()
                        Printer().print(message: "🔴 Server call failed to update user object after registration")
                        self.kwiksPopUp.copyDecision(popupType: .unknownError)
                    }
                }
                
            } else {
                Printer().print(message: "🔴 Data missing - 1")
                self.mainLoadingScreen.cancelMainLoadingScreen()
            }
        } else {
            Printer().print(message: "🔴 Data missing - 2")
            self.mainLoadingScreen.cancelMainLoadingScreen()
        }
    }
    
    //straight to the tab bar view now because we have authentication
    func handleHomeController() {
        print("trying to go to the home controller")
        DispatchQueue.main.async {
            UIDevice.vibrateLight()//small haptic vibe
            let tabViewController = TabViewController()
            let nav = UINavigationController(rootViewController: tabViewController)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true)
        }
    }
}

//MARK: - UITextField Delegates
//TODO: User tapping Done should dismiss keyboard and prsent next screen
extension SelectUsernameController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == self.usernameTextField {
            
            if (string == " ") {
                return false
            } else {
                let cs = NSCharacterSet(charactersIn: Statics.approved_username_characters).inverted//restrict to lower case, underscores and numbers/letters upper and lower only
                let filtered = string.components(separatedBy: cs).joined(separator: "")
                return (string == filtered)
            }
        }
        return true
    }
    
    //force lower and check for username after 3 every letter
    @objc func forceLowerCase(sender: UITextField) {
        
        if sender == self.usernameTextField {
            guard let text = self.usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else {return}
            if text.count > 0 {
                let lowerText = text.lowercased()
                self.usernameTextField.text = lowerText
                
                if text.count > 2 {
                    self.enableConfirmButton(should:true)
                    //start polling and using the activity/check
                    
                    let userNameToCheck = text
                    ServerKit().onUsernameVerify(passedUserName: userNameToCheck) { onSuccess, object in
                        
                        if !onSuccess {//failed
                            self.userNameFailed()
                            userOnboardingStruct.user_name = "nil"
                        } else {
                            let isAvailable = object["data"] as? Bool ?? false
                            
                            if isAvailable {
                                self.userNameSuccess()
                                userOnboardingStruct.user_name = userNameToCheck
                            } else {
                                self.userNameFailed()
                                userOnboardingStruct.user_name = "nil"
                            }
                        }
                    }
                    
                } else {
                    self.enableConfirmButton(should:false)
                }
            } else {
                self.enableConfirmButton(should:false)
            }
        }
    }
    
    //toggle for confirmation button
    func enableConfirmButton(should:Bool) {
    DispatchQueue.main.async {
            if should {
                self.confirmButton.isEnabled = true
                self.confirmButton.backgroundColor = .kwiksGreen
            } else {
                self.confirmButton.backgroundColor = #colorLiteral(red: 0.7764705882, green: 0.7764705882, blue: 0.7764705882, alpha: 1)
                self.confirmButton.tintColor = .black
                self.confirmButton.isEnabled = false
            }
        }
    }
    
    func userNameFailed() {
        DispatchQueue.main.async {
            self.isApproved = false
            self.checkmarkImageView.image = self.unavailableIcon
            self.confirmButton.isEnabled = false
            self.confirmButton.backgroundColor = #colorLiteral(red: 0.7764705882, green: 0.7764705882, blue: 0.7764705882, alpha: 1)
        }
    }
    func userNameSuccess() {
        DispatchQueue.main.async {
            
            self.isApproved = true
            UIView.animate(withDuration: 0.15, delay: 0.1, options: .curveLinear, animations: {
                self.checkmarkImageView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                
            }) { (success) in
                UIView.animate(withDuration: 0.15, delay: 0, options: .curveLinear, animations: {
                    self.checkmarkImageView.transform = .identity
                    self.checkmarkImageView.image = self.availableIcon
                    
                    self.confirmButton.isEnabled = true
                    self.confirmButton.backgroundColor = .kwiksGreen
                    
                })
            }
        }
    }
}


































//graveyard
//
//@objc func textFieldDidChange(textField: UITextField) {
//
//    //TODO: Implement profanity/vulgar checks.
//    let availableUsernames = ["MarkBlum", "MarkGlixman", "Davidi", "Mark", "Blum", "Glixman"]
//    let cleanNames = availableUsernames.map { $0.lowercased() }
//    guard let username = textField.text?.lowercased() else { return }
//
//    if cleanNames.contains(username) {
//        UIView.animate(withDuration: 0.15, delay: 0.1, options: .curveLinear, animations: {
//            self.checkmarkImageView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
//
//        }) { (success) in
//            UIView.animate(withDuration: 0.15, delay: 0, options: .curveLinear, animations: {
//                self.checkmarkImageView.transform = .identity
//                self.checkmarkImageView.image = self.availableIcon
//
//                self.confirmButton.isEnabled = true
//                self.confirmButton.backgroundColor = .kwiksGreen
//            })
//        }
//
//    } else {
//        self.checkmarkImageView.image = self.unavailableIcon
//        self.confirmButton.isEnabled = false
//        self.confirmButton.backgroundColor = #colorLiteral(red: 0.7764705882, green: 0.7764705882, blue: 0.7764705882, alpha: 1)
//    }
//}
