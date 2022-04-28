//
//  SettingsButtonsManager.swift
//  Armagedon2022
//
//  Created by Alex Kulish on 28.04.2022.
//

import Foundation

class SettingsButtonsManager: Codable {
    
    var isDangerous: Bool
    var index: Int
    
    init(isDangerous: Bool, index: Int) {
        self.isDangerous = isDangerous
        self.index = index
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        isDangerous = try container.decode(Bool.self, forKey: .isDangerous)
        index = try container.decode(Int.self, forKey: .index)
    }
    
    enum CodingKeys: CodingKey {
        case isDangerous
        case index
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(isDangerous, forKey: .isDangerous)
        try container.encode(index, forKey: .index)
    }
}
