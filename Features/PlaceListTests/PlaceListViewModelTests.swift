//
//  PlaceListViewModelTests.swift
//  Places
//
//  Created by Fer on 24/05/2025.
//

import XCTest
@preconcurrency import Nimble

@MainActor
final class PlaceListViewModelTests: XCTestCase {
    
    func testLoadingState_isInitializedAsLoading() async  {
        // Arrange
        let viewModel = PlaceListViewModel(repository: PlaceListRepositoryMock(), wikipedia: WikipediaDeepLinkOpenerMock(), coordinator: PlaceListCoordinatorMock())

        // Act
        //Do nothing: we want to test the initial view data state to be loading

        // Assert
        expect(viewModel.viewState.loadingState).to(equal(.loading))
    }
    
    func testFetchPlaces_whenRepositoryReturnsSuccessfully_setsLoadingStateToSuccessWithPlaces() async  {
        // Arrange
        let places: [Place] = [
            .init(name: "Amsterdam", latitude: 52.3547498, longitude: 4.8339215),
            .init(name: "Mumbai", latitude: 19.0823998, longitude: 72.8111468),
            .init(name: "Copenhagen", latitude: 55.6713442, longitude: 12.523785),
            .init(name: "", latitude: 40.4380638, longitude: -3.7495758)
        ]
        let viewModel = PlaceListViewModel(repository: PlaceListRepositoryMock(places: places), wikipedia: WikipediaDeepLinkOpenerMock(), coordinator: PlaceListCoordinatorMock())

        // Act
        viewModel.fetchPlaces()

        // Assert
        await expect(viewModel.viewState.loadingState).toEventually(equal(.success))
        await expect(viewModel.viewState.places.count).toEventually(equal(4))
    }
    
    func testFetchPlaces_whenRepositoryThrowsError_setsLoadingStateToError() async  {
        // Arrange
        let error = PlaceListRepositoryError.unableToParseResponse
        let viewModel = PlaceListViewModel(repository: PlaceListRepositoryMock(error: error), wikipedia: WikipediaDeepLinkOpenerMock(), coordinator: PlaceListCoordinatorMock())

        // Act
        viewModel.fetchPlaces()

        // Assert
        await expect(viewModel.viewState.loadingState).toEventually(equal(.error))
    }
    
    func testFetchPlaces_whenPlaceHasName_mapsToViewStateWithTitleAndSubtitle() async  {
        // Arrange
        let places: [Place] = [
            .init(name: "Amsterdam", latitude: 52.3547498, longitude: 4.8339215)
        ]
        let viewModel = PlaceListViewModel(repository: PlaceListRepositoryMock(places: places), wikipedia: WikipediaDeepLinkOpenerMock(), coordinator: PlaceListCoordinatorMock())

        // Act
        viewModel.fetchPlaces()

        // Assert
        await expect(viewModel.viewState.places.first?.title).toEventually(equal("Amsterdam"))
        await expect(viewModel.viewState.places.first?.subtitle).toEventually(equal("placelist.place.latitude: 52.3547498, placelist.place.longitude: 4.8339215"))
    }
    
    func testFetchPlaces_whenPlacesDoesNotHaveName_mapsToViewStateWithoutTitle() async {
        // Arrange
        let places: [Place] = [
            .init(name: "", latitude: 40.4380638, longitude: -3.7495758)
        ]
        let viewModel = PlaceListViewModel(repository: PlaceListRepositoryMock(places: places), wikipedia: WikipediaDeepLinkOpenerMock(), coordinator: PlaceListCoordinatorMock())

        // Act
        viewModel.fetchPlaces()

        // Assert
        await expect(viewModel.viewState.places.first?.title).toEventually(equal(""))
        await expect(viewModel.viewState.places.first?.subtitle).toEventually(equal("placelist.place.latitude: 40.4380638, placelist.place.longitude: -3.7495758"))
    }
    
