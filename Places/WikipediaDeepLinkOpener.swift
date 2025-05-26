//
//  WikipediaDeepLinkOpener.swift
//  Places
//
//  Created by Fer on 26/05/2025.
//

import Foundation
import PlaceList

struct WikipediaDeepLinkOpener: WikipediaDeepLinkOpenerProtocol {

    private let deepLinkOpener: DeepLinkOpenerProtocol = DeepLinkOpener()
    
    @MainActor func deepLinkToPlaces(at place: Place) async {
        if let url = URL(string: "wikipedia://places?name=\(place.name ?? "")&lat=\(place.latitude)&lon=\(place.longitude)") {
            await deepLinkOpener.open(url, options: [:])
        }
    }
}
