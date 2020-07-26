//
//  CalculatorModelProtocol.swift
//  PureCalculator
//
//  Created by Andrey Bogdanov on 25.07.2020.
//  Copyright © 2020 Andbog. All rights reserved.
//

protocol CalculatorModelProtocol {
    var isFinite: Bool { get }
    
    var firstNumber: Double { get }
    var secondNumber: Double? { get }
    var operation: ButtonModel? { get }
    
    mutating func setNumber(_: String)
    mutating func setOperation(_: ButtonModel)
    mutating func cancel()
    mutating func calculate()
    
}
