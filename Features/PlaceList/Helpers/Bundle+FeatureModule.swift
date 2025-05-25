//
//  Bundle+FeatureModule.swift
//  Places
//
//  Created by Fer on 25/05/2025.
//


import Foundation

// Good old hacky way of getting the bundle when having resources on an Xcode framework.
// If I would be using a Swift package for my feature module I think this would be easier since I could get the localized string easier.
// But, I have no experience using Swift packages for feature modules so this would do it for now :)

final class BundleFinder {}

extension Bundle {
    static var featureModule: Bundle {
        Bundle(for: BundleFinder.self)
    }
}
