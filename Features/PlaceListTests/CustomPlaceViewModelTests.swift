//
//  CustomPlaceViewModelTests.swift
//  Places
//
//  Created by Fer on 28/05/2025.
//

import XCTest
@preconcurrency import Nimble

@MainActor
final class CustomPlaceViewModelTests: XCTestCase {
    
    func testConvertToCoordinates_whenLatitudeContainsLetters_returnsCantParseLatitudeError() async  {
        // Arrange
        let latitudeString = "onetwothree"
        let longitudeString = "52.3547498"
        let viewModel = CustomPlaceViewModel(wikipedia: WikipediaDeepLinkOpenerMock())
        
        // Act and Assert
        expect {
            try viewModel.convertToCoordinates(latitudeString: latitudeString, longitudeString: longitudeString)
        }.to(throwError(CoordinateValidationError.cantParseLatitude))
    }
    
    func testConvertToCoordinates_whenLongitudeContainsLetters_returnsCantParseLongitudeError() async  {
        // Arrange
        let latitudeString = "4.8339215"
        let longitudeString = "onetwothree"
        let viewModel = CustomPlaceViewModel(wikipedia: WikipediaDeepLinkOpenerMock())
        
        // Act and Assert
        expect {
            try viewModel.convertToCoordinates(latitudeString: latitudeString, longitudeString: longitudeString)
        }.to(throwError(CoordinateValidationError.cantParseLongitude))
    }
    
    func testConvertToCoordinates_whenLongitudeAndLatitudeAreValid_returnsValuesCorrectly() async  {
        // Arrange
        let latitudeString = "4.8339215"
        let longitudeString = "52.3547498"
        let viewModel = CustomPlaceViewModel(wikipedia: WikipediaDeepLinkOpenerMock())
        var coordinates: (latitude: Double, longitude: Double) = (0.0, 0.0)
        
        // Act
        do {
            coordinates = try viewModel.convertToCoordinates(latitudeString: latitudeString, longitudeString: longitudeString)
        } catch {
            fail()
        }

        // Act and Assert
        expect(coordinates).to(equal((4.8339215, 52.3547498)))
    }
    
    func testConvertToCoordinates_whenLongitudeAndLatitudeAreValidWithNegatives_returnsValuesCorrectly() async  {
        // Arrange
        let latitudeString = "40.4380638"
        let longitudeString = "-3.7495758"
        let viewModel = CustomPlaceViewModel(wikipedia: WikipediaDeepLinkOpenerMock())
        var coordinates: (latitude: Double, longitude: Double) = (0.0, 0.0)
        
        // Act
        do {
            coordinates = try viewModel.convertToCoordinates(latitudeString: latitudeString, longitudeString: longitudeString)
        } catch {
            fail()
        }

        // Act and Assert
        expect(coordinates).to(equal((40.4380638, -3.7495758)))
    }
    
    func testOpenPlaceInWikipedia_whenLatitudeAndLongitudeAreValidAndNameIsProvided_deeplinksToWikipedia() async throws {
        // Arrange
        let latitudeString = "40.4380638"
        let longitudeString = "-3.7495758"
        let placeName = "Amsterdam"
        let wikipedia = WikipediaDeepLinkOpenerMock()
        let viewModel = CustomPlaceViewModel(wikipedia: wikipedia)
        
        // Act
        viewModel.openPlaceInWikipedia(name: placeName, latitude: latitudeString, longitude: longitudeString)
        
        // Assert
        await expect(wikipedia.name).toEventually(equal("Amsterdam"))
        await expect(wikipedia.latitude).toEventually(equal(40.4380638))
        await expect(wikipedia.longitude).toEventually(equal(-3.7495758))
    }
    
    func testOpenPlaceInWikipedia_whenLatitudeAndLongitudeAreValidAndNameIsNotProvided_deeplinksToWikipedia() async throws {
        // Arrange
        let latitudeString = "40.4380638"
        let longitudeString = "-3.7495758"
        let placeName = ""
        let wikipedia = WikipediaDeepLinkOpenerMock()
        let viewModel = CustomPlaceViewModel(wikipedia: wikipedia)
        
        // Act
        viewModel.openPlaceInWikipedia(name: placeName, latitude: latitudeString, longitude: longitudeString)
    
        // Assert
        await expect(wikipedia.name).toEventually(equal(""))
        await expect(wikipedia.latitude).toEventually(equal(40.4380638))
        await expect(wikipedia.longitude).toEventually(equal(-3.7495758))
    }
    
    func testDeinit_whenDeepLinkTaskIsRunning_cancelsTheTask() async {
        // Arrange
        let wikipedia = WikipediaDeepLinkOpenerMock()

        let longRunningTask: Task<Void, Error>? = Task {
            try? await Task.sleep(nanoseconds: 3_000_000_000)
        }
        var viewModel: CustomPlaceViewModel? = CustomPlaceViewModel(wikipedia: wikipedia)
        viewModel!.deepLinkTask = longRunningTask
        
        // Act
        viewModel = nil
        
        // Assert
        await expect(longRunningTask?.isCancelled).toEventually(beTrue())
    }
    
    func test_openPlaceInWikipedia_whenDeepLinkTaskIsRunning_cancelsTheTask() async {
        // Arrange
        let latitudeString = "40.4380638"
        let longitudeString = "-3.7495758"
        let placeName = "Amsterdam"
        let wikipedia = WikipediaDeepLinkOpenerMock()

        let longRunningTask: Task<Void, Error>? = Task {
            try? await Task.sleep(nanoseconds: 3_000_000_000)
        }
        let viewModel = CustomPlaceViewModel(wikipedia: wikipedia)
        viewModel.deepLinkTask = longRunningTask
        
        // Act
        viewModel.openPlaceInWikipedia(name: placeName, latitude: latitudeString, longitude: longitudeString)
    
        // Assert
        await expect(longRunningTask?.isCancelled).toEventually(beTrue())
    }
}
