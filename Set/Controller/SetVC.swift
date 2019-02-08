//
//  ViewController.swift
//  Set
//
//  Created by Kareem Ismail on 1/12/19.
//  Copyright © 2019 Whatever. All rights reserved.
//

import UIKit

class SetVC: UIViewController {
    
    @IBOutlet weak var dealThreeMoreCardsButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var setCards: [UIButton]!
    var gameEngine: GameEngine!
    
    private (set) var isCurrentlyOnScreen: [Card] = [] {
        didSet {
            if isCurrentlyOnScreen.count == 24 {
                dealThreeMoreCardsButton.isEnabled = false
            }
        }
    }
    
    private (set) var isCurrentlySelected: [Card] = []
    var cardsRemainingInDeck = 69 {
        willSet {
            if newValue == 0 {
                dealThreeMoreCardsButton.isEnabled = false
            }
        }
    }
    
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
                    if button.attributedTitle(for: .normal) == nil {
                        button.isEnabled = true
                        didDraw(card: card, index: setCards.firstIndex(of: button)!)
                        var buttonTitle: NSAttributedString = NSAttributedString()
                        switch card.shading {
                        case .outlined : buttonTitle = NSAttributedString(string: String(repeating: card.shape.rawValue, count: card.number.rawValue), attributes: [.foregroundColor : card.color.colorValue, .strokeWidth : 5])
                        default : buttonTitle = NSAttributedString(string: String(repeating: card.shape.rawValue, count: card.number.rawValue), attributes: [.foregroundColor : card.color.colorValue.withAlphaComponent(CGFloat(card.shading.rawValue) / 100)])
                        }
                        button.setAttributedTitle(buttonTitle, for: .normal)
                        button.layer.cornerRadius = 8.0
                        break assigningValues
                    }
                }
            }
        }
        setVisibiltyOfTheCards()
    }
    
    func setVisibiltyOfTheCards() {
        for button in setCards {
            if button.attributedTitle(for: .normal) == nil {
                button.backgroundColor = view.backgroundColor
                button.isEnabled = false
                button.layer.borderWidth = 0
            }
            else {
                button.backgroundColor = UIColor.red
            }
        }
    }
    
    @IBAction func dealThreeMoreCards(_ sender: UIButton) {
        let (threeMoreCardsToBeAdded, countOfTheRemainingCards) = gameEngine.dealThreeMoreCards()
        isCurrentlyOnScreen += threeMoreCardsToBeAdded
        cardsRemainingInDeck = countOfTheRemainingCards
        updateScreen()
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        gameEngine = GameEngine()
        isCurrentlyOnScreen.removeAll()
        isCurrentlySelected.removeAll()
        for button in setCards {
            button.setAttributedTitle(nil, for: .normal)
            button.layer.borderWidth = 0
        }
        isCurrentlyOnScreen = gameEngine.startGame()
        cardsRemainingInDeck = 69
        updateScreen()
    }
    
    func getTheCardAssociatedWithTheSelectedButton(buttonIndex: Int) -> Card {
        var card = isCurrentlyOnScreen.filter({$0.associatedButtonIndex == buttonIndex})
        return card[0]
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        let selectedCard = getTheCardAssociatedWithTheSelectedButton(buttonIndex: setCards.firstIndex(of: sender)!)
        if isCurrentlySelected.contains(selectedCard) && isCurrentlySelected.count < 3 {
            sender.layer.borderWidth = 0
            isCurrentlySelected.remove(at: isCurrentlySelected.firstIndex(of: selectedCard)!)
            updateScreen()
            return
        }
        sender.layer.borderColor = selectedCard.color.colorValue.cgColor
        sender.layer.borderWidth = 4.0
        isCurrentlySelected.append(selectedCard)
        if isCurrentlySelected.count == 3 {
            let isSet = gameEngine.doesTheseCardsFormASet(card1: isCurrentlySelected[0], card2: isCurrentlySelected[1], card3: selectedCard)
            if isSet {
                showToast(message: "MATCH 🔥")
                for cards in 0..<3 {
                    let cardToBeRemoved = isCurrentlyOnScreen.remove(at: isCurrentlyOnScreen.firstIndex(of: isCurrentlySelected[cards])!)
                    setCards[cardToBeRemoved.associatedButtonIndex].setAttributedTitle(nil, for: .normal)
                    setCards[cardToBeRemoved.associatedButtonIndex].layer.borderWidth = 0.0
                }
                if cardsRemainingInDeck != 0 {
                    let (threeMoreCardsToBeAdded, countOfTheRemainingCards) = gameEngine.dealThreeMoreCards()
                    isCurrentlyOnScreen += threeMoreCardsToBeAdded
                    cardsRemainingInDeck = countOfTheRemainingCards
                }
                updateScreen()
            }
            else {
                showToast(message: "Mismatch 🤬")
                for card in isCurrentlySelected {
                    setCards[card.associatedButtonIndex].layer.borderWidth = 0.0
                }
            }
            isCurrentlySelected = []
            updateScore()
        }
    }
    func updateScore(){
        scoreLabel.text = "Score: \(gameEngine.score)"
    }
     func didDraw(card: Card, index: Int) {
        isCurrentlyOnScreen[isCurrentlyOnScreen.firstIndex(of: card)!].isDrawn = true
        isCurrentlyOnScreen[isCurrentlyOnScreen.firstIndex(of: card)!].associatedButtonIndex = index
    }
}

