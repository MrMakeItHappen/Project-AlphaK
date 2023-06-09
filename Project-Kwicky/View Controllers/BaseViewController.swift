//
//  BaseViewController.swift
//  KwiksSandboxx
//
//  Created by Charlie Arcodia on 4/21/23.
//

import Foundation
import UIKit

class BaseViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func dismissNavigationController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func dismissViewController() {
        self.dismiss(animated: true)
    }
}
