//
//  RelativeVelocity.swift
//  Armagedon2022
//
//  Created by Alex Kulish on 25.04.2022.
//

import Foundation

struct RelativeVelocity: Decodable {
    
    let kilometersPerSecond: String
    let kilometersPerHour: String
    let milesPerHour: String
    
    enum CodingKeys: String, CodingKey {
        case kilometersPerSecond = "kilometers_per_second"
        case kilometersPerHour = "kilometers_per_hour"
        case milesPerHour = "miles_per_hour"
    }
}
