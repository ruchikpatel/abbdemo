//
//  optionsView.swift
//  memoryGame1
//
//  Created by Ruchik Patel on 3/1/18.
//  Copyright © 2018 Ruchik Patel. All rights reserved.
//

import UIKit
import GoogleSignIn
import Firebase

class optionsView: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
