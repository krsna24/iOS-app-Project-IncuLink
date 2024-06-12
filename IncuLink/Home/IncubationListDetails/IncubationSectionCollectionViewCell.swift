//
//  IncubationSectionCollectionViewCell.swift
//  IncuLink
//
//  Created by Krsna College on 01/06/24.
//

import UIKit

class IncubationSectionCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var incubationName: UILabel!
    
    @IBOutlet weak var startupsIncubated: UILabel!
    
    @IBOutlet weak var view: UIView!
    override func layoutSubviews() {
        view.layer.cornerRadius = 23
        view.layer.masksToBounds = true
        view.layer.shadowColor = UIColor.systemGray5.cgColor
        view.layer.borderWidth = 0.3
        
    }
}
