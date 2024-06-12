//
//  HomeViewController.swift
//  IncuLink
//
//  Created by Krsna College on 28/05/24.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController ,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,CLLocationManagerDelegate{
    
    @IBOutlet weak var collectionView: UICollectionView!
    var section3a = HomeTabData.section3a
    var locationManager: CLLocationManager!
    var currentLocation: CLLocation?
    
    
    private let containerView = UIView()
    
    
    
    private let imageView = UIImageView(image: UIImage(named: "account.png"))
    /// WARNING: Change these constants according to your project's design
    private struct Const {
        /// Image height/width for Large NavBar state
        static let ImageSizeForLargeState: CGFloat = 40
        /// Margin from right anchor of safe area to right anchor of Image
        static let ImageRightMargin: CGFloat = 16
        /// Margin from bottom anchor of NavBar to bottom anchor of Image for Large NavBar state
        static let ImageBottomMarginForLargeState: CGFloat = 12
        /// Margin from bottom anchor of NavBar to bottom anchor of Image for Small NavBar state
        static let ImageBottomMarginForSmallState: CGFloat = 6
        /// Image height/width for Small NavBar state
        static let ImageSizeForSmallState: CGFloat = 32
        /// Height of NavBar for Small state. Usually it's just 44
        static let NavBarHeightSmallState: CGFloat = 44
        /// Height of NavBar for Large state. Usually it's just 96.5 but if you have a custom font for the title, please make sure to edit this value since it changes the height for Large state of NavBar
        static let NavBarHeightLargeState: CGFloat = 96.5
    }
    // Returns the number of items in a given section of the collection view.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return HomeTabData.section1a.count // Items in section 0
        case 1:
            return HomeTabData.section2a.count // Items in section 1
        case 2:
            return HomeTabData.section3a.count // Items in section 2
        default:
            return HomeTabData.section1a.count // Fallback for other sections
        }
    }

    // Returns the cell for a specific item at a given index path in the collection view.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SuccessStoryCell", for: indexPath)
            configureSuccessStoryCell(cell, for: indexPath.row) // Configure cell for section 0
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SchemeCell", for: indexPath)
            configureSchemeCell(cell, for: indexPath.row) // Configure cell for section 1
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListOfIncubator", for: indexPath)
            configureIncubationListCell(cell, for: indexPath.row) // Configure cell for section 2
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SuccessStoryCell", for: indexPath)
            return cell // Fallback cell
        }
    }

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    // Configures the SuccessStoryCell for a given index.
    func configureSuccessStoryCell(_ cell: UICollectionViewCell, for index: Int) {
        // Ensure the cell is of type SuccessStoryCollectionViewCell.
        guard let cell = cell as? SuccessStoryCollectionViewCell else {
            return
        }
        // Set the image view with the thumbnail URL.
        cell.imageView.image = UIImage(named: HomeTabData.section1a[index].thumbnailURL)
        // Set the startup name label.
        cell.startupName.text = HomeTabData.section1a[index].name
        // Set the font for the startup name label.
        cell.startupName.font = UIFont.boldSystemFont(ofSize: 17.0)
        // Set the incubation name label.
        cell.incubationName.text = HomeTabData.section1a[index].incubationName
        // Set the founded year label.
        cell.foundedYear.text = "Founded in \(HomeTabData.section1a[index].foundedYear)"
    }

    
    func configureSchemeCell(_ cell: UICollectionViewCell, for index: Int) {
        guard let cell = cell as? SchemesCollectionViewCell else {return}
        cell.schemeImage.image = UIImage(named: HomeTabData.section2a[index].image!)
        
    }
    
    
    
    // Configures the IncubationListCell for a given index.
    func configureIncubationListCell(_ cell: UICollectionViewCell, for index: Int) {
        // Ensure the cell is of type ListOfIncubatorHomeCollectionViewCell.
        guard let cell = cell as? ListOfIncubatorHomeCollectionViewCell else { return }
        
        // Get the incubation centre data for the specified index.
        let incubationCentre = HomeTabData.section3a[index]
        
        // Set the image view with the thumbnail URL. Make sure to handle optional image names appropriately.
        cell.imageView.image = UIImage(named: incubationCentre.thumbnailURL)
        
        // Set the incubation name label.
        cell.incubationName.text = incubationCentre.name
        
        // Set the font for the incubation name label.
        cell.incubationName.font = UIFont.boldSystemFont(ofSize: 17.0)
        
        // Set the startup guided label with the number of startups incubated.
        cell.startupGuided.text = "Startups Incubated: \(incubationCentre.incubatedStartup)"
    }


    
    //get details from the flash card at home tab directly
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            performSegue(withIdentifier: "ShowSuccessStoryDetail", sender: indexPath)
            
        } else if indexPath.section == 1 {
            performSegue(withIdentifier: "ShowSchemeDetail", sender: indexPath)
        } else if indexPath.section == 2 {
            performSegue(withIdentifier: "ShowIncubationDetail", sender: indexPath)
        }
    }
    
    // Prepares for a segue by passing data to the destination view controller.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Check if the segue identifier is "ShowSuccessStoryDetail".
        if segue.identifier == "ShowSuccessStoryDetail" {
            // Ensure sender is an IndexPath.
            if let indexPath = sender as? IndexPath {
                // Cast destination view controller as SuccesStoryDetailedViewController.
                let successStoryDetailVC = segue.destination as! SuccesStoryDetailedViewController
                // Get the success story data for the specified index.
                let successStory = HomeTabData.section1b[indexPath.row]
                // Set the properties of the destination view controller.
                successStoryDetailVC.startupLogo = UIImage(named: successStory.thumbnailImage!)
                successStoryDetailVC.startupName = successStory.name
                successStoryDetailVC.founderName = successStory.founders
                successStoryDetailVC.incubationUsed = successStory.incubationUsed
                successStoryDetailVC.schemeUsed = successStory.schemes
                successStoryDetailVC.domain = successStory.domain
                successStoryDetailVC.publicRating = "\(successStory.publicRating)"
            }
        // Check if the segue identifier is "ShowIncubationDetail".
        } else if segue.identifier == "ShowIncubationDetail" {
            // Ensure sender is an IndexPath.
            if let incubationIndex = sender as? IndexPath {
                // Cast destination view controller as IncubationDetailedViewController.
                let incubationDetailVC = segue.destination as! IncubationDetailedViewController
                // Get the incubation centre data for the specified index.
                let incubation = HomeTabData.section3b[incubationIndex.row]
                // Set the properties of the destination view controller.
                incubationDetailVC.image = UIImage(named: incubation.thumbnailImage!)
                incubationDetailVC.centre = incubation.name
                incubationDetailVC.year = "\(incubation.established)"
                incubationDetailVC.loc = incubation.location
                incubationDetailVC.recognisedAndFundedby = incubation.recognizedAndFundedBy
                incubationDetailVC.startupsincubated = incubation.numberOfStartupsIncubated
            }
        // Check if the segue identifier is "ShowSchemeDetail".
        } else if segue.identifier == "ShowSchemeDetail" {
            // Ensure sender is an IndexPath.
            if let schemeIndex = sender as? IndexPath {
                // Cast destination view controller as SchemeDetailsViewController.
                let schemeDetailVC = segue.destination as! SchemeDetailsViewController
                // Get the scheme data for the specified index.
                let scheme = HomeTabData.section2b[schemeIndex.row]
                // Set the properties of the destination view controller.
                schemeDetailVC.image = UIImage(named: scheme.thumbnailImage!)
                schemeDetailVC.desc = scheme.shortDescription
                schemeDetailVC.noOfStartups = "\(scheme.startupSupported)"
                schemeDetailVC.link = scheme.websiteLink
                schemeDetailVC.titlelabel = scheme.title
            }
        }
    }
    
    
    
    
    //MARK: - Auto Scroll times for succes stories and schemes section
    //private var successStoriesTimer: Timer?
    private var schemesTimer: Timer?
    
    
