//
//  LogInViewController.swift
//  IncuLink
//
//  Created by Ananya Kumar on 16/05/24.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseStorage


class FirebaseManager:NSObject {
    
    static let shared = FirebaseManager()
    
    let auth:Auth
    let storage:Storage
    let firestore:Firestore
    
    override init() {
        
        FirebaseApp.configure()
        
        self.auth = Auth.auth()
        self.storage = Storage.storage()
        self.firestore = Firestore.firestore()
        
        super.init()
    }
}



class LogInViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.password.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return password.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func loginTapped(_ sender: UIButton) {
        
        guard let email = email.text else{return}
        guard let password = password.text else {return}
        
        let auth = FirebaseAuth.Auth.auth()
        auth.signIn(withEmail: email, password: password) {
            firebaseResult,error in
            if let e = error{
                print(e)
            }
            else{
                print(firebaseResult?.user.uid)
                let storyboard = UIStoryboard(name:"Main",bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "mainn")
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc,animated: true)
            }
        }
    }
    
    
    @IBAction func noAccount(_ sender: Any) {
        
        let storyboard = UIStoryboard(name:"Main",bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "signup")
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc,animated: true)
        
    }
    
    
    private func storeUserInfo(){
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else{
            return
        }
        let userData = ["email":self.email ?? "Nomail","uid":uid] as [String : Any]
        FirebaseManager.shared.firestore.collection("users").document(uid).setData(userData){
            err in if let err = err{
                print(err)
                return
            }
            print("success")
        }
    }
    
    
}
