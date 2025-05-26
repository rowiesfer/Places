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
    let wikipedia: WikipediaDeepLinkOpenerProtocol
    
    public init(repository: PlaceListRepositoryProtocol, wikipedia: WikipediaDeepLinkOpenerProtocol) {
        self.repository = repository
        self.wikipedia = wikipedia
    }
    
    @Published var viewState: PlaceListViewState = .init(loadingState: .loading, messageText: "placelist.message.loading".localized, places: [])
    private var places: [Place] = []
    
    func fetchPlaces() {
        Task {
            do {
                places = try await repository.getPlaceList()
                viewState = .init(loadingState: .success,
                                  messageText: "",
                                  places: mapPlacesToViewData(places: places))
            } catch {
                places = []
                viewState = .init(loadingState: .error,
                                  messageText: "placelist.message.error".localized,
                                  places: [])
            }
        }
    }
    
    func mapPlacesToViewData(places: [Place]) -> [PlaceListViewState.PlaceViewData] {
        let placesViewData = places.map { place in
            return PlaceListViewState.PlaceViewData(id: place.id,
                                                    title: place.name ?? "",
                                                    subtitle: "\("placelist.place.latitude".localized): \(place.latitude), \("placelist.place.longitude".localized): \(place.longitude)")
        }
        return placesViewData
    }

    func placeTapped(id: String) {
        guard let place = places.filter({ $0.id == id }).first else {
            // TODO: show error
            return
        }

        Task {
            do {
                try await wikipedia.deepLinkToPlaces(name: place.name, latitude: place.latitude, longitude: place.longitude)
            } catch {
                // TODO: show error
            }
        }
    }
}
