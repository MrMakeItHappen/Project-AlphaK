
//  DrawOverride+Ext.swift
//  KwiksSandboxx
//
//  Created by Charlie Arcodia on 5/1/23.
//

import Foundation
import UIKit

@IBDesignable
class LineView: UIView {
    
    @IBInspectable var lineWidth: CGFloat = 1.0
    @IBInspectable var lineColor: UIColor? {
        didSet {
            lineCGColor = lineColor?.cgColor
        }
    }
    var lineCGColor: CGColor?
    
    override func draw(_ rect: CGRect) {
        // Draw a line from the left to the right at the midpoint of the view's rect height.
        let midpoint = self.bounds.size.height / 2.0
        let context = UIGraphicsGetCurrentContext()
        context!.setLineWidth(lineWidth)
        if let lineCGColor = self.lineCGColor {
            context!.setStrokeColor(lineCGColor)
        }
        else {
            context!.setStrokeColor(UIColor.black.cgColor)
        }
        context!.move(to: CGPoint(x: 0.0, y: midpoint))
        context!.addLine(to: CGPoint(x: self.bounds.size.width, y: midpoint))
        context!.strokePath()
    }
}
