//
//  PlaceListViewModel.swift
//  Places
//
//  Created by Fer on 23/05/2025.
//
import Combine

fileprivate enum Constants {
    static let loadingMessage = "placelist.message.loading"
    static let errorMessage = "placelist.message.error"
    static let latitudeKey = "placelist.place.latitude"
    static let longitudeKey = "placelist.place.longitude"
}

@MainActor
public final class PlaceListViewModel: ObservableObject {
    
    let repository: PlaceListRepositoryProtocol
    let wikipedia: WikipediaDeepLinkOpenerProtocol
    weak var coordinator: PlaceListCoordinatorProtocol?
    var deepLinkTask: Task<Void, Error>? = nil
    var fetchPlacesTask: Task<Void, Error>? = nil
    
    public init(repository: PlaceListRepositoryProtocol,
                wikipedia: WikipediaDeepLinkOpenerProtocol,
                coordinator: PlaceListCoordinatorProtocol
    ) {
        self.repository = repository
        self.wikipedia = wikipedia
        self.coordinator = coordinator
    }
    
    deinit {
        deepLinkTask?.cancel()
        fetchPlacesTask?.cancel()
    }

    
    @Published var viewState: PlaceListViewState = .init(loadingState: .loading, messageText: Constants.loadingMessage.localized, places: [])
    private var places: [Place] = []
    
    func fetchPlaces() {
        fetchPlacesTask?.cancel()
        fetchPlacesTask = Task {
            do {
                places = try await repository.getPlaceList()
                viewState = .init(loadingState: .success,
                                  messageText: "",
                                  places: mapPlacesToViewData(places: places))
            } catch {
                places = []
                viewState = .init(loadingState: .error,
                                  messageText: Constants.errorMessage.localized,
                                  places: [])
            }
        }
    }
    
    func mapPlacesToViewData(places: [Place]) -> [PlaceListViewState.PlaceViewData] {
        let placesViewData = places.map { place in
            return PlaceListViewState.PlaceViewData(id: place.id,
                                                    title: place.name ?? "",
                                                    subtitle: "\(Constants.latitudeKey.localized): \(place.latitude), \(Constants.longitudeKey.localized): \(place.longitude)")
        }
        return placesViewData
    }

    func placeTapped(id: String) {
        guard let place = places.filter({ $0.id == id }).first else {
            // TODO: show error
            return
        }
        deepLinkTask?.cancel()
        deepLinkTask = Task {
            do {
                try await wikipedia.deepLinkToPlaces(name: place.name, latitude: place.latitude, longitude: place.longitude)
            } catch {
                // TODO: show error
            }
        }
    }

    func tryOwnPlaceTapped() {
        guard let coordinator = coordinator else {
            assertionFailure()
            return
        }
        coordinator.showCustomPlace()
    }
}
