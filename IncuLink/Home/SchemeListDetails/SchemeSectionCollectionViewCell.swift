//
//  SchemeSectionCollectionViewCell.swift
//  IncuLink
//
//  Created by Krsna College on 03/06/24.
//

import UIKit

class SchemeSectionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
   
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var view: UIView!
    override func layoutSubviews() {
        view.layer.cornerRadius = 23
        view.layer.masksToBounds = true
        view.layer.shadowColor = UIColor.systemGray5.cgColor
        view.layer.borderWidth = 0.3
        
    }
    
}
