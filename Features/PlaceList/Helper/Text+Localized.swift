//
//  Text+Localized.swift
//  Places
//
//  Created by Fer on 25/05/2025.
//

import SwiftUI
import Foundation

extension Text {
    init(localized key: String) {
        let string = String(localized: String.LocalizationValue(key), bundle: .featureModule)
        self.init(string)
    }
}

