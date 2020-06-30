//
//  memoryGame.swift
//  memoryGame1
//
//  Created by Ruchik Patel on 3/3/18.
//  Copyright © 2018 Ruchik Patel. All rights reserved.
//  This entire Project was taught by Stanford Univeristy, Michael. Taken from Youtube

import Foundation
import Firebase
import GoogleSignIn


class memoryGame
{
    var cards = [Cards]()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func pickACard(at index: Int){
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index
            {
                //
                if cards[matchIndex].identity == cards[index].identity{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            }
        
            else {
                
                for flipDownIndex in cards.indices{
                    cards[flipDownIndex].isFaceUp = false
                }
                
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
                
            }
            
        }
        
    }
    
    
    init(totalNumberOfPairs: Int) {
        
        assert(totalNumberOfPairs > 0, "Concentration.numberOfPairs(\(totalNumberOfPairs)) Number of pairs must be at least one")
        var unshuffledCards = [Cards]()
        
        
        for identity in 0...totalNumberOfPairs{
            let card = Cards(identity: identity)
           
            
            unshuffledCards += [card, card]
            // cards.append(card)
            //cards.append(card)
        }
        
        while !unshuffledCards.isEmpty {
            let randomIndex = Int(arc4random_uniform(UInt32(unshuffledCards.count)))
            let card = unshuffledCards.remove(at: randomIndex)
            cards.append(card)
        }
      
  /*
        for index in cards.indices {
            var newIndex = Int(arc4random_uniform(UInt32(cards.count)))
            if index == newIndex{
                newIndex = Int(arc4random_uniform(UInt32(cards.count)))
            }
           
        }*/
        
        }
    
    
}



