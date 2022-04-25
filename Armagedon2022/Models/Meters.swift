//
//  Meters.swift
//  Armagedon2022
//
//  Created by Alex Kulish on 25.04.2022.
//

import Foundation

struct Meters: Decodable {
    
    let estimatedDiameterMax: Double
    
    enum CodingKeys: String, CodingKey {
        case estimatedDiameterMax = "estimated_diameter_max"
    }
}