//    @objc private func autoScrollSuccessStories() {
//        autoScrollSection(section: 0)
//    }

    @objc private func autoScrollSchemes() {
        autoScrollSection(section: 1)
    }

    private func autoScrollSection(section: Int) {
        let visibleIndexPaths = collectionView.indexPathsForVisibleItems.filter { $0.section == section }.sorted()
        
        if let lastVisibleIndexPath = visibleIndexPaths.last, lastVisibleIndexPath.row < collectionView.numberOfItems(inSection: section) - 1 {
            let nextIndexPath = IndexPath(row: lastVisibleIndexPath.row + 1, section: section)
            collectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
        } else {
            let firstIndexPath = IndexPath(row: 0, section: section)
            collectionView.scrollToItem(at: firstIndexPath, at: .centeredHorizontally, animated: true)
        }
    }
        
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //successStoriesTimer?.invalidate()
        schemesTimer?.invalidate()
    }
    
    
    
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize and start the timer for auto-scrolling success stories (section 0)
//        successStoriesTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(autoScrollSuccessStories), userInfo: nil, repeats: true)
            
        // Initialize and start the timer for auto-scrolling schemes (section 1)
        schemesTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(autoScrollSchemes), userInfo: nil, repeats: true)
        
        
        let sortedArray = HomeTabData.section3a.sorted {
            if $0.latitude == $1.latitude {
                return $0.longitude < $1.longitude
            }
            return $0.latitude > $1.latitude
        }
              
              // Assign the sorted array to your original array
              HomeTabData.section3a = sortedArray
        let sortedArray1 = HomeTabData.section3b.sorted {
            if $0.latitude == $1.latitude {
                return $0.longitude < $1.longitude
            }
            return $0.latitude > $1.latitude
        }
              
              
        // Assign the sorted array to your original array
        HomeTabData.section3b = sortedArray1
              
        // Set up location manager
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        setupUI()
        // Registering nib files for collection view cells
        let successStoryNib = UINib(nibName: "SuccessStoryCell", bundle: nil)
        collectionView.register(successStoryNib, forCellWithReuseIdentifier: "SuccessStoryCell")

        let schemeViewNib = UINib(nibName: "SchemeCell", bundle: nil)
        collectionView.register(schemeViewNib, forCellWithReuseIdentifier: "SchemeCell")

        let listOfIncubatorNib = UINib(nibName: "ListOfIncubator", bundle: nil)
        collectionView.register(listOfIncubatorNib, forCellWithReuseIdentifier: "ListOfIncubator")

        // Registering the header view to be reused by all sections
        collectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderCollectionReusableView")

        // Setting the collection view layout
        collectionView.setCollectionViewLayout(generateLayout(), animated: true)

        // Setting the data source and delegate of the collection view
        collectionView.dataSource = self
        collectionView.delegate = self

        
        
        // Create a container view that will hold both the gradient layer and the collection view
        let containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        // Create a gradient layer that spans the entire container view
        let gradient = CAGradientLayer()
        gradient.frame = containerView.bounds
        gradient.colors = [
            UIColor(homeHex: "#397659").homeLighter(by: 60).cgColor,  // Using the lighter version of the hex color
            UIColor.secondarySystemBackground.cgColor,
            UIColor.systemBackground.cgColor
        ]
        containerView.layer.insertSublayer(gradient, at: 0)
        
        // Ensure the collection view's background is transparent and add it to the container view
        collectionView.backgroundColor = .clear
        containerView.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: containerView.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
        
        
        
        
    }
    
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Update the gradient layer frame if the layout changes
        if let gradient = containerView.layer.sublayers?.first as? CAGradientLayer {
            gradient.frame = containerView.bounds
        }
    }
    
    
    
    
    
    
    
    // Handles changes in location authorization status.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            print("User has not determined location permission.")
        case .restricted:
            print("Location access is restricted.")
        case .denied:
            print("User denied location access.")
        case .authorizedWhenInUse, .authorizedAlways:
            print("Location access granted.")
            // Start updating location if permission is granted.
            locationManager.startUpdatingLocation()
        @unknown default:
            print("Unknown authorization status.")
        }
    }

  
    func convertListToDetails(list: [IncubationCentreDetails]) -> [IncubationCentreDetails] {
        var detailsArray: [IncubationCentreDetails] = []
        for item in list {
            let detail = IncubationCentreDetails(name: item.name, established: item.established, numberOfStartupsIncubated: item.numberOfStartupsIncubated, recognizedAndFundedBy: item.recognizedAndFundedBy, location: item.location, thumbnailImage: item.thumbnailImage, latitude: item.latitude, longitude: item.longitude)
            detailsArray.append(detail)
        }
        print(detailsArray)
        return detailsArray
        
    }


        
        // Handle errors
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get user location: \(error.localizedDescription)")
    }
    
    //Setting up the header data
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderCollectionReusableView", for: indexPath) as! HeaderCollectionReusableView
            
            headerView.headerLabel.text = HomeTabData.sectionHeaders[indexPath.section]
            headerView.headerLabel.font = UIFont.boldSystemFont(ofSize: 17)
            
            
            //check it it's the first and third section
            if indexPath.section == 0 {
                headerView.button.tag = indexPath.section
                headerView.button.setTitle("See All", for: .normal)
                headerView.button.addTarget(self, action: #selector(headerButtonTapped(_:)), for: .touchUpInside)
            } else if indexPath.section == 1  {
                headerView.button.tag = indexPath.section
                headerView.button.setTitle("See All", for: .normal)
                headerView.button.addTarget(self, action: #selector(headerButtonTapped1(_:)), for: .touchUpInside)
            }else {
                //hide the button for the third section
                headerView.button.isHidden = true
            }
            
            return headerView
        }
        fatalError("Unexpected element kind")
    }
    //setting up the header size
    // Determines the size for the header of each section in the collection view.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        // Returns a CGSize object representing the size of the header.
        // Width is set to match the width of the collection view.
        // Height is set to 44 points.
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
            case 2:
                section = self.generateSection2()
            default:
                section = self.generateSection0()
            }
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            section.boundarySupplementaryItems = [header]
            
            return section
        }
        return layout
    }
    
    //Section - 1: Success Stories
    func generateSection0() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.90), heightDimension: .absolute(120))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.interGroupSpacing = 8.0
        return section
    }
    
    
    //Section - 2: Schemes
    func generateSection1() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.90), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
      
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.interGroupSpacing = 8.0
        return section
    }
    
    
    
    
    //Section - 3: List of Incubators
    func generateSection2() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(85))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.90), heightDimension: .absolute(85))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8.0
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: -30)
        


        
        return section
    }
    
    //For the action of heaader button
    @objc func headerButtonTapped(_ sender: UIButton) {
        guard let storyboard = storyboard else {return}
        let viewController = storyboard.instantiateViewController(withIdentifier: "SectionDetailedViewController") as! SectionDetailedViewController
        viewController.sectionNumber = sender.tag
        navigationController?.pushViewController(viewController, animated: true)
        
    }

    @objc func headerButtonTapped1(_ sender: UIButton) {
        guard let storyboard = storyboard else {return}
        let viewController = storyboard.instantiateViewController(withIdentifier: "SchemeListViewController") as! SchemeListViewController
        viewController.sectionNumber = sender.tag
        navigationController?.pushViewController(viewController, animated: true)
        
    }
    private func setupUI() {
        //navigationController?.navigationBar.prefersLargeTitles = true

              //title = "Large Title"

        // Initial setup for image for Large NavBar state since the the screen always has Large NavBar once it gets opened
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        navigationBar.addSubview(imageView)
        imageView.tag = 999
         imageView.layer.cornerRadius = Const.ImageSizeForLargeState / 2
         imageView.isUserInteractionEnabled = true
         imageView.clipsToBounds = true
         imageView.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.activate([
         imageView.rightAnchor.constraint(equalTo: navigationBar.rightAnchor, constant: -Const.ImageRightMargin),
         imageView.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: -Const.ImageBottomMarginForLargeState),
         imageView.heightAnchor.constraint(equalToConstant: Const.ImageSizeForLargeState),
         imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
         
         ])
        // Add tap gesture recognizer
                    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
                    imageView.addGestureRecognizer(tapGestureRecognizer)
                 
    }
    override func viewWillAppear(_ animated: Bool) {
        if let navigationBar = self.navigationController?.navigationBar {
            if let imageView = navigationBar.viewWithTag(999) as? UIImageView {
                imageView.isHidden = false
            }
        }
    }
        
    @objc func handleTapGesture() {
            print("ImageView tapped")
           // Create the view controller you want to push to
    //       let nextViewController = ProfileTableViewController() // Replace with your view controller class
    //
    //       // Push to the next view controller
    //       self.navigationController?.pushViewController(nextViewController, animated: true)
        
        self.performSegue(withIdentifier: "ShowProfileSegue", sender: nil)
       }
    }
        


extension UIColor {
    convenience init(homeHex: String) {
        let hex = homeHex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
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
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    // Function to blend the color with white
    func homeLighter(by percentage: CGFloat = 30.0) -> UIColor {
        return blend(with: .white, percentage: percentage)
    }
    
    private func blend(with color: UIColor, percentage: CGFloat) -> UIColor {
        var r1: CGFloat = 0, g1: CGFloat = 0, b1: CGFloat = 0, a1: CGFloat = 0
        var r2: CGFloat = 0, g2: CGFloat = 0, b2: CGFloat = 0, a2: CGFloat = 0
        
        self.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        color.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
        
        return UIColor(
            red: r1 + (r2 - r1) * percentage / 100,
            green: g1 + (g2 - g1) * percentage / 100,
            blue: b1 + (b2 - b1) * percentage / 100,
            alpha: a1 + (a2 - a1) * percentage / 100
        )
    }
}
