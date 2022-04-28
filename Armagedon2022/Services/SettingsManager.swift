//
//  SettingsManager.swift
//  Armagedon2022
//
//  Created by Alex Kulish on 28.04.2022.
//

import UIKit

class SettingsManager {
    
    static let shared = SettingsManager()
    
    private init() {}
    
    func setSettingsButtons(settingsButtons: SettingsButtonsManager) {
        UserDefaults.standard.setValue(encodable: settingsButtons, forKey: "settings")
    }
    
    func loadSettingsButtons() -> SettingsButtonsManager? {
        guard let settings = UserDefaults.standard.loadValue(SettingsButtonsManager.self, forKey: "settings") else { return nil}
        return settings
    }
    
    func reset() {
        UserDefaults.standard.removeObject(forKey: "settings")
    }
    
}
