//
//  menuViewController.swift
//  memoryGame
//
//  Created by Ruchik Patel on 3/2/18.
//  Copyright © 2018 Ruchik Patel. All rights reserved.
//

import UIKit
import GoogleSignIn
import Firebase

class menuViewController: UIViewController {

    // SIGN OUT BUTTION
    @IBAction func signOut(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        do {
            GIDSignIn.sharedInstance().signOut()
            try firebaseAuth.signOut()
            print("User has been successfully logged out")
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
