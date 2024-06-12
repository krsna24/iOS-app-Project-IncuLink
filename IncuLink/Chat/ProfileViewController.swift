//
//  ProfileViewController.swift
//  IncuLink
//
//  Created by Ananya Kumar on 04/06/24.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var postsCountLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let numberOfPosts = getNumberOfPosts()
                postsCountLabel.text = "\(numberOfPosts) Posts"
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapPostsLabel))
                postsCountLabel.isUserInteractionEnabled = true
                postsCountLabel.addGestureRecognizer(tapGesture)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    func getNumberOfPosts() -> Int {
            // Fetch the number of posts from your data source
            // This is just a placeholder implementation
            return 10
        }

    @objc func didTapPostsLabel() {
            performSegue(withIdentifier: "showUserPosts", sender: self)
        }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
