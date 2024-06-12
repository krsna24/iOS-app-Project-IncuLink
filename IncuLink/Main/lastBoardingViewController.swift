//
//  lastBoardingViewController.swift
//  IncuLink
//
//  Created by Batch-2 on 29/05/24.
//

import UIKit

class lastBoardingViewController: UIViewController {
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func goesToSign(_ sender: UIButton) {
        performSegue(withIdentifier: "showSignUp", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "showSignUp" {
                
            }
        }
    
}
