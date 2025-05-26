//
//  WikipediaDeepLinkOpenerTests.swift
//  PlacesTests
//
//  Created by Fer on 26/05/2025.
//

import XCTest
@preconcurrency import Nimble

@MainActor
final class WikipediaDeepLinkOpenerTests: XCTestCase {

    func testDeepLinkToPlaces_whenPlaceHasName_formsCorrectURL() async throws {
        // Arrange
        let url = URL(string: "wikipedia://places?lat=123.123&lon=-3.1234&name=Amsterdam")!
        let deepLinkOpenerMock = DeepLinkOpenerMock()
        let wikipedia = WikipediaDeepLinkOpener(deepLinkOpener: deepLinkOpenerMock)
        
        // Act
        await wikipedia.deepLinkToPlaces(name: "Amsterdam", latitude: 123.123, longitude: -3.1234)
        
        // Assert
        await expect(deepLinkOpenerMock.url).toEventually(equal(url))
    }

    func testDeepLinkToPlaces_whenPlaceDoesNotHaveName_formsCorrectURL() async throws {
        // Arrange
        let url = URL(string: "wikipedia://places?lat=123.123&lon=-3.1234")!
        let deepLinkOpenerMock = DeepLinkOpenerMock()
        let wikipedia = WikipediaDeepLinkOpener(deepLinkOpener: deepLinkOpenerMock)
        
        // Act
        await wikipedia.deepLinkToPlaces(name: nil, latitude: 123.123, longitude: -3.1234)
        
        // Assert
        await expect(deepLinkOpenerMock.url).toEventually(equal(url))
    }
}
