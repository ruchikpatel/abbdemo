//
//  Cards.swift
//  memoryGame1
//
//  Created by Ruchik Patel on 3/3/18.
//  Copyright © 2018 Ruchik Patel. All rights reserved.
//

import Foundation

struct Cards {
    
    var isFaceUp = false
    var isMatched = false
    var identity : Int
    static var flipCount = 0
    
    static var indentityFactory = 0
    
    static func getUniqueIdentity() -> Int{
        Cards.indentityFactory += 1
        return Cards.indentityFactory
    }
    
    init (identity: Int){
        self.identity = Cards.getUniqueIdentity()
    }
    
}
