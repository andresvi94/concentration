//
//  Concentration.swift
//  concentration
//
//  Created by Vinueza, Andres on 4/22/19.
//  Copyright © 2019 Vinueza, Andres. All rights reserved.
//

import Foundation

class Concentration {
    private(set) var totalMatches = 0
    private(set) var flipCount = 0
    private(set) var scoreCount = 0
    private(set) var cards = [Card]()
    private var indexOfOnlyFacedUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        flipCount += 1
        if !cards[index].isMatched {
            if let matchIndex = indexOfOnlyFacedUpCard, matchIndex != index {
                if cards[matchIndex].id == cards[index].id {
                    cards[index].isMatched = true
                    cards[matchIndex].isMatched = true
                    scoreCount += 2
                    totalMatches -= 1
                    print("totalMatches: \(totalMatches)")
                } else if (cards[matchIndex].isSeen && cards[index].isSeen) {
                    scoreCount -= 2
                } else if (cards[matchIndex].isSeen || cards[index].isSeen){
                    scoreCount -= 1
                }
                cards[index].isFaceUp = true
                cards[index].isSeen = true
            } else {
                indexOfOnlyFacedUpCard = index
            }
        }
    }
    
    init(numberOfPairOfCards: Int) {
        assert(numberOfPairOfCards > 0, "Concentration.init(\(numberOfPairOfCards)): you must have at least one pair of cards")
        totalMatches = numberOfPairOfCards
        
        for _ in 1...numberOfPairOfCards {
            let card = Card()
            cards += [card, card]
        }
        
        //shuffle cards
        for index in cards.indices {
            let rand = cards.count.arc4random
            cards.swapAt(index, rand)
        }
        
    }
}


