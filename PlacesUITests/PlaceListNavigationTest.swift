//
//  PlaceListNavigationTest.swift
//  Places
//
//  Created by Fer on 27/05/2025.
//

import XCTest

@MainActor
final class PlaceListNavigationTest: XCTestCase {

    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    func testTappingOnCustomPlaceButton_navigatesToCustomPlaceScreen() {
        // Arrange
        app.launch()
        
        // Act
        let customPlaceButton = app.buttons["placelist.button.customplace"]
        XCTAssertTrue(customPlaceButton.waitForExistence(timeout: 5))
        customPlaceButton.tap()

        // Assert
        let customPlaceViewTitle = app.staticTexts["customplace.title"]
        XCTAssertTrue(customPlaceViewTitle.waitForExistence(timeout: 5))
    }
    
    func testTappingOnCustomPlaceBackButton_navigatesBackToPlaceList() {
        // Arrange
        app.launch()
        
        // Act
        // Go to custom place
        let customPlaceButton = app.buttons["placelist.button.customplace"]
        XCTAssertTrue(customPlaceButton.waitForExistence(timeout: 5))
        customPlaceButton.tap()
        let customPlaceViewTitle = app.staticTexts["customplace.title"]
        XCTAssertTrue(customPlaceViewTitle.waitForExistence(timeout: 5))
        // Go back
        let backButton = app.navigationBars.element.buttons.firstMatch
        XCTAssertTrue(backButton.exists)
        backButton.tap()
        
        //Assert
        let placeListTitle = app.staticTexts["placelist.title"]
        XCTAssertTrue(placeListTitle.waitForExistence(timeout: 5))
    }
}
