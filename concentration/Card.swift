//
//  Card.swift
//  concentration
//
//  Created by Vinueza, Andres on 4/22/19.
//  Copyright © 2019 Vinueza, Andres. All rights reserved.
//

import Foundation

struct Card: Hashable {
    
    var hashValue: Int { return id }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.id == rhs.id
    }
    
    var isFaceUp = false
    var isMatched = false
    var isSeen = false
    private var id: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueId() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.id = Card.getUniqueId()
    }
}
