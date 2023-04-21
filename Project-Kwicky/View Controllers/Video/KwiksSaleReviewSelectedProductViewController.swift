//
//  KwiksSaleReviewSelectedProductViewController.swift
//  Project-Kwicky
//
//  Created by Stanley Miller on 4/21/23.
//

import UIKit

final class KwiksSaleReviewSelectedProductViewController: UIViewController {
    var selectedItem: KwiksSaleItem!
    
    var sampleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = .segoeUISemiBold(size: 50)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = UIColor.white
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        self.view.addSubview(self.sampleLabel)
        self.sampleLabel.centerInSuperview()
        
        self.sampleLabel.text = selectedItem.productName
    }
}
