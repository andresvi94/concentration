//
//  Card.swift
//  concentration
//
//  Created by Vinueza, Andres on 4/22/19.
//  Copyright © 2019 Vinueza, Andres. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    //TODO: make private
    var id: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueId() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.id = Card.getUniqueId()
    }
}
