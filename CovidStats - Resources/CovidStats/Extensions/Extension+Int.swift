//
//  Extension+Int.swift
//  CovidStats
//
//  Created by David Kababyan on 12/03/2022.
//

import Foundation

extension Int {
    
    var formatNumber: String {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: self))!
    }
    
    var roundedWithAbbreviations: String {
        
        let number = Double(self)
        let million = number / 1_000_000
        
        if million >= 1.0 {
            return "\(round(million*10)/10)M"
        } else {
            return "\(self.formatNumber)"
        }
    }
    
    
}
