//
//  Card.swift
//  Set
//
//  Created by Kareem Ismail on 1/12/19.
//  Copyright © 2019 Whatever. All rights reserved.
//

import UIKit

struct Card: Equatable {
    let color: Color
    let shape: Shape
    let shading: Shading
    let number: Number
    var isSelected = false
    var isMatched = false
    var isDrawn = false
    var associatedButtonIndex: Int!
    
    init(color: Int, shape: Int, shading: Int, number: Int) {
        self.color = Color.allCases[color]
        self.shape = Shape.allCases[shape]
        self.shading = Shading.allCases[shading]
        self.number = Number.allCases[number]
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return (lhs.color == rhs.color) && (lhs.number == rhs.number) && (lhs.shading == rhs.shading) && (lhs.shape == rhs.shape)
    }
    
    
    subscript(index: Int) -> String {
        switch index {
        case 0: return color.rawValue
        case 1: return shape.rawValue
        case 2: return String(shading.rawValue)
        default: return String(number.rawValue)
        }
    }
    
    
    func getCardProperties(whicProperty: Int) -> String {
        switch whicProperty {
        case 0: return color.rawValue
        case 1: return shape.rawValue
        case 2: return String(shading.rawValue)
        default: return String(number.rawValue)
        }
    }
    
    
}

enum Color: String, CaseIterable {
    case black
    case green
    case yellow
}

enum Shape: String, CaseIterable {
    case triangle = "▲"
    case square = "■"
    case circle = "●"
}

enum Shading: Int, CaseIterable {
    case filled = 100
    case striped = 40
    case outlined = 5
}

enum Number: Int, CaseIterable {
    case one = 1
    case two
    case three
}

extension Color {
    var colorValue: UIColor {
        get {
            switch self {
            case .black:
                return UIColor.black
            case .yellow:
                return UIColor.yellow
            case .green:
                return UIColor.green
            }
        }
    }
}

