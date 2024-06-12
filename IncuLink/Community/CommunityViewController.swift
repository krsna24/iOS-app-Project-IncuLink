//
//  CommunityViewController.swift
//  IncuLink
//
//  Created by Ananya Kumar on 16/05/24.
//

import UIKit

class CommunityViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return CommunityDataModel.section1.count
        case 1:
            return CommunityDataModel.section2.count
        default:
            return CommunityDataModel.section1.count
        }    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Events", for: indexPath)
            configureEventsCell(cell, for: indexPath.row)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Channels", for: indexPath) as! CommunityChannelsCollectionViewCell
            
            configureChannelsCell(cell, for: indexPath.row)
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Events", for: indexPath)
            configureEventsCell(cell, for: indexPath.row)
            return cell
        }
        
        //func to reflect different event images in section 1
        func configureEventsCell(_ cell: UICollectionViewCell, for index: Int) {
            guard let cell = cell as? CommunityEventsCollectionViewCell else {
                return
            }
            cell.eventimageView.image = UIImage(named: "Event\(index+1)")
            cell.eventimageView.layer.cornerRadius = 23

        }
        
        //func to reflect different channel logo images in section 2
        func configureChannelsCell(_ cell: CommunityChannelsCollectionViewCell, for index: Int) {
            cell.channelLogoImageView.image = UIImage(named: "Channel\(index+1)")
            cell.channelNameLabel.text = CommunityDataModel.section2[index].channelNames
            
            let channel = ChannelDataModel.channels[index]
            cell.configure(with: channel)
            
            cell.channelJoinButton.tag = index
            
            cell.channelJoinButton.addTarget(self, action: #selector(joinButtonTapped(_:)), for: .touchUpInside)
            
        }
       
    }
    
    
    
    //Get event details from the flash card at community tab directly
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            performSegue(withIdentifier: "ShowEventDetail", sender: indexPath)
        } else if indexPath.section == 1 && ChannelDataModel.channels[indexPath.row].isJoined {
            performSegue(withIdentifier: "ShowChannelDetail", sender: indexPath.row)
        }
    }
    
    //join button tapped on channel cell
    @objc func joinButtonTapped(_ sender: UIButton) {
        let channelIndex = sender.tag
        ChannelDataModel.channels[channelIndex].isJoined = true
        
        communityCollectionView.reloadItems(at: [IndexPath(item: channelIndex, section: 1)])
        
        performSegue(withIdentifier: "ShowChannelDetail", sender: channelIndex)
    }
     
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowEventDetail" {
            if let indexPath = sender as? IndexPath {
                let eventDetailVC = segue.destination as! EventDetailedViewController
                let event = EventsDataModel.event[indexPath.row]
                eventDetailVC.eventName = EventsDataModel.event[indexPath.row].titleNames
                eventDetailVC.eventImage = UIImage(named: EventsDataModel.event[indexPath.row].images)
                eventDetailVC.eventDate = EventsDataModel.event[indexPath.row].dateOfEvents
                eventDetailVC.eventTime = EventsDataModel.event[indexPath.row].timeOfEvents
                eventDetailVC.eventVenue = EventsDataModel.event[indexPath.row].venueOfEvents
                eventDetailVC.eventDescription = EventsDataModel.event[indexPath.row].descriptionOfEvents
                eventDetailVC.ticketLink = EventsDataModel.event[indexPath.row].website
                
            }
        } else if segue.identifier == "ShowChannelDetail" {
            if let channelIndex = sender as? Int {
                let channelDetailVC = segue.destination as! ChannelDetailedViewController
                let channel = ChannelDataModel.channels[channelIndex]
                channelDetailVC.channelLogoImage = UIImage(named: ChannelDataModel.channels[channelIndex].channelLogoImage)
                channelDetailVC.channelName = ChannelDataModel.channels[channelIndex].channelName
                
            }
        }
    }
     
     
    // Add timer and current index properties
    var timer: Timer?
    var currentIndex = 0
    
    
    

    @IBOutlet var communityCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let eventNib = UINib(nibName: "Events", bundle: nil)
        communityCollectionView.register(eventNib, forCellWithReuseIdentifier: "Events")
        
        let channelNib = UINib(nibName: "Channels", bundle: nil)
        communityCollectionView.register(channelNib, forCellWithReuseIdentifier: "Channels")
        
        
        //registering the header view which cell be reused by all the sections
        communityCollectionView.register(CommunityHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CommunityHeaderCollectionReusableView")
        
        communityCollectionView.setCollectionViewLayout(generateLayout(), animated: true)
        communityCollectionView.dataSource = self
        communityCollectionView.delegate = self
        
        
        
        // Start the timer for automatic scrolling
        startTimer()
        
        
        
    }
    
    
    
    
    // Start the timer method
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
    }

    // Auto-scroll method
    @objc func autoScroll() {
        guard let numberOfItems = communityCollectionView.dataSource?.collectionView(communityCollectionView, numberOfItemsInSection: 0) else { return }
        
        if currentIndex < numberOfItems - 1 {
            currentIndex += 1
        } else {
            currentIndex = 0
        }
        
        let indexPath = IndexPath(item: currentIndex, section: 0)
        communityCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }

    // Invalidate the timer when the view is deinitialized
    deinit {
        timer?.invalidate()
    }
    
    
    
    //Setting up the header data
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let communityHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CommunityHeaderCollectionReusableView", for: indexPath) as! CommunityHeaderCollectionReusableView
            
            communityHeaderView.communityHeaderLabel.text = CommunityDataModel.sectionHeaders[indexPath.section]
            communityHeaderView.communityHeaderLabel.font = UIFont.boldSystemFont(ofSize: 17)
            
            
            // Check if it's the first section
            if indexPath.section == 0 {
                communityHeaderView.communityButton.tag = indexPath.section
                communityHeaderView.communityButton.setTitle("See All", for: .normal)
                communityHeaderView.communityButton.addTarget(self, action: #selector(communityHeaderButtonTapped(_:)), for: .touchUpInside)
            } else {
                // Hide the button for other sections
                communityHeaderView.communityButton.isHidden = true
            }
            
            return communityHeaderView
        }
        fatalError("Unexpected element kind")
    }
    
    //setting up the header size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 44)
    }
    
    //setting up the layout of the collection view
    func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, env) -> NSCollectionLayoutSection? in let section: NSCollectionLayoutSection
            
            switch sectionIndex {
            case 0:
                section = self.generateSection0()
            case 1:
                section = self.generateSection1()
            default:
                section = self.generateSection0()
            }
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            section.boundarySupplementaryItems = [header]
            
            //constraints of channel list
            section.interGroupSpacing = 8
            
            
            return section
        }
        return layout
    }
    
    
    
    
    //Section - 1: Events
    func generateSection0() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.90), heightDimension: .absolute(230))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        
        return section
    }
    
    //Section - 2: Channels
    func generateSection1() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(90))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.90), heightDimension: .absolute(90))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: -30)
        
        return section
    }
    
   //For the action of heaader button
    @objc func communityHeaderButtonTapped(_ sender: UIButton) {
        guard let storyboard = storyboard else {return}
        let viewController = storyboard.instantiateViewController(withIdentifier: "CommunitySectionDetailedViewController") as! CommunitySectionDetailedViewController
        viewController.communitySectionNumber = sender.tag
        navigationController?.pushViewController(viewController, animated: true)
    }

}

