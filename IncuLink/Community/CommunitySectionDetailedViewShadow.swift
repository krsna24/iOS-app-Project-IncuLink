//
//  CommunitySectionDetailedViewShadow.swift
//  IncuLink
//
//  Created by Ankit Rajput on 31/05/24.
//

import Foundation
import UIKit

@IBDesignable class CommunitySectionDetailedViewShadow: UIStackView{
    @IBInspectable var cornerRadius : CGFloat = 9
    var ofsetWidth : CGFloat = 3
    var ofsetHeight : CGFloat = 3
    var ofsetShadowOpacity : Float = 0.0
    @IBInspectable var colour = UIColor.lightGray
    
    override func layoutSubviews() {
        layer.cornerRadius = self.cornerRadius
        layer.shadowColor = UIColor.systemGray5.cgColor
        layer.borderColor = self.colour.cgColor
        layer.borderWidth = 0.3
        layer.shadowOffset = CGSize(width: self.ofsetWidth, height: self.ofsetHeight)
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: self.cornerRadius).cgPath
        layer.shadowOpacity = self.ofsetShadowOpacity
    }
}
