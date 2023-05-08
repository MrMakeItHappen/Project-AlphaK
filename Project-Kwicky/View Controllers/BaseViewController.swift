//
//  BaseViewController.swift
//  KwiksSandboxx
//
//  Created by Charlie Arcodia on 4/21/23.
//

import Foundation
import UIKit

class BaseViewController : UIViewController {
    
    let mainLoadingScreen = MainLoadingScreen()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
   
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
       
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func dismissNavigationController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func dismissViewController() {
        self.dismiss(animated: true)
    }
}
