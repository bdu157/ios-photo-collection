//
//  ThemeHelper.swift
//  PhotoCollection
//
//  Created by Dongwoo Pae on 5/16/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import Foundation
import UIKit

class ThemeHelper {
    
    
    init() {
        if themePreference == nil {
            setThemePreferenceToDark()
        }
    }
    
    func setThemePreferenceToDark() {
        let userDefaults = UserDefaults.standard
        userDefaults.set("Dark", forKey: .themePreferenceKey)
    }
    func setThemePreferenceToOrange() {
        let userDefaults = UserDefaults.standard
        userDefaults.set("Orange", forKey: .themePreferenceKey)
    }
    
    var themePreference: String? {
        let themePreference = UserDefaults.standard.string(forKey: .themePreferenceKey)
        return themePreference
    }
}

extension String {
    static var themePreferenceKey = "themePreferenceKey"
}
