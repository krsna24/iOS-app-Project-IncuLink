//
//  CollabZoneViewController.swift
//  IncuLink
//
//  Created by Ananya Kumar on 27/05/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore


class CollabZoneViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var startupsForThisVC : [CollaborationOpportunity] = []
    var collabsAtHome : [CollaborationOpportunity] = []
    var savedOpportunities : [CollaborationOpportunity] = []
    var imageUrl : [String] = []
    var images : [UIImage] = []
    var firebaseOppurtunities : [CollaborationOpportunity] = []
    var refreshControl = UIRefreshControl()
    

    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        startupsForThisVC = collabsAtHome
        fetchData()
        fetchSavedData()
        print(savedOpportunities)
        tableView.dataSource = self
        tableView.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(newOpportunityCreated(_:)), name: NSNotification.Name("NewOpportunityCreated"), object: nil)
        // Do any additional setup after loading the view.
    }
    
    func addDataInSaved(opportunity : CollaborationOpportunity){
        let db = FirebaseFirestore.Firestore.firestore()
        db.collection("SavedCollab").addDocument(data: [
            "user_id" : opportunity.user_id,
            "company_name" : opportunity.companyName,
            "title" : opportunity.title,
            "description" : opportunity.description,
            "experience" : opportunity.needsExperience,
            "location" : opportunity.location,
            "skill1" : opportunity.skill1,
            "skill2" : opportunity.skill2,
            "logoDownloadUrl" : opportunity.logoDownloadUrl
        ])
    }
    
//    Fetching data from firebase
    func fetchSavedData() {
        
        let db = FirebaseFirestore.Firestore.firestore()
        db.collection("SavedCollab").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            self.images = []
            
            var image = UIImage(named: "photoframe")
            var saved = false
            let oppurtunity  = documents.map { queryDocumentSnapshot -> CollaborationOpportunity in
                let data = queryDocumentSnapshot.data()
                let companyName = data["company_name"] as? String ?? ""
                let description = data["description"] as? String ?? ""
                let experience = data["experience"] as? Bool ?? false
                let location = data["location"] as? String ?? ""
                let logoDownloadUrl = data["logoDownloadUrl"] as? String ?? ""
                let skill1 = data["skill1"] as? String ?? ""
                let skill2 = data["skill2"] as? String ?? ""
                let title = data["title"] as? String ?? ""
                let user_id = data["user_id"] as? String ?? ""
                let bookMark = data["bookMark"] as? Bool ?? false
                saved = data["saved"] as? Bool ?? false
                image = self.fetchImage(imageUrl: logoDownloadUrl)
                
                return CollaborationOpportunity(companyName: companyName, title: title, location: location, description: description, needsExperience: experience, skill1: skill1, skill2: skill2, user_id: user_id, logoDownloadUrl: logoDownloadUrl, bookMark: bookMark)
            }
            
            self.savedOpportunities = oppurtunity
        //    self.images.append(image!)
        
            self.tableView.reloadData()
        }
    }
    

    
 
    
    func fetchData() {
        
        let db = FirebaseFirestore.Firestore.firestore()
        db.collection("Collab").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            self.images = []
            
            var image = UIImage(named: "photoframe")
            var saved = false
            let oppurtunity  = documents.map { queryDocumentSnapshot -> CollaborationOpportunity in
                let data = queryDocumentSnapshot.data()
                let companyName = data["company_name"] as? String ?? ""
                let description = data["description"] as? String ?? ""
                let experience = data["experience"] as? Bool ?? false
                let location = data["location"] as? String ?? ""
                let logoDownloadUrl = data["logoDownloadUrl"] as? String ?? ""
                let skill1 = data["skill1"] as? String ?? ""
                let skill2 = data["skill2"] as? String ?? ""
                let title = data["title"] as? String ?? ""
                let user_id = data["user_id"] as? String ?? ""
                let bookMark = data["bookMark"] as? Bool ?? false

                saved = data["saved"] as? Bool ?? false
                image = self.fetchImage(imageUrl: logoDownloadUrl)
                
                return CollaborationOpportunity(companyName: companyName, title: title, location: location, description: description, needsExperience: experience, skill1: skill1, skill2: skill2, user_id: user_id, logoDownloadUrl: logoDownloadUrl, bookMark: bookMark)
            }
            
            self.firebaseOppurtunities = oppurtunity
            //self.images.append(image!)
            print(self.savedOpportunities)
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //startupsForThisVC = collabsAtHome
        tableView.reloadData()
    }
    // fetching image
    func fetchImage(imageUrl : String)->UIImage{
        let url = URL(string: imageUrl)
        var image = UIImage(named: "incu1")!
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            
            DispatchQueue.main.async {
                image = UIImage(data: data!)!
                
                         }
        }
        return image
        
    }
    
//    Display data from the saved form
    
    @objc func newOpportunityCreated(_ notification: Notification) {
            if let opportunity = notification.object as? CollaborationOpportunity {
                collabsAtHome.append(opportunity)
                tableView.reloadData()
            }
        }

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        startupsForThisVC.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OpportunityCell", for: indexPath) as! OpportunityTableViewCell
    
            let opportunity = startupsForThisVC[indexPath.row]
        
        cell.descriptionButton.setTitle(opportunity.description, for: .normal)
        
        cell.skillsOutlet1.setTitle(opportunity.skill1, for: .normal)
        
        cell.skillsOutlet2.setTitle(opportunity.skill2, for: .normal)
        
        if opportunity.needsExperience{
            cell.experienceSwith.setTitle("Experince", for: .normal)
            
            cell.experienceSwith.titleLabel?.font = cell.experienceSwith.titleLabel?.font.withSize(8)
        }
        else{
            cell.experienceSwith.setTitle("Fresher", for: .normal)
        }
        
        cell.locationOutlet.setTitle(opportunity.location, for: .normal)
        cell.titleOutlet.text = opportunity.title
        cell.companyNameOutlet.text = opportunity.companyName
        cell.bookMarkedOutlet.tag = indexPath.row
        cell.bookMarkedOutlet.addTarget(self, action: #selector(bookmarkTapped), for: .touchUpInside)
        return cell
        }
    
    @objc func bookmarkTapped(sender: UIButton){
        sender.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        
        
        addDataInSaved(opportunity: firebaseOppurtunities[sender.tag])
        
    }
//    Action for segmented control
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0{
            startupsForThisVC = firebaseOppurtunities
            tableView.reloadData()
        }
        else{
            startupsForThisVC = savedOpportunities
            tableView.reloadData()
        }
        
        
    }
    @IBAction func unwindToCollabZone(segue: UIStoryboardSegue) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 305
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}


