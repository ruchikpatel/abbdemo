//
//  ViewController.swift
//  memoryGame
//
//  Created by Ruchik Patel on 2/24/18.
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
        googleButton.frame = CGRect(x: 16, y: 116 + 66, width: view.frame.width - 32, height: 80)
        
        view.addSubview(googleButton)
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        // PERFORMS SEGUE AFTER LOGGING
        handle = Auth.auth().addStateDidChangeListener{
            (auth, user) in
            if user != nil{
                self.performSegue(withIdentifier: "loginToMenu", sender: nil)
            }
                
            else{
                print("Back to logging")
            }
        }

        
        
    }
    
    

    
    
    
    
}

