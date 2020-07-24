//
//  MainViewController.swift
//  PureCalculator
//
//  Created by Andrey Bogdanov on 21.07.2020.
//  Copyright © 2020 Andbog. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    typealias ButtonType = CalculatorModel.ButtonType
    
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var operationLabel: UILabel!
    
    private var calculator = CalculatorModel()
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateView()
    }
    
    @IBAction func onButtonTouchUpInside(_ sender: UIButton) {
        guard let firstLabelText = firstLabel.text else {
            fatalError("firstLabel.text is nil")
        }
        
        if let button = ButtonType(sender.titleLabel?.text ?? "") {
            if case let ButtonType.symbol(symbol) = button, calculator.isFinite {
                if symbol == CalculatorModel.point {
                    if !firstLabelText.contains(CalculatorModel.point.first!) {
                        firstLabel.text?.append(CalculatorModel.point)
                    }
                } else {
                    if firstLabelText == "0" {
                        firstLabel.text = symbol
                    } else if firstLabelText.count <= 20 {
                        firstLabel.text! += symbol
                    }
                }
            } else  {
                calculator.setNumber(firstLabelText)
                
                switch button {
                case .calculate:
                    calculator.calculate()
                case .cancel:
                    calculator.cancel()
                default:
                    calculator.setOperation(button)
                }
                
                updateView()
            }
        }
    }
    
    private func updateView() {
        firstLabel.text = String(calculated: calculator.firstNumber)
        operationLabel.text = calculator.operation?.toString()
        secondLabel.text = String(calculated: calculator.secondNumber) ?? ""
    }
}

