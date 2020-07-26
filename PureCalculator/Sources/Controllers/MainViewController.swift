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
    
    private var calculator: CalculatorModelProtocol = CalculatorModel()
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateView()
    }
    
    @IBAction func onButtonTouchUpInside(_ sender: UIButton) {
        guard let firstLabelText = firstLabel.text else {
            fatalError("firstLabel.text is nil")
        }
        
        if let button = ButtonModel(rawValue: sender.titleLabel?.text ?? "") {
            if button.isSymbol && calculator.isFinite {
                if button == .point {
                    if !firstLabelText.contains(button.rawValue) {
                        firstLabel.text?.append(button.rawValue)
                    }
                } else { // button is digit
                    if firstLabelText == "0" {
                        firstLabel.text = button.rawValue
                    } else if firstLabelText.count <= 20 {
                        firstLabel.text! += button.rawValue
                    }
                }
            } else {
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
        firstLabel.text = String(from: calculator.firstNumber)
        operationLabel.text = calculator.operation?.rawValue ?? ""
        secondLabel.text = String(from: calculator.secondNumber) ?? ""
    }
}

