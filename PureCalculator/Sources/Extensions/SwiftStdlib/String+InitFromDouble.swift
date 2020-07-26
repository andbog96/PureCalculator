//
//  String+InitFromDouble.swift
//  PureCalculator
//
//  Created by Andrey Bogdanov on 24.07.2020.
//  Copyright © 2020 Andbog. All rights reserved.
//
import Foundation

extension String {
    
    public init?(from double: Double?) {
        guard let double = double else {
            return nil
        }
        
        let formatter = NumberFormatter()
        formatter.generatesDecimalNumbers = true
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 20
        let string = formatter.string(for: double) ?? "0"
        
        self = (string == "NaN") ? "Not a number" : string
    }
}
