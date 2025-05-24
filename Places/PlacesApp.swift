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
    var body: some Scene {
        WindowGroup {
            PlaceListView(viewModel: PlaceListViewModel(repository: PlaceListRepositoryStub()))
        }
    }
}
