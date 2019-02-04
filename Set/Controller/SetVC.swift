//
//  ViewController.swift
//  Set
//
//  Created by Kareem Ismail on 1/12/19.
//  Copyright © 2019 Whatever. All rights reserved.
//

import UIKit

class SetVC: UIViewController {

    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var setCards: [UIButton]!
    var gameEngine: GameEngine!
    private (set) var isCurrentlyOnScreen: [Card] = []
    private (set) var isCurrentlySelected: [Card] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameEngine = GameEngine()
        isCurrentlyOnScreen = gameEngine.startGame()
        updateScreen()
    }
    
    func updateScreen(){
        for card in isCurrentlyOnScreen {
            if !card.isDrawn {
                assigningValues: for button in setCards {
                    if button.titleLabel?.text == nil {
                        didDraw(card: card, index: setCards.firstIndex(of: button)!)
                        var buttonTitle: NSAttributedString = NSAttributedString()
                        switch card.shading {
                        case .outlined : buttonTitle = NSAttributedString(string: String(repeating: card.shape.rawValue, count: card.number.rawValue), attributes: [.foregroundColor : card.color.colorValue, .strokeWidth : 5])
                        default : buttonTitle = NSAttributedString(string: String(repeating: card.shape.rawValue, count: card.number.rawValue), attributes: [.foregroundColor : card.color.colorValue.withAlphaComponent(CGFloat(card.shading.rawValue) / 100)])
                        }
                        button.setAttributedTitle(buttonTitle, for: .normal)
                        button.layer.borderColor = card.color.colorValue.cgColor
                        button.layer.borderWidth = 3.0
                        button.layer.cornerRadius = 8.0
                        break assigningValues
                    }
                }
            }
        }
        for button in setCards {
            if button.titleLabel?.text == nil {
                button.backgroundColor = view.backgroundColor
            }
        }
    }
    
    @IBAction func dealThreeMoreCards(_ sender: UIButton) {
        
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        print("did select card")
        let selectedCard = isCurrentlyOnScreen[setCards.firstIndex(of: sender)!]
        isCurrentlySelected.append(selectedCard)
        if isCurrentlySelected.count == 3 {
            let isSet = gameEngine.doesTheseCardsFormASet(card1: isCurrentlySelected[0], card2: isCurrentlySelected[1], card3: selectedCard)
            if isSet {
                for cards in 0..<3 {
                    isCurrentlyOnScreen.remove(at: isCurrentlyOnScreen.firstIndex(of: isCurrentlySelected[cards])!)
                }
                print("is set")
                isCurrentlySelected = []
            }
        }
    }
    
     func didDraw(card: Card, index: Int) {
        isCurrentlyOnScreen[isCurrentlyOnScreen.firstIndex(of: card)!].isDrawn = true
        isCurrentlyOnScreen[isCurrentlyOnScreen.firstIndex(of: card)!].associatedButtonIndex = index
    }
    
}

