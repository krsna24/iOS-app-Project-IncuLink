//
//  SuccesStoryDetailedViewController.swift
//  IncuLink
//
//  Created by Krsna College on 31/05/24.
//

import UIKit

class SuccesStoryDetailedViewController: UIViewController {

    
    @IBOutlet weak var startupLogoImageView: UIImageView!
    @IBOutlet weak var startupNameLabel: UILabel!
    @IBOutlet weak var founderNameLabel: UILabel!
    @IBOutlet weak var incubationUsedLabel: UILabel!
    @IBOutlet weak var schemeUsedLabel: UILabel!
    @IBOutlet weak var domainLabel: UILabel!
    @IBOutlet weak var publicRatingLabel: UILabel!
    @IBOutlet weak var successStroyDetailedView: UIView!
    
    var startupLogo: UIImage?
    var startupName: String?
    var founderName: String?
    var incubationUsed: String?
    var schemeUsed: String?
    var domain: String?
    var publicRating: String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        startupLogoImageView.image = startupLogo
        startupNameLabel.text =  startupName
        founderNameLabel.text = founderName
        incubationUsedLabel.text = incubationUsed
        schemeUsedLabel.text = schemeUsed
        domainLabel.text = domain
        publicRatingLabel.text = publicRating
        
        successStroyDetailedView.layer.borderWidth = 2
        successStroyDetailedView.layer.borderColor = UIColor(hhex: "#397659")?.cgColor
        
        if let navigationBar = self.navigationController?.navigationBar {
            if let imageView = navigationBar.viewWithTag(999) as? UIImageView {
                imageView.isHidden = true
            }
        }
    }
    
}

extension UIColor {
    convenience init?(hhex: String) {
        let hhex = hhex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hhex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hhex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            return nil
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
