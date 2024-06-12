//
//  IncubationDetailedViewController.swift
//  IncuLink
//
//  Created by Krsna College on 31/05/24.
//

import UIKit

class IncubationDetailedViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var centreName: UILabel!
    @IBOutlet weak var establishedYear: UILabel!
    @IBOutlet weak var startupsIncubated: UILabel!
    @IBOutlet weak var recognisedAndFundedBy: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var incubationDetailedView: UIView!
    

    var image : UIImage?
    var centre : String?
    var year : String?
    var startupsincubated : Int = 0
    var recognisedAndFundedby : String?
    var loc : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
        centreName.text = centre
        establishedYear.text = year
        startupsIncubated.text = "\(startupsincubated)"
        recognisedAndFundedBy.text = recognisedAndFundedby
        location.text = loc
        
        incubationDetailedView.layer.borderWidth = 2
        incubationDetailedView.layer.borderColor = UIColor(ihex: "#397659")?.cgColor
        
        if let navigationBar = self.navigationController?.navigationBar {
            if let imageView = navigationBar.viewWithTag(999) as? UIImageView {
                imageView.isHidden = true
            }
        }
        
    }

}
extension UIColor {
    convenience init?(ihex: String) {
        let ihex = ihex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: ihex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch ihex.count {
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

