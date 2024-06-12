//
//  SchemesCollectionViewCell.swift
//  IncuLink
//
//  Created by Krsna on 27/05/24.
//

import UIKit

class SchemesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var view: UIView!
    
    @IBOutlet weak var schemeImage: UIImageView!
    override func layoutSubviews() {
        view.layer.cornerRadius = 23.0
        schemeImage.layer.masksToBounds = true

            schemeImage.layer.shadowColor = UIColor.systemGray5.cgColor
//            view.layer.borderWidth = 0.3
    }
    
}
