//
//  WikipediaDeepLinkOpenerMock.swift
//  Places
//
//  Created by Fer on 26/05/2025.
//

@MainActor
class WikipediaDeepLinkOpenerMock: WikipediaDeepLinkOpenerProtocol {

    private(set) var name: String? = nil
    private(set) var latitude: Double = 0
    private(set) var longitude: Double = 0
    
    func deepLinkToPlaces(name: String?, latitude: Double, longitude: Double) async {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
}
