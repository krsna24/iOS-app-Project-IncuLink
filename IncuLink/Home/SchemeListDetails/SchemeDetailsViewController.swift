//
//  SchemeDetailsViewController.swift
//  IncuLink
//
//  Created by Krsna College on 03/06/24.
//

import UIKit

class SchemeDetailsViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var noOfStartupSupported: UILabel!
    
    @IBOutlet weak var schemeDescription: UILabel!
    
    @IBOutlet weak var schemeDetailedView: UIView!
    
    
    var image : UIImage?
    var titlelabel : String?
    var noOfStartups : String?
    var desc : String?
    var link : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.layer.cornerRadius = 23
        imageView.image = image
        titleLabel.text = titlelabel
        noOfStartupSupported.text  = noOfStartups
        schemeDescription.text = desc
        
        schemeDetailedView.layer.borderWidth = 2
        schemeDetailedView.layer.borderColor = UIColor(shex: "#397659")?.cgColor
        

        // Do any additional setup after loading the view.
        if let navigationBar = self.navigationController?.navigationBar {
            if let imageView = navigationBar.viewWithTag(999) as? UIImageView {
                imageView.isHidden = true
            }
        }
    }

    @IBAction func website(_ sender: Any) {
        guard let url = URL(string: link!) else { return }
                        UIApplication.shared.open(url)
        
    }
    
}

extension UIColor {
    convenience init?(shex: String) {
        let shex = shex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: shex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch shex.count {
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
