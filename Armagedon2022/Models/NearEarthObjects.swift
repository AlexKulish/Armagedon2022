//
//  NearEarthObjects.swift
//  Armagedon2022
//
//  Created by Alex Kulish on 25.04.2022.
//

import Foundation

struct NearEarthObjects: Decodable {
    
    let name: String
    let isPotentiallyHazardousAsteroid: Bool
    let estimatedDiameter: EstimatedDiameter
    let closeApproachData: [CloseApproachData]
    
    enum CodingKeys: String, CodingKey {
        case name
        case isPotentiallyHazardousAsteroid = "is_potentially_hazardous_asteroid"
        case estimatedDiameter = "estimated_diameter"
        case closeApproachData = "close_approach_data"
    }
    
}
