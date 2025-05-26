//
//  WikipediaDeepLinkOpener.swift
//  Places
//
//  Created by Fer on 26/05/2025.
//

import Foundation
import PlaceList

struct WikipediaDeepLinkOpener: WikipediaDeepLinkOpenerProtocol {

    private let deepLinkOpener: DeepLinkOpenerProtocol

    init(deepLinkOpener: DeepLinkOpenerProtocol) {
        self.deepLinkOpener = deepLinkOpener
    }

    @MainActor func deepLinkToPlaces(name: String?, latitude: Double, longitude: Double) async {

        var urlString = "wikipedia://places?lat=\(latitude)&lon=\(longitude)"
        if let name = name {
            urlString.append("&name=\(name)")
        }

        if let url = URL(string: urlString) {
            await deepLinkOpener.open(url)
        }
    }
}
