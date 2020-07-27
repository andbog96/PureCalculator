//
//  PureCalculatorTests.swift
//  PureCalculatorTests
//
//  Created by Andrey Bogdanov on 26.07.2020.
//  Copyright © 2020 Andbog. All rights reserved.
//

import XCTest
@testable import PureCalculator

class PureCalculatorTests: XCTestCase {
    
    var calc: CalculatorModelProtocol!

    override func setUpWithError() throws {
        calc = CalculatorModel()
    }

    override func tearDownWithError() throws {
        calc = nil
    }

    func testModuleIsNotNil() throws {
        XCTAssertNotNil(calc)
    }
    
    func testSetup() throws {
        calc.setNumber("1")
        calc.setOperation(.add)
        calc.setNumber("2")
        XCTAssert(calc.firstNumber == 2)
        XCTAssert(calc.operation == .add)
        XCTAssert(calc.secondNumber == 1)
    }
    
    func testCancel() throws {
        calc.setNumber("1")
        calc.cancel()
        XCTAssert(calc.firstNumber.isZero)
        
        calc.setNumber("1")
        calc.setOperation(.add)
        calc.cancel()
        XCTAssert(calc.firstNumber == 1)
        XCTAssert(calc.operation == nil)
    }
    
    func testUnaryOperations() throws {
        calc.setNumber("10")
        calc.setOperation(.negate)
        XCTAssert(calc.firstNumber == -10)
        
        calc.setNumber("3")
        calc.setOperation(.percent)
        XCTAssert(calc.firstNumber == 0.03)
    }
    
    func testOperations() throws {
        calc.setNumber("1")
        for op in ButtonModel.allCases where op.isOperation && !op.isUnary {
            calc.setOperation(op)
            XCTAssert(calc.operation == op)
            
        }
    }
}
