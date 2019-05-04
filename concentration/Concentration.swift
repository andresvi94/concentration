//
//  Concentration.swift
//  concentration
//
//  Created by Vinueza, Andres on 4/22/19.
//  Copyright © 2019 Vinueza, Andres. All rights reserved.
//

import Foundation

struct Concentration {
    private(set) var totalMatches = 0
    private(set) var flipCount = 0
    private(set) var scoreCount = 0
    private(set) var cards = [Card]()
    private var indexOfOnlyFacedUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        flipCount += 1
        if !cards[index].isMatched {
            if let matchIndex = indexOfOnlyFacedUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    cards[index].isMatched = true
                    cards[matchIndex].isMatched = true
                    scoreCount += 2
                    totalMatches -= 1
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

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
