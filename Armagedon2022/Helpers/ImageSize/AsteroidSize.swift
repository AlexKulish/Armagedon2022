//
//  AsteroidSize.swift
//  Armagedon2022
//
//  Created by Alex Kulish on 26.04.2022.
//

import UIKit

enum AsteroidSize {
    case small
    case medium
    case big
    
    static func size(for diameter: Int) -> AsteroidSize {
        switch diameter {
        case 0...80:
            return .small
        case 80...200:
            return .medium
        default:
            return .big
        }
    }
    
    var asteroidImage: UIImage {
        switch self {
        case .small:
            return UIImage(named: "small") ?? UIImage()
        case .medium:
            return UIImage(named: "medium") ?? UIImage()
        case .big:
            return UIImage(named: "big") ?? UIImage()
        }
    }
    
}
