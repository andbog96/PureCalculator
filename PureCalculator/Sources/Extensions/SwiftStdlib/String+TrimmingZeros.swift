//
//  String+TrimmingZeros.swift
//  PureCalculator
//
//  Created by Andrey Bogdanov on 23.07.2020.
//  Copyright © 2020 Andbog. All rights reserved.
//
import Foundation

extension String {
    
    public func detailedDescription() -> String {
        switch self {
        case "nan":
            return "Not a number"
        case "inf":
            return "Infinity"
        case "-inf":
            return "-Infinity"
        default:
            return self
        }
    }
    
    public func trimZeros() -> String {
        if let double = Double(self) {
            let fractional = modf(double).1
            if double.isFinite && fractional.isZero {
                return String(Int(double))
            } else {
                return String(double)
            }
        } else {
            return self
        }
    }
}
