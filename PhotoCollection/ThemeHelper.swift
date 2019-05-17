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
    
    
    init() {}
    
    func setThemePreferenceToDark() {
        let userDefaults = UserDefaults.standard
        userDefaults.set("Dark", forKey: .themePreferenceKey)
    }
    func setThemePreferenceToOrange() {
        let userDefaults = UserDefaults.standard
        userDefaults.set("Orange", forKey: .themePreferenceKey)
    }
    
    var themePreference: String? {
        let themePreference = UserDefaults.standard
        return themePreference.string(forKey: .themePreferenceKey)
    }
}

extension String {
    static var themePreferenceKey = "themePreferenceKey"
}
