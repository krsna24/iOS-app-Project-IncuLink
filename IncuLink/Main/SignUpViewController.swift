//
//  SignUpViewController.swift
//  IncuLink
//
//  Created by Batch-2 on 27/05/24.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore


class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var phoneNo: UITextField!
    
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
            super.viewDidLoad()

            self.password.delegate = self
            self.phoneNo.delegate = self
        }

        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            return textField.resignFirstResponder()
        }
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
        
        @IBAction func signUpTapped(_ sender: UIButton) {
            guard let email = email.text, !email.isEmpty else {
                showAlert(message: "Email field is empty")
                return
            }
            guard let password = password.text, !password.isEmpty else {
                showAlert(message: "Password field is empty")
                return
            }
            guard let userName = userName.text, !userName.isEmpty else {
                showAlert(message: "User name field is empty")
                return
            }
            guard let phoneNo = phoneNo.text, !phoneNo.isEmpty else {
                showAlert(message: "Phone number field is empty")
                return
            }
            
            // Phone number validation
            guard phoneNo.count == 10, phoneNo.allSatisfy({ $0.isNumber }) else {
                showAlert(message: "Phone number must be exactly 10 digits")
                return
            }
            
            // Password validation
            guard password.count >= 8 else {
                showAlert(message: "Password must be at least 8 characters long")
                return
            }
            
            Auth.auth().createUser(withEmail: email, password: password) { firebaseResult, error in
                if let error = error {
                    self.showAlert(message: "Error creating user: \(error.localizedDescription)")
                    return
                }
                
                guard let uid = firebaseResult?.user.uid else {
                    self.showAlert(message: "User ID not found")
                    return
                }
                
                // Save user details to Firestore
                self.db.collection("users").document(uid).setData([
                    "email": email,
                    "uid": uid,
                    "userName": userName,
                    "phoneNo": phoneNo,
                ]) { error in
                    if let error = error {
                        self.showAlert(message: "Error saving user data: \(error.localizedDescription)")
                    } else {
                        print("User data saved successfully")
                        // Navigate to the next screen or perform other actions
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "mainn")
                        vc.modalPresentationStyle = .overFullScreen
                        self.present(vc, animated: true)
                    }
                }
            }
        }
        
        @IBAction func alreadyAccount(_ sender: Any) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "login")
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        }
        
        // Helper function to show alert
        func showAlert(message: String) {
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
  }
    
    
