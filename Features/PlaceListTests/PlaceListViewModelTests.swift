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
        let viewModel = PlaceListViewModel(repository: PlaceListRepositoryMock())

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
        let viewModel = PlaceListViewModel(repository: PlaceListRepositoryMock(places: places))

        // Act
        viewModel.fetchPlaces()

        // Assert
        await expect(viewModel.viewState.loadingState).toEventually(equal(.success))
        await expect(viewModel.viewState.places.count).toEventually(equal(4))
    }
    
    func testFetchPlaces_whenRepositoryThrowsError_setsLoadingStateToError() async  {
        // Arrange
        let error = PlaceListRepositoryError.unableToParseResponse
        let viewModel = PlaceListViewModel(repository: PlaceListRepositoryMock(error: error))

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
        let viewModel = PlaceListViewModel(repository: PlaceListRepositoryMock(places: places))

        // Act
        viewModel.fetchPlaces()

        // Assert
        await expect(viewModel.viewState.places.first?.title).toEventually(equal("Amsterdam"))
        await expect(viewModel.viewState.places.first?.subtitle).toEventually(equal("latitude: 52.3547498, longitude: 4.8339215"))
    }
    
    func testFetchPlaces_whenPlacesDoesNotHaveName_mapsToViewStateWithoutTitle() async {
        // Arrange
        let places: [Place] = [
            .init(name: "", latitude: 40.4380638, longitude: -3.7495758)
        ]
        let viewModel = PlaceListViewModel(repository: PlaceListRepositoryMock(places: places))

        // Act
        viewModel.fetchPlaces()

        // Assert
        await expect(viewModel.viewState.places.first?.title).toEventually(equal(""))
        await expect(viewModel.viewState.places.first?.subtitle).toEventually(equal("latitude: 40.4380638, longitude: -3.7495758"))
    }

}
