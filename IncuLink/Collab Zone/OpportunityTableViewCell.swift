//
//  OpportunityTableViewCell.swift
//  IncuLink
//
//  Created by Ananya Kumar on 28/05/24.
//

import UIKit

class OpportunityTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionButton: UIButton!
    
    @IBOutlet weak var imageViewOutlet: UIImageView!
    
    @IBOutlet weak var skillsOutlet1: UIButton!
    
    @IBOutlet weak var experienceSwith: UIButton!
    
    @IBOutlet weak var skillsOutlet2: UIButton!
    
    @IBOutlet weak var locationOutlet: UIButton!
    
    
    @IBOutlet weak var bookMarkedOutlet: UIButton!
    
    
    @IBOutlet weak var titleOutlet: UILabel!
    
    
    @IBOutlet weak var companyNameOutlet: UILabel!
    
    
    @IBOutlet weak var collaborateButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0))
    }

}
