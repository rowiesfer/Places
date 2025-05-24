//
//  PlaceListRepositoryTEsts.swift
//  PlacesTests
//
//  Created by Fer on 24/05/2025.
//

import XCTest
@preconcurrency import Nimble

@MainActor
final class PlaceListRepositoryTests: XCTestCase {
        
    /// This is a simple test to check if my entities are correctly setup and the 4 iteams of the sample response can be parsed
    func testGetPlaceList_returnsPlacesWithoutErrors() async throws {
        // Arrange
        let data = try Data(contentsOf: Bundle(for: PlaceListRepositoryTests.self).url(forResource: "locations", withExtension: "json")!)
        let placeListRepository = PlaceListRepository(client: PlaceAPIClientMock(data: data))
        
        // Act
        let places = try await placeListRepository.getPlaceList()
        
        // Assert
        await expect(places).toEventually(haveCount(4))
    }

}
