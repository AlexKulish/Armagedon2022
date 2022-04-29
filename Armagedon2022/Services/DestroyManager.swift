//
//  DestroyManager.swift
//  Armagedon2022
//
//  Created by Alex Kulish on 28.04.2022.
//

import Foundation

class DestroyManager {
    static let shared = DestroyManager()
    private init() {}
    var destroyAsteroids: [NearEarthObjects] = []
}
