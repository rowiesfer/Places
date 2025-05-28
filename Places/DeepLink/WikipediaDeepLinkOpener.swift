//
//  WikipediaDeepLinkOpener.swift
//  Places
//
//  Created by Fer on 26/05/2025.
//

import Foundation
import PlaceList

private enum Constants {
    static let scheme = "wikipedia://"
    static let host = "places"
    static let lat = "lat"
    static let lon = "lon"
    static let name = "name"
}

final class WikipediaDeepLinkOpener: WikipediaDeepLinkOpenerProtocol {

    private let deepLinkOpener: DeepLinkOpenerProtocol

    init(deepLinkOpener: DeepLinkOpenerProtocol) {
        self.deepLinkOpener = deepLinkOpener
    }

    @MainActor func deepLinkToPlaces(name: String?, latitude: Double, longitude: Double) async throws {

        var urlString = "\(Constants.scheme)\(Constants.host)"
        urlString.append("?\(Constants.lat)=\(latitude)")
        urlString.append("&\(Constants.lon)=\(longitude)")
        if let name = name {
            urlString.append("&\(Constants.name)=\(name)")
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
