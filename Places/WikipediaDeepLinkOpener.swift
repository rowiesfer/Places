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

    @MainActor func deepLinkToPlaces(name: String?, latitude: Double, longitude: Double) async throws {

        var urlString = "wikipedia://places?lat=\(latitude)&lon=\(longitude)"
        if let name = name {
            urlString.append("&name=\(name)")
        }

        guard let url = URL(string: urlString) else {
            throw URLError(.badURL, userInfo: [NSLocalizedDescriptionKey : urlString])
        }

        let success = await deepLinkOpener.open(url)

        guard success == true else {
            throw URLError(.unsupportedURL)
        }

    }
}
