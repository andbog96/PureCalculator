//
//  String+InitCalculated.swift
//  PureCalculator
//
//  Created by Andrey Bogdanov on 24.07.2020.
//  Copyright © 2020 Andbog. All rights reserved.
//

extension String {
    
    public init?(calculated double: Double?) {
        guard let double = double else {
            return nil
        }
        
        let string = String(double)
        
        switch string {
        case "nan":
            self = "Not a number"
        case "inf":
            self =  "Infinity"
        case "-inf":
            self =  "-Infinity"
        default:
            if string.suffix(2) == ".0" {
                self = String(string.dropLast(2))
            } else {
                self = string
            }
        }
    }
}
