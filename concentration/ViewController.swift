//
//  ViewController.swift
//  concentration
//
//  Created by Vinueza, Andres on 4/22/19.
//  Copyright © 2019 Vinueza, Andres. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    lazy var game = Concentration(numberOfPairOfCards: (cardButtons.count+1)/2)
    var emojis: [String] = ["👻", "🦇", "🍭", "😈", "🎃", "👻", "🍎", "🍬", "🙀", "😱"]
    var emoji = [Int:String]()
    
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardIndex = cardButtons.index(of: sender) {
            game.chooseCard(at: cardIndex)
            updateViewFromModel()
        } else {
            print("Chosen card not available")
        }
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if (!card.isFaceUp) {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
            } else {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }
        }
    }
    
    func emoji(for card: Card) -> String {
        if emoji[card.id] == nil, emojis.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojis.count)))
            emoji[card.id] = emojis.remove(at: randomIndex)
        }
        
        return emoji[card.id] ?? "?"
    }
}

