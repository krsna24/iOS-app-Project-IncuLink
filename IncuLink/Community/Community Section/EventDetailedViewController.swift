//
//  EventDetailedViewController.swift
//  IncuLink
//
//  Created by Ankit Rajput on 30/05/24.
//

import UIKit

class EventDetailedViewController: UIViewController {
    
    
    @IBOutlet var eventNameLabel: UILabel!
    @IBOutlet var eventImageView: UIImageView!
    
    @IBOutlet var eventDateLabel: UILabel!
    @IBOutlet var eventTimeLabel: UILabel!
    @IBOutlet var eventVenueLabel: UILabel!
    @IBOutlet var eventDescriptionLabel: UILabel!
    @IBOutlet var eventDescriptionView: UIView!
    
    
    var ticketLink: String?
    var eventName: String?
    var eventImage: UIImage?
    
    var eventDate: String?
    var eventTime: String?
    var eventVenue: String?
    var eventDescription: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        eventNameLabel.text = eventName
        eventImageView.image = eventImage
        eventImageView.layer.borderWidth = 2
        eventImageView.layer.borderColor = UIColor(hex: "#397659")?.cgColor
        
        eventDateLabel.text = eventDate
        eventTimeLabel.text = eventTime
        eventVenueLabel.text = eventVenue
        eventDescriptionLabel.text = eventDescription
        eventDescriptionView.layer.borderWidth = 3
        eventDescriptionView.layer.borderColor = UIColor(hex: "#397659")?.cgColor
        
        
    }
    @IBAction func ticketButtontapped(_ sender: UIButton) {
        
        
        guard let ticketUrl = URL(string: ticketLink ?? "") else { return }
        UIApplication.shared.open(ticketUrl)
    }
}


extension UIColor {
    convenience init?(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
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
