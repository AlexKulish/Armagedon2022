//
//  Titles.swift
//  Armagedon2022
//
//  Created by Alex Kulish on 25.04.2022.
//

import Foundation

enum Titles: String {
    case destroy
    case asteroid
    case armagedon
    case filter
    case details
    case done
    case back
    
    var title: String {
        
        switch self {
        case .destroy:
            return "Уничтожить"
        case .asteroid:
             return "Астероиды"
        case .armagedon:
            return "Армагедон 2022"
        case .filter:
            return "Фильтр"
        case .details:
            return "Подробная информация"
        case .done:
            return "Применить"
        case .back:
            return "Назад"
        }
    }
}
