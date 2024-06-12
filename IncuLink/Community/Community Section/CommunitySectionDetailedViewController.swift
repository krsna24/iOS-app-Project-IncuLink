//
//  CommunitySectionDetailedViewController.swift
//  IncuLink
//
//  Created by Ankit Rajput on 29/05/24.
//

import UIKit

class CommunitySectionDetailedViewController: UIViewController {
    
    var communitySectionNumber: Int = -1
    
    @IBOutlet var label: UILabel!
    
    @IBOutlet var eventCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        eventCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        label.text = CommunityDataModel.sectionHeaders[communitySectionNumber]
    }
}



extension CommunitySectionDetailedViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return EventsDataModel.event.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CommunitySectionCollectionViewCell
        cell.titleLabel.text = EventsDataModel.event[indexPath.row].titleNames
        cell.imageView.image = UIImage(named: EventsDataModel.event[indexPath.row].images)
        cell.dateLabel.text = EventsDataModel.event[indexPath.row].dateOfEvents
        cell.venueLabel.text = EventsDataModel.event[indexPath.row].venueOfEvents
        
        cell.layer.cornerRadius = 18
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width-10
        let height = collectionView.frame.height/2
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let eventDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "EventDetailedViewController") as! EventDetailedViewController
        
        
        eventDetailViewController.eventName = EventsDataModel.event[indexPath.row].titleNames
        eventDetailViewController.eventImage = UIImage(named: EventsDataModel.event[indexPath.row].images)
        eventDetailViewController.eventDate = EventsDataModel.event[indexPath.row].dateOfEvents
        eventDetailViewController.eventTime = EventsDataModel.event[indexPath.row].timeOfEvents
        eventDetailViewController.eventVenue = EventsDataModel.event[indexPath.row].venueOfEvents
        eventDetailViewController.ticketLink = EventsDataModel.event[indexPath.row].website
        eventDetailViewController.eventDescription = EventsDataModel.event[indexPath.row].descriptionOfEvents
        
        self.navigationController?.pushViewController(eventDetailViewController, animated: true)
    }
}
