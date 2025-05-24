//
//  PlaceListViewModel.swift
//  Places
//
//  Created by Fer on 23/05/2025.
//
import Combine

@MainActor
public final class PlaceListViewModel: ObservableObject {
    
    let repository: PlaceListRepositoryProtocol
    
    public init(repository: PlaceListRepositoryProtocol) {
        self.repository = repository
    }
    
    @Published var viewState: PlaceListViewState = .init(loadingState: .loading, messageText: "Loading places.", places: [])
    
    func fetchPlaces() {
        Task {
            do {
                let places = try await repository.getPlaceList()
                viewState = .init(loadingState: .success,
                                  messageText: "",
                                  places: mapPlacesToViewData(places: places))
            } catch {
                viewState = .init(loadingState: .error,
                                  messageText: "Error while fetching places.",
                                  places: [])
            }
        }
    }
    
    func mapPlacesToViewData(places: [Place]) -> [PlaceListViewState.PlaceViewData] {
        let placesViewData = places.map { place in
            return PlaceListViewState.PlaceViewData(id: "\(place.latitude)|\(place.longitude)",
                                                    title: place.name ?? "",
                                                    subtitle: "latitude: \(place.latitude), longitude: \(place.longitude)")
        }
        return placesViewData
    }
}
