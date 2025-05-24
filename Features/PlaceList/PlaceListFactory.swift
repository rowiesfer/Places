//
//  PlaceListFactory.swift
//  Places
//
//  Created by Fer on 25/05/2025.
//

import Foundation
import PlacesAPI

public struct PlaceListFactory {
    
    public init() {}
    
    // Poor man's dependency injection for now.
    @MainActor public func newPlaceListView(baseURL: URL) -> PlaceListView {
        let apiClient = PlacesAPIClient(baseURL: baseURL)
        return PlaceListView(viewModel: PlaceListViewModel(repository: PlaceListRepository(client: apiClient)))
    }

}
