//
//  DetailsDataTypes.swift
//  Armagedon2022
//
//  Created by Alex Kulish on 27.04.2022.
//

import Foundation

enum DetailsDataTypes: CaseIterable {
    case kilometersPerHour
    case milesPerHour
    case kilometersPerSecond
    case closeApproachData
    case exactApproachData
    case metersDiameter
    case milesDiameter
    case feetDiameter
    case kmDistanceToEarth
    case lunarDistanceToEarth
    case isDangerous
    case orbitingBody
    
    static func getNumberOfRows() -> Int {
        return allCases.count
    }
    
    static func getRow(index: Int) -> DetailsDataTypes {
        return allCases[index]
    }
    
    var title: String {
        switch self {
        case .kilometersPerHour:
            return "Скорость в км/ч"
        case .milesPerHour:
            return "Скорость в ми/с"
        case .kilometersPerSecond:
            return "Скорость в км/с"
        case .closeApproachData:
            return "Подлетает"
        case .exactApproachData:
            return "Дата макс. сближения"
        case .kmDistanceToEarth:
            return "На расстоянии(км)"
        case .lunarDistanceToEarth:
            return "На расстоянии(л.орб.)"
        case .milesDiameter:
            return "Диаметр(мили)"
        case .feetDiameter:
            return "Диаметр(фут.)"
        case .metersDiameter:
            return "Диаметр(м)"
        case .isDangerous:
            return "Оценка"
        case .orbitingBody:
            return "По орбите"
        }
    }
    
    func getValue(from nearObjectData: NearEarthObjects) -> String {
        guard let firstObject = nearObjectData.closeApproachData.first else { return "" }
        
        let approachDateCorrectFormat = Date.changeAsteroidApproachDateFormat(approachDate: firstObject.closeApproachDate)
        let metersDiameter = nearObjectData.estimatedDiameter.meters.estimatedDiameterMax
        let milesDiameter = nearObjectData.estimatedDiameter.miles.estimatedDiameterMax
        let feetDiameter = Int(nearObjectData.estimatedDiameter.feet.estimatedDiameterMax)
        let kilometersPerSecond = firstObject.relativeVelocity.kilometersPerSecond.removeFractional
        let kilometersPerHour = firstObject.relativeVelocity.kilometersPerHour.removeFractional
        let milesPerHour = firstObject.relativeVelocity.milesPerHour.removeFractional
        let kmDistanceToEarth = firstObject.missDistance.kilometers.removeFractional
        let kmDistanceCorrectFormat = kmDistanceToEarth.changeValueFormatDistanceToEarth(distance: kmDistanceToEarth)
        let exactApproachData = firstObject.closeApproachDateFull
        let lunarDistanceToEarth = firstObject.missDistance.lunar.removeFractional
        
        switch self {
        case .kilometersPerHour:
            return kilometersPerHour
        case .milesPerHour:
            return milesPerHour
        case .kilometersPerSecond:
            return kilometersPerSecond
        case .closeApproachData:
            return approachDateCorrectFormat
        case .exactApproachData:
            return exactApproachData
        case .metersDiameter:
            return String(metersDiameter).removeFractional
        case .milesDiameter:
            return String(milesDiameter)
        case .feetDiameter:
            return String(feetDiameter)
        case .kmDistanceToEarth:
            return kmDistanceCorrectFormat
        case .lunarDistanceToEarth:
            return lunarDistanceToEarth
        case .isDangerous:
            return nearObjectData.isPotentiallyHazardousAsteroid ? "опасен" : "не опасен"
        case .orbitingBody:
            return "Земля"
        }
        
    }
    
}
