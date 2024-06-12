//
//  ProfileTableViewController.swift
//  IncuLink
//
//  Created by Ananya Kumar on 04/06/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class ProfileTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    
    @IBOutlet weak var emailOutlet: UILabel!
    
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    @IBOutlet weak var logoutButton: UIButton!
    
    var user : User?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        print("This is table view controller")

        if let navigationBar = self.navigationController?.navigationBar {
            if let imageView = navigationBar.viewWithTag(999) as? UIImageView {
                imageView.isHidden = true
            }
        }
        
        getUserInfo()
        
        self.clearsSelectionOnViewWillAppear = false
        navigationItem.rightBarButtonItem?.isHidden = true
        
        setupTapGestureRecognizer()

                
    }
    
    func getUserInfo() {
        print("In get user Info")
        let firestore = Firestore.firestore()
        
        guard let currUser = FirebaseAuth.Auth.auth().currentUser?.uid else {
            print("No user exists")
            return
        }
        
        print(currUser)
        
        firestore.collection("users").document(currUser).getDocument { (document, error) in
            
            
            guard let data = document?.data() else {
                print("Document data was empty.")
                return
            }
            
            let userName = data["userName"] as? String
            let email = data["email"] as? String
            let phoneNo = data["phoneNo"] as? String
            
            let phoneNo2 = try? Int(phoneNo ?? "", format: .number)
            if let name = userName, let email = email, let phoneNo = phoneNo {
                let user = User(userName: name, email: email, phoneNo: phoneNo2 ?? 0)
                self.updateUI(user: user)
                
            } else {
                print("Error: One or more fields are nil or of incorrect type.")
                
            }
        }
    }
    
    func updateUI(user : User){
        userNameLabel.text = user.userName
        emailOutlet.text = user.email
        phoneNumberLabel.text = "\(user.phoneNo)"
    }

    
    
    // Logout functionality
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        do {
                    try Auth.auth().signOut()
                    // Navigate to Signup/Login Page
                    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    if let loginVC = mainStoryboard.instantiateViewController(withIdentifier: "login") as? LogInViewController {
                        self.view.window?.rootViewController = loginVC
                        self.view.window?.makeKeyAndVisible()
                    }
                } catch let logOutError as NSError {
                    print("Error logging out: %@", logOutError)
                }
    }
    
    // Profile image functionality
    
    func loadProfileImage(urlString: String) {
           if let url = URL(string: urlString) {
               DispatchQueue.global().async {
                   if let data = try? Data(contentsOf: url) {
                       DispatchQueue.main.async {
                           self.profileImageView.image = UIImage(data: data)
                       }
                   }
               }
           }
       }

       func setupTapGestureRecognizer() {
           let tapGesture = UITapGestureRecognizer(target: self, action: #selector(changeProfileImageTapped))
           profileImageView.isUserInteractionEnabled = true
           profileImageView.addGestureRecognizer(tapGesture)
       }

       @objc func changeProfileImageTapped() {
           let imagePickerController = UIImagePickerController()
           imagePickerController.delegate = self
           imagePickerController.allowsEditing = true

           let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
           actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action: UIAlertAction) in
               if UIImagePickerController.isSourceTypeAvailable(.camera) {
                   imagePickerController.sourceType = .camera
                   self.present(imagePickerController, animated: true, completion: nil)
               } else {
                   print("Camera not available")
               }
           }))
           actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action: UIAlertAction) in
               imagePickerController.sourceType = .photoLibrary
               self.present(imagePickerController, animated: true, completion: nil)
           }))
           actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

           self.present(actionSheet, animated: true, completion: nil)
       }

       func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           if let editedImage = info[.editedImage] as? UIImage {
               profileImageView.image = editedImage
               uploadProfileImage(image: editedImage)
           } else if let originalImage = info[.originalImage] as? UIImage {
               profileImageView.image = originalImage
               uploadProfileImage(image: originalImage)
           }
           picker.dismiss(animated: true, completion: nil)
       }

       func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           picker.dismiss(animated: true, completion: nil)
       }

       func uploadProfileImage(image: UIImage) {
           guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
           guard let userId = Auth.auth().currentUser?.uid else { return }

           let storageRef = Storage.storage().reference().child("profile_images").child("\(userId).jpg")
           storageRef.putData(imageData, metadata: nil) { (metadata, error) in
               if let error = error {
                   print("Error uploading image: \(error)")
                   return
               }
               storageRef.downloadURL { (url, error) in
                   if let error = error {
                       print("Error getting download URL: \(error)")
                       return
                   }
                   guard let url = url else { return }
                   let db = Firestore.firestore()
                   db.collection("users").document(userId).updateData(["profileImageUrl": url.absoluteString]) { error in
                       if let error = error {
                           print("Error updating profile image URL: \(error)")
                       }
                   }
               }
           }
       }


    
}
