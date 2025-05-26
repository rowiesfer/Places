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
    
    @MainActor func deepLinkToPlaces(name: String?, latitude: Double, longitude: Double) async {
        if let url = URL(string: "wikipedia://places?name=\(name ?? "")&lat=\(latitude)&lon=\(longitude)") {
            await deepLinkOpener.open(url, options: [:])
        }
    }
}
