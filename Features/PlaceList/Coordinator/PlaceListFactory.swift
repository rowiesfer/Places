//
//  PlaceListFactory.swift
//  Places
//
//  Created by Fer on 25/05/2025.
//

import Foundation
import PlacesAPI

public final class PlaceListFactory {

    private let baseURL: URL
    private let wikipedia: WikipediaDeepLinkOpenerProtocol

    public init(baseURL: URL, wikipedia: WikipediaDeepLinkOpenerProtocol) {
        self.baseURL = baseURL
        self.wikipedia = wikipedia
    }

    @MainActor public func newPlaceListView(coordinator: PlaceListCoordinatorProtocol) -> PlaceListView {
        let apiClient = PlacesAPIClient(baseURL: baseURL)
        return PlaceListView(viewModel: PlaceListViewModel(repository: PlaceListRepository(client: apiClient), wikipedia: wikipedia, coordinator: coordinator))
    }
    
    @MainActor public func customPlaceView(coordinator: PlaceListCoordinatorProtocol) -> CustomPlaceView {
        return CustomPlaceView(viewModel: CustomPlaceViewModel(wikipedia: wikipedia))
    }

}
