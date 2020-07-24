//
//  CalculatorModel.swift
//  PureCalculator
//
//  Created by Andrey Bogdanov on 21.07.2020.
//  Copyright © 2020 Andbog. All rights reserved.
//

import Foundation

struct CalculatorModel {
    
    public static let point = "."
    
    enum ButtonType: Equatable {
        case add
        case subtract
        case multiply
        case divide
        case percent
        case negate
        case cancel
        case symbol(String)
        case calculate
        
        private static let map: [String: ButtonType] = [
            "+": .add,
            "–": .subtract,
            "×": .multiply,
            "÷": .divide,
            "%": .percent,
            "±": .negate,
            "C": .cancel,
            "=": .calculate,
        ]
        
        init?(_ string: String) {
            if let t = CalculatorModel.ButtonType.map[string] {
                self = t
            } else if string == point || Double(string) != nil {
                self = .symbol(string)
            } else {
                return nil
            }
        }
        
        public func toString() -> String {
            CalculatorModel.ButtonType.map.first { $1 == self }?.key ?? ""
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
    
    private(set) var firstNumber: Double = 0
    private(set) var secondNumber: Double? = nil
    private(set) var operation: ButtonType? = nil
    
    // False if number is inf, =inf or nan
    private(set) var isFinite = true
    
    // MARK: - Methods
    
    public mutating func setNumber(_ number: String) {
        guard isFinite else {
            return
        }
        
        let t = (number.last == CalculatorModel.point.last)
            ? Double(number.dropLast())
            : Double(number)
        
        guard let firstNumber = t else {
            fatalError("Wrong first number string!")
        }
        
        self.firstNumber = firstNumber
    }
    
    public mutating func setOperation(_ operation: ButtonType) {
        guard isFinite else {
            return
        }
        
        if operation.isUnary {
            let t = self.operation
            self.operation = operation
            calculate()
            self.operation = t
        } else {
            if secondNumber != nil {
                calculate()
            }
            
            secondNumber = firstNumber
            firstNumber = 0
            
            self.operation = operation
        }
    }
    
    public mutating func cancel() {
        if firstNumber.isZero {
            if operation != nil {
                operation = nil
                firstNumber = secondNumber ?? 0
                secondNumber = nil
            }
        } else {
            firstNumber = 0
            isFinite = true
        }
    }
    
    public mutating func calculate() {
        guard isFinite else {
            return
        }
        guard let operation = operation else {
            return
        }
        
        if !operation.isUnary && secondNumber == nil {
            fatalError("Second number is nil!")
        }
        
        let result: Double = {
            switch operation {
            case .add:
                return add(firstNumber, to: secondNumber!)
            case .subtract:
                return subtract(firstNumber, from: secondNumber!)
            case .multiply:
                return multiply(firstNumber, by: secondNumber!)
            case .divide:
                return divide(secondNumber!, by: firstNumber)
            case .percent:
                return percent(of: firstNumber)
            case .negate:
                return negate(firstNumber)
            default:
                fatalError("Missing operation!")
            }
        }()
        
        firstNumber = result
        if !firstNumber.isFinite {
            isFinite = false
        }
        self.operation = nil
        if !operation.isUnary {
            self.secondNumber = nil
        }
    }
    
    private func add(_ x: Double, to y: Double) -> Double {
        x + y
    }
    
    private func subtract(_ x: Double, from y: Double) -> Double {
        y - x
    }
    
    private func multiply(_ x: Double, by y: Double) -> Double {
        x * y
    }
    
    private func divide(_ x: Double, by y: Double) -> Double {
        x / y
    }
    
    private func percent(of x: Double) -> Double {
        x / 100
    }
    
    private func negate(_ x: Double) -> Double {
        -x
    }
}
