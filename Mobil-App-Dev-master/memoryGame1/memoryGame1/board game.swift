//
//  board game.swift
//  memoryGame1
//
//  Created by Ruchik Patel on 3/1/18.
//  Copyright © 2018 Ruchik Patel. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import FirebaseAuth

class board_game: UIViewController {

    // FLIP COUNTER
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var flipCountLabel: UILabel!
    var arrayOfEmoji = ["🏏", "🔨", "🏸", "🏈", "🍹", "🍉", "🌯", "🎮", "⌚️", "🗝", "🔑", "💯", "😎", "🐘", "🎓"]

    
    lazy var playGame = memoryGame(totalNumberOfPairs: (16 - 1) / 2)
    
    var ref: DatabaseReference!
    

    var temp = String(Cards.flipCount);

    // WE DONT NEED INIT FOR PLAYGAME SINCE WE CAN INIT WITH THE MEMORYGAME ITSELF
    // lazy var playGame = memoryGame(totalNumberOfPairs: (cardButtons.count + 1) / 2)
    // lazy var playGame = memoryGame(totalNumberOfPairs: Int)

    
    
  //  @IBOutlet var cardButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
 // initialize your reference
        ref = Database.database().reference()
        
//ref.child("timeo").setValue(true)
        self.ref.child("users").setValue(["username": temp])
    }
    
    

 
    
    @IBAction func oneBoard(_ sender: UIButton) {
        flipCounter()
        
        if let cardNumber = cardButtons.index(of: sender){
            //touchCard(symbol: arrayOfEmoji[cardNumber], on: sender)
            playGame.pickACard(at: cardNumber)
            updateViewFromModel()
        }
        
        else {
            print("There is some confusion, no card found")
        }
        
       // touchCard(symbol: "🏏", on: sender)
    }
    
    func updateViewFromModel(){
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = playGame.cards[index]
            if card.isFaceUp{
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1);
            }
            
            else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.7166388631, blue: 0.7730354071, alpha: 1);
            }
            
        }
    }
    
    
    // FLIP COUNT LABEL
    func flipCounter(){
        Cards.flipCount += 1
        flipCountLabel.text = "Count: \(Cards.flipCount)"

    }
    
    var emoji = Dictionary<Int, String>()
    
    
    func emoji(for card: Cards) -> String {
        if emoji[card.identity] ==  nil, arrayOfEmoji.count > 0{
           let randomIndex = Int(arc4random_uniform(UInt32(arrayOfEmoji.count)))
            emoji[card.identity] = arrayOfEmoji.remove(at: randomIndex)
            }

        return emoji[card.identity] ?? "?"
    }
    
}
