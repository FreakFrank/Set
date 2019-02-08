//
//  GameEngine.swift
//  Set
//
//  Created by Kareem Ismail on 1/12/19.
//  Copyright © 2019 Whatever. All rights reserved.
//

import Foundation

struct GameEngine {
    
    private(set) var theWholeSetOfCards: [Card] = []
    private(set) var score = 0
    
    init() {
        for color in 0...2 {
            for shape in 0...2 {
                for shading in 0...2 {
                    for number in 0...2 {
                        theWholeSetOfCards.append(Card(color: color, shape: shape, shading: shading, number: number))
                    }
                }
            }
        }
    }
    
    mutating func startGame() -> [Card] {
        var startingSetOfCards: [Card] = []
        for _ in 0..<12 {
            startingSetOfCards.append(theWholeSetOfCards.remove(at: theWholeSetOfCards.count.randomInteger))
        }
        return startingSetOfCards
    }
    
    
    mutating func dealThreeMoreCards() -> ([Card], Int){
        var threeMoreCards: [Card] = []
        for _ in 0..<3 {
            threeMoreCards.append(theWholeSetOfCards.remove(at: theWholeSetOfCards.count.randomInteger))
        }
        return (threeMoreCards, theWholeSetOfCards.count)
    }
    
    mutating func doesTheseCardsFormASet(card1: Card, card2: Card, card3: Card) -> Bool {
        for property in 0...3 {
            if !((card1[property] == card2[property]) && (card1[property] == card3[property]) && (card2[property] == card3[property]) || (card1[property] != card2[property]) && (card1[property] != card3[property]) && (card2[property] != card3[property])) {
                score -= 2
                return false
            }
        }
        score += 3
        return true
    }
}

extension Int {
    var randomInteger: Int {
        get {
            return Int(arc4random_uniform(UInt32(self)))
        }
    }
}