    func testPlaceTapped_returnsCorrrectPlace() async {
        // Arrange
        let place: Place = .init(name: "Amsterdam", latitude: 52.3547498, longitude: 4.8339215)
        let wikipediaDeepLinkOpenerMock = WikipediaDeepLinkOpenerMock()
        let viewModel = PlaceListViewModel(repository: PlaceListRepositoryMock(places: [place]), wikipedia: wikipediaDeepLinkOpenerMock, coordinator: PlaceListCoordinatorMock())

        // Act
        viewModel.fetchPlaces()
        await expect(viewModel.viewState.places.count).toEventually(equal(1))
        viewModel.placeTapped(id: viewModel.viewState.places.first!.id)

        // Assert
        await expect(wikipediaDeepLinkOpenerMock.name).toEventually(equal(place.name))
        await expect(wikipediaDeepLinkOpenerMock.latitude).toEventually(equal(place.latitude))
        await expect(wikipediaDeepLinkOpenerMock.longitude).toEventually(equal(place.longitude))
    }
    
    func testDeinit_whenDeepLinkTaskIsRunning_cancelsTheTask() async {
        // Arrange
        let ongoingtask: Task<Void, Error>? = Task {
            try? await Task.sleep(nanoseconds: 3_000_000_000)
        }
        var viewModel: PlaceListViewModel? = PlaceListViewModel(repository: PlaceListRepositoryMock(), wikipedia: WikipediaDeepLinkOpenerMock(), coordinator: PlaceListCoordinatorMock())
        viewModel!.deepLinkTask = ongoingtask
    
        // Act
        viewModel = nil

        // Assert
        await expect(ongoingtask?.isCancelled).toEventually(beTrue())
    }

    func testDeinit_whenFetchPlacesTaskIsRunning_cancelsTheTask() async {
        // Arrange
        let ongoingTask: Task<Void, Error>? = Task {
            try? await Task.sleep(nanoseconds: 3_000_000_000)
        }
        var viewModel: PlaceListViewModel? = PlaceListViewModel(repository: PlaceListRepositoryMock(), wikipedia: WikipediaDeepLinkOpenerMock(), coordinator: PlaceListCoordinatorMock())
        viewModel!.fetchPlacesTask = ongoingTask
    
        // Act
        viewModel = nil

        // Assert
        await expect(ongoingTask!.isCancelled).toEventually(beTrue())
    }
    
    func testOpenPlaceInWikipedia_whenDeepLinkTaskIsRunning_cancelsTheTask() async {
        // Arrange
        let place: Place = .init(name: "Amsterdam", latitude: 52.3547498, longitude: 4.8339215)
        let wikipediaDeepLinkOpenerMock = WikipediaDeepLinkOpenerMock()

        let ongoingTask: Task<Void, Error>? = Task {
            try? await Task.sleep(nanoseconds: 3_000_000_000)
        }
        let viewModel: PlaceListViewModel? = PlaceListViewModel(repository: PlaceListRepositoryMock(places: [place]), wikipedia: wikipediaDeepLinkOpenerMock, coordinator: PlaceListCoordinatorMock())
        viewModel!.deepLinkTask = ongoingTask
        
        // Act
        viewModel!.fetchPlaces()
        await expect(viewModel!.viewState.places.count).toEventually(equal(1))
        viewModel!.placeTapped(id: viewModel!.viewState.places.first!.id)

        // Assert
        await expect(ongoingTask!.isCancelled).toEventually(beTrue())
    }
    
    func testFetchPlaces_whenFetchPlacesTaskIsRunnin_cancelsTheTask() async {
        // Arrange
        let wikipediaDeepLinkOpenerMock = WikipediaDeepLinkOpenerMock()

        let ongoingTask: Task<Void, Error>? = Task {
            try? await Task.sleep(nanoseconds: 3_000_000_000)
        }
        let viewModel: PlaceListViewModel? = PlaceListViewModel(repository: PlaceListRepositoryMock(places: []), wikipedia: wikipediaDeepLinkOpenerMock, coordinator: PlaceListCoordinatorMock())
        viewModel!.fetchPlacesTask = ongoingTask
    
        // Act
        viewModel!.fetchPlaces()

        // Assert
        await expect(ongoingTask!.isCancelled).toEventually(beTrue())
    }
}
