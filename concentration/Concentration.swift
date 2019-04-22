//
//  Concentration.swift
//  concentration
//
//  Created by Vinueza, Andres on 4/22/19.
//  Copyright © 2019 Vinueza, Andres. All rights reserved.
//

import Foundation

class Concentration {
    var cards = [Card]()
    var indexOfOnlyFacedUpCard: Int?
    
    init(numberOfPairOfCards: Int) {
        
        for _ in 1...numberOfPairOfCards {
            let card = Card()
            cards += [card, card]
        }
        
        //TODO: Shuffle cards
    }
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOnlyFacedUpCard, matchIndex != index {
                if cards[matchIndex].id == cards[index].id {
                    cards[index].isMatched = true
                    cards[matchIndex].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOnlyFacedUpCard = nil
            } else {
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                    indexOfOnlyFacedUpCard = index
                }
            }
        }
    }
}
