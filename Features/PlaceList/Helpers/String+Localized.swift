//
//  String+Localized.swift
//  Places
//
//  Created by Fer on 25/05/2025.
//

import Foundation

extension String {
    var localized: String {
        String(localized: LocalizationValue(self), bundle: .featureModule)
    }
}
