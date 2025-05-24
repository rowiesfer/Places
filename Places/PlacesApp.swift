//
//  PlacesApp.swift
//  Places
//
//  Created by Fer on 23/05/2025.
//

import SwiftUI
import PlaceList

@main
struct PlacesApp: App {
    
    // TODO: get from config file
    let url = URL(string: "https://raw.githubusercontent.com/abnamrocoesd/assignment-ios/main")!

    var body: some Scene {
        WindowGroup {
            PlaceListFactory().newPlaceListView(baseURL: url)
        }
    }
}
