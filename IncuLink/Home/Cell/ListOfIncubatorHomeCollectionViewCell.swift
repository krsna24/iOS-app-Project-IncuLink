//
//  ListOfIncubatorHomeCollectionViewCell.swift
//  IncuLink
//
//  Created by Krsna College on 28/05/24.
//

import UIKit

class ListOfIncubatorHomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var incubationName: UILabel!
    
    @IBOutlet weak var startupGuided: UILabel!
   
    @IBOutlet weak var view: UIView!
    
    override func layoutSubviews() {
        view.layer.cornerRadius = 23.0
        view.layer.masksToBounds = true
        view.layer.shadowColor = UIColor.systemGray5.cgColor
        view.layer.borderWidth = 0.3

    }
    
    
    
}
