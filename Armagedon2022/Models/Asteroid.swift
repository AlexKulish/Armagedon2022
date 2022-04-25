//
//  Asteroid.swift
//  Armagedon2022
//
//  Created by Alex Kulish on 25.04.2022.
//

import Foundation

struct Asteroid: Decodable {
    
    let nearEarthObjects: [String: [NearEarthObjects]]
    
    enum CodingKeys: String, CodingKey {
        case nearEarthObjects = "near_earth_objects"
    }
}
