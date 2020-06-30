//
//  constants.swift
//  memoryGame1
//
//  Created by Ruchik Patel on 3/28/18.
//  Copyright © 2018 Ruchik Patel. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

struct constants {
    
    struct refs
    {
        static let databaseRoot = Database.database().reference()
        static let databaseChats = databaseRoot.child("chats")
    }
}
