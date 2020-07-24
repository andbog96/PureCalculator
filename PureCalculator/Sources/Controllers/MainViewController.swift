//
//  MainViewController.swift
//  PureCalculator
//
//  Created by Andrey Bogdanov on 21.07.2020.
//  Copyright © 2020 Andbog. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var operationLabel: UILabel!
    
    private var calculator = CalculatorModel()
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        secondLabel.text = ""
        operationLabel.text = ""
        firstLabel.text = "0"
    }
    
    @IBAction func onButtonTouchUpInside(_ sender: UIButton) {
        guard let firstLabelText = firstLabel.text else {
            fatalError("firstLabel.text is nil")
        }
        
        if let buttonString = sender.titleLabel?.text {
            if Double(buttonString) != nil {
                if calculator.isFinite {
                    if firstLabelText == "0" {
                        firstLabel.text = buttonString
                    } else if firstLabelText.count <= 20 {
                        firstLabel.text! += buttonString
                    }
                }
                return
            } else if buttonString == "." {
                if calculator.isFinite && firstLabel.text?.firstIndex(of: ".") == nil {
                    firstLabel.text?.append(".")
                }
                return
            } else  {
                calculator.setNumber(firstLabel.text!)
                
                if buttonString == "=" {
                    calculator.calculate()
                } else {
                    switch buttonString {
                    case "C":
                        calculator.cancel()
                    default:
                        calculator.setOperation(buttonString)
                    }
                }
            }
        }
        
        updateView()
    }
    
    private func updateView() {
        firstLabel.text = String(calculator.firstNumber).trimZeros().detailedDescription()
        operationLabel.text = calculator.operation?.rawValue ?? ""
        
        if let secondNumber = calculator.secondNumber {
            secondLabel.text = String(secondNumber).trimZeros().detailedDescription()
        } else {
            secondLabel.text = ""
        }
        
        
    }
}

