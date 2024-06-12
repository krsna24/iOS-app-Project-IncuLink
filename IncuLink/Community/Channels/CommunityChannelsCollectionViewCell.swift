//
//  CommunityChannelsCollectionViewCell.swift
//  IncuLink
//
//  Created by Ankit Rajput on 29/05/24.
//

import UIKit

class CommunityChannelsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var channelLogoImageView: UIImageView!
    
    @IBOutlet var channelNameLabel: UILabel!
    
    @IBOutlet var channelJoinButton: UIButton!
    
    @IBOutlet var channelContentView: UIView!
    
    
    override func layoutSubviews() {
        channelContentView.layer.cornerRadius = 23.0
        channelContentView.layer.borderWidth = 0.3
        channelContentView.layer.shadowColor = UIColor.systemGray5.cgColor
        channelContentView.layer.masksToBounds = true
    }
    
    var isJoined: Bool = false {
        didSet {
            channelJoinButton.isHidden = isJoined
        }
    }
    
    func configure(with channel: ChannelsDetail) {
        channelLogoImageView.image = UIImage(named: channel.channelLogoImage)
        channelNameLabel.text = channel.channelName
        // Hide the button if joined
        channelJoinButton.isHidden = channel.isJoined
    }
}
