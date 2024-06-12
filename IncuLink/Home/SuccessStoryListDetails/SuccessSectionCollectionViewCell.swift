//
//  SectionCollectionViewCell.swift
//  IncuLink
//
//  Created by Krsna College on 31/05/24.
//

import UIKit

class SectionCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var startupNameLabel: UILabel!
    
    @IBOutlet weak var incubationUsedLabel: UILabel!
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var foundedYearLabel: UILabel!
    override func layoutSubviews() {
        view.layer.cornerRadius = 23
        view.layer.masksToBounds = true
        view.layer.shadowColor = UIColor.systemGray5.cgColor
        view.layer.borderWidth = 0.3
        
    }
    
}
