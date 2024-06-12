//
//  OpportunityFormTableViewController.swift
//  IncuLink
//
//  Created by Ananya Kumar on 28/05/24.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

class OpportunityFormTableViewController: UITableViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // All the outlets of the form
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var companyNameTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
   
    @IBOutlet weak var needsExperiencedSwitch: UISwitch!
    @IBOutlet weak var skill1TextField: UITextField!
    @IBOutlet weak var skill2TextField: UITextField!
    
    @IBOutlet weak var descriptionTextView: UITextField!
    
    
    @IBOutlet weak var bookMarkSaved: UIButton!
    
    var opportunity: CollaborationOpportunity!
    let db = Firestore.firestore()
    let auth = FirebaseAuth.Auth.auth()
    let storage = Storage.storage()

    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(pickLogo(_:)))
                logoImageView.addGestureRecognizer(tapGesture)
                logoImageView.isUserInteractionEnabled = true


         self.clearsSelectionOnViewWillAppear = false

    }

    // MARK: - Table view data source

    // Action to pick an image for the logo
    
    
       @IBAction func pickLogo(_ sender: UITapGestureRecognizer) {
           let imagePickerController = UIImagePickerController()
           imagePickerController.delegate = self
           imagePickerController.sourceType = .photoLibrary
           present(imagePickerController, animated: true, completion: nil)
       }

       func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           if let selectedImage = info[.originalImage] as? UIImage {
               logoImageView.image = selectedImage
           }
           dismiss(animated: true, completion: nil)
       }

    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        print("Save called")
        dismiss(animated: true)
    }
    // Action to save the form data
       @IBAction func saveForm(_ sender: UIBarButtonItem) {
           
           
           guard let companyName = companyNameTextField.text, !companyName.isEmpty,
                 let title = titleTextField.text, !title.isEmpty,
                 let description = descriptionTextView.text, !description.isEmpty,
                 let skill1 = skill1TextField.text, !skill1.isEmpty,
                 let skill2 = skill2TextField.text, !skill2.isEmpty
                 else {
               // Show an alert if required fields are missing
               let alert = UIAlertController(title: "Error", message: "Please fill in all required fields.", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
               present(alert, animated: true, completion: nil)
               return
           }

           let location = locationTextField.text
           let needsExperience = needsExperiencedSwitch.isOn
           _ = logoImageView.image

           
           
           let storageRef = storage.reference()
           

           var downloadURLforimage = ""
           let fileName = "\(String(describing: auth.currentUser!.uid)).png"
           let imageRef = storageRef.child("Collab_logo/\(fileName)")
           guard let uploadData = self.logoImageView.image!.pngData() else { return }
           _ = imageRef.putData(uploadData) { (metadata, error) in
              
             guard let metadata = metadata else {
               return
             }
        
               _ = metadata.size
               imageRef.downloadURL { [self] (url, error) in
               guard let downloadURL = url else {
                 return
               }
                   opportunity = CollaborationOpportunity(companyName: companyName, title: title, location: location ?? "", description: description, needsExperience: needsExperience, skill1: skill1, skill2: skill2, user_id: self.auth.currentUser?.uid ?? "",logoDownloadUrl: downloadURLforimage, bookMark: bookMarkSaved.isSelected)
                 
                 downloadURLforimage = "\(downloadURL)"
                   print("DownloadUrl for firebase and user id: \(downloadURLforimage) and user \(self.auth.currentUser?.uid ?? "")")
                 self.db.collection("Collab").addDocument(data: [
                    "user_id" : self.auth.currentUser?.uid ?? "",
                    "company_name" : self.opportunity.companyName,
                    "title" : self.opportunity.title,
                    "description" : self.opportunity.description,
                    "experience" : self.opportunity.needsExperience,
                    "location" : self.opportunity.location,
                    "skill1" : self.opportunity.skill1,
                    "skill2" : self.opportunity.skill2,
                  "logoDownloadUrl" : downloadURLforimage
                  
                 ])
             }
           }
           
           
           

//           navigationController?.popViewController(animated: true)
           dismiss(animated: true)
       }
    
   }
   
