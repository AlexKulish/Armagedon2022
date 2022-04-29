//
//  SetingsUnitOfMeasureAndDangerous.swift
//  Armagedon2022
//
//  Created by Alex Kulish on 28.04.2022.
//

import Foundation

enum SettingsUnitOfMeasureAndDangerous: String, CaseIterable {
    
    case unitOfMeasure
    case isDangerous
    
    var title: String {
        
        switch self {
        case .unitOfMeasure:
            return "Ед.изм.расстояния"
        case .isDangerous:
            return "Показывать только опасные"
        }
        
    }
    
    static func getRowsInSection() -> Int {
        allCases.count
    }
    
    static func getRow(atIndex index: Int) -> SettingsUnitOfMeasureAndDangerous {
        allCases[index]
    }
    
}
