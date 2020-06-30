//
//  ViewController.swift
//  memoryGame1
//
//  Created by Ruchik Patel on 2/25/18.
//  Copyright © 2018 Ruchik Patel. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn


class ViewController: UIViewController, GIDSignInUIDelegate {
    
    var handle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //GOOGLE SIGN IN BUTTON
        let googleButton = GIDSignInButton()
        googleButton.frame = CGRect(x: 16, y: 116 + 66, width: view.frame.width - 32, height: 50)
        
        view.addSubview(googleButton)
        
        GIDSignIn.sharedInstance().uiDelegate = self
       
        handle = Auth.auth().addStateDidChangeListener{
        (auth, user) in
            if user != nil{
            self.performSegue(withIdentifier: "optionMenu", sender: nil)
            }
           
            else{
            print("Sorry bruh")
            }
        }
        
    }

    
    
    

/*    @IBAction func signOut(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        do {
            GIDSignIn.sharedInstance().signOut()
            try firebaseAuth.signOut()
            print("User has been successfully logged out")
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        

    }
*/
    /*
    func ifSignedIn()
    {
        if GIDSignIn.sharedInstance().hasAuthInKeychain()
        {
            googleButton.isHidden = true
            
            
        }
        
        else
        {
           
            googleButton.isHidden = false
        }
        
    }*/

}

