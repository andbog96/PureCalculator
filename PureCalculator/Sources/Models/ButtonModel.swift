//
//  ButtonType.swift
//  PureCalculator
//
//  Created by Andrey Bogdanov on 25.07.2020.
//  Copyright © 2020 Andbog. All rights reserved.
//

import Foundation

enum ButtonModel: String, CaseIterable {
    
    case cancel = "C"
    case calculate = "="
    
    case point = "."
    case zero = "0"
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    
    case add = "+"
    case subtract = "–"
    case multiply = "×"
    case divide = "÷"
    case percent = "%"
    case negate = "±"
    
    public var isDigit: Bool {
        self.rawValue.first!.isNumber
    }
    
    public var isSymbol: Bool {
        self == .point || isDigit
    }
    
    public var isOperation: Bool {
        !(isSymbol || self == .cancel || self == .calculate)
    }
    
    public var isUnary: Bool {
        switch self {
        case .percent,
             .negate:
            return true
        default:
            return false
        }
    }
}
