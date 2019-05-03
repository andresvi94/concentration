//
//  ViewController.swift
//  concentration
//
//  Created by Vinueza, Andres on 4/22/19.
//  Copyright © 2019 Vinueza, Andres. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var game: Concentration!
    private var emoji = [Int:String]()
    private var emojis = [String]()
    typealias ThemeData = (emoji: [String], backGroundColor: UIColor, cardBackColor: UIColor)
    
    private let themeData: [String: ThemeData] = [
        "animals": (["🐶", "🙊", "🐧", "🦁", "🐆", "🐄", "🐿", "🐠", "🦆", "🦉"], #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1), #colorLiteral(red: 0.5808190107, green: 0.0884276256, blue: 0.3186392188, alpha: 1)),
        "faces": (["😀", "🤪", "😬", "😭", "😎", "😍", "🤠", "😇", "🤩", "🤢"], #colorLiteral(red: 0.0008611764706, green: 0, blue: 0, alpha: 1), #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)),
        "fruits": (["🍏", "🥑", "🍇", "🍒", "🍑", "🥝", "🍐", "🍎", "🍉", "🍌"], #colorLiteral(red: 0.5808190107, green: 0.0884276256, blue: 0.3186392188, alpha: 1), #colorLiteral(red: 0, green: 0.9810667634, blue: 0.5736914277, alpha: 1)),
        "people": (["👩", "👮🏻‍♂️", "👩‍💻", "👨🏾‍🌾", "🧟‍♀️", "👩🏽‍🎨", "👩🏼‍🍳", "🧕🏼", "💆‍♂️", "🤷🏽‍♂️"], #colorLiteral(red: 0.0008611764706, green: 0, blue: 0, alpha: 1), #colorLiteral(red: 0.4513868093, green: 0.9930960536, blue: 1, alpha: 1)),
        "sports": (["🏊🏽‍♀️", "🤽🏻‍♀️", "🤾🏾‍♂️", "⛹🏼‍♂️", "🏄🏻‍♀️", "🚴🏻‍♀️", "🚣🏿‍♀️", "⛷", "🏋🏿‍♀️", "🤸🏼‍♂️"], #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1), #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)),
        "transport": (["🚗", "🚓", "🚚", "🏍", "✈️", "🚜", "🚎", "🚲", "🚂", "🛴"], #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), #colorLiteral(red: 0.9995340705, green: 0.988355577, blue: 0.4726552367, alpha: 1)),
    ]
    
    private var newTheme: ThemeData {
        let randomIndex = themeData.count.arc4random
        let key = Array(themeData.keys)[randomIndex]
        return themeData[key]!
    }
    
    private var theme: ThemeData! {
        didSet {
            view.backgroundColor = theme.backGroundColor
            cardButtons.forEach {
                $0.backgroundColor = theme.cardBackColor
                $0.setTitle("", for: UIControlState.normal)
            }
            newGameButton.backgroundColor = theme.cardBackColor
            newGameButton.setTitleColor(theme.backGroundColor, for: UIControlState.normal)
            flipCountLabel.textColor = theme.cardBackColor
            scoreCountLabel.textColor = theme.cardBackColor
        }
    }

    var numberOfPairsOfCards: Int {
        get {
            return (cardButtons.count+1)/2
        }
    }
    
    private(set) var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }

    override func viewDidLoad() {
        startNewGame()
    }
    
    private func startNewGame() {
        newGameButton.isHidden = true
        theme = newTheme
        game = Concentration(numberOfPairOfCards: numberOfPairsOfCards)
        flipCountLabel.text = "Flips: \(game.flipCount)"
        emoji = [:]
        emojis = theme.emoji
    }
    
    @IBOutlet private weak var scoreCountLabel: UILabel!
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBOutlet weak var newGameButton: UIButton!
    @IBAction func onNewGame(_ sender: UIButton) {
        startNewGame()
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardIndex = cardButtons.index(of: sender) {
            game.chooseCard(at: cardIndex)
            updateViewFromModel()
            flipCountLabel.text = "Flips: \(game.flipCount)"
            scoreCountLabel.text = "Score: \(game.scoreCount)"
        } else {
            print("Chosen card not available")
        }
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if (!card.isFaceUp) {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 0) : theme.cardBackColor
            } else {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }
            
            if (game.totalMatches == 0){
                newGameButton.isHidden = false
            }
        }
    }
    
    private func emoji(for card: Card) -> String {
        if emoji[card.id] == nil, emojis.count > 0 {
            emoji[card.id] = emojis.remove(at: emojis.count.arc4random)
        }
        
        return emoji[card.id] ?? "?"
    }
    
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(self)))
        }else {
            return 0
        }
        
    }
}

