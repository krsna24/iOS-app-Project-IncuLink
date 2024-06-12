//
//  ChannelDetailedViewController.swift
//  IncuLink
//
//  Created by Ankit Rajput on 03/06/24.
//

import UIKit

class ChannelDetailedViewController: UIViewController {

    @IBOutlet var channelLogoImageView: UIImageView!
    @IBOutlet var channelNameLabel: UILabel!
    
    var channelLogoImage: UIImage?
    var channelName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        channelLogoImageView.image = channelLogoImage
        channelNameLabel.text = channelName
    }
    

    

}
