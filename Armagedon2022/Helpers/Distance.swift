//
//  Distance.swift
//  Armagedon2022
//
//  Created by Alex Kulish on 26.04.2022.
//

import Foundation

enum Distance: Int, CaseIterable {
    case kilometers
    case lunar
    
    var distanceFormat: String {
        switch self {
        case .kilometers:
            return "км"
        case .lunar:
            return "л.орб"
        }
        
    }
    
    static func getFormat(atIndex index: Int) -> Distance {
        return self.allCases[index]
    }
    
}
