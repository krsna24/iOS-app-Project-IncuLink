//
//  UserPostsViewController.swift
//  IncuLink
//
//  Created by Ananya Kumar on 04/06/24.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class UserPostsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var userPosts: [Post] = []
    var userCollabPosts : [CollaborationOpportunity] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // Fetch user posts and reload the table view
        //fetchUserPosts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
    }
    
    func fetchData() {
        let auth = FirebaseAuth.Auth.auth()
        let db = FirebaseFirestore.Firestore.firestore()
        db.collection("Collab").whereField("user_id", isEqualTo: auth.currentUser?.uid).addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            var image = UIImage(named: "photoframe")
            var saved = false
            var oppurtunity  = documents.map { queryDocumentSnapshot -> CollaborationOpportunity in
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
            
                
                return CollaborationOpportunity(companyName: companyName, title: title, location: location, description: description, needsExperience: experience, skill1: skill1, skill2: skill2, user_id: user_id, logoDownloadUrl: logoDownloadUrl, bookMark: bookMark)
            }
            
            self.userCollabPosts = oppurtunity
        
            self.tableView.reloadData()
        }
    }
    
    func fetchUserPosts() {
        // Fetch posts from your data source
        userPosts = getUserPosts()
        tableView.reloadData()
    }
    
    func getUserPosts() -> [Post] {
        // Placeholder implementation
        return [Post(title: "Post 1"), Post(title: "Post 2")]
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userCollabPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath)
        let post = userCollabPosts[indexPath.row]
        cell.textLabel?.text = post.title
        return cell
    }
}

struct Post {
    let title: String
}
