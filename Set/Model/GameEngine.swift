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
    private(set) var isCurrentlyOnScreen: [Card] = []
    private(set) var isCurrentlySelected: [Card] = []
    
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
        for _ in 0..<12 {
            isCurrentlyOnScreen.append(theWholeSetOfCards.remove(at: theWholeSetOfCards.count.randomInteger))
        }
    }
    
    mutating func selectCard(card: Card) {
        print("did select card")
        isCurrentlySelected.append(card)
        if isCurrentlySelected.count == 3 {
            let isSet = doesTheseCardsFormASet(card1: isCurrentlySelected[0], card2: isCurrentlySelected[1], card3: card)
            if isSet {
                for cards in 0..<3 {
                    isCurrentlyOnScreen.remove(at: isCurrentlyOnScreen.firstIndex(of: isCurrentlySelected[cards])!)
                }
                print("is set")
                isCurrentlySelected = []
            }
        }
    }
    
    mutating func didDraw(card: Card, index: Int) {
        isCurrentlyOnScreen[isCurrentlyOnScreen.firstIndex(of: card)!].isDrawn = true
        isCurrentlyOnScreen[isCurrentlyOnScreen.firstIndex(of: card)!].associatedButtonIndex = index
    }
    
    func dealThreeMoreCards(){
        
    }
    
    func doesTheseCardsFormASet(card1: Card, card2: Card, card3: Card) -> Bool {
        for property in 0...3 {
            if !((card1[property] == card2[property]) && (card1[property] == card3[property]) && (card2[property] == card3[property]) || (card1[property] != card2[property]) && (card1[property] != card3[property]) && (card2[property] != card3[property])) {
                return false
            }
        }
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
