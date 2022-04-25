//
//  CloseApproachData.swift
//  Armagedon2022
//
//  Created by Alex Kulish on 25.04.2022.
//

import Foundation

struct CloseApproachData: Decodable {
    
    let closeApproachDate: String
    let closeApproachDateFull: String
    let orbitingBody: String
    let epochDateCloseApproach: Int
    let relativeVelocity: RelativeVelocity
    let missDistance: MissDistance
    
    enum CodingKeys: String, CodingKey {
        case closeApproachDate = "close_approach_date"
        case closeApproachDateFull = "close_approach_date_full"
        case orbitingBody = "orbiting_body"
        case epochDateCloseApproach = "epoch_date_close_approach"
        case relativeVelocity = "relative_velocity"
        case missDistance = "miss_distance"
    }
}
