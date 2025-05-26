//
//  WikipediaDeepLinkOpenerMock.swift
//  Places
//
//  Created by Fer on 26/05/2025.
//

@MainActor
class WikipediaDeepLinkOpenerMock: WikipediaDeepLinkOpenerProtocol {

    private(set) var place: Place? = nil
    
    func deepLinkToPlaces(at place: Place) {
        self.place = place
    }
}
