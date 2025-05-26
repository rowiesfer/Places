//
//  WikipediaDeepLinkOpenerStub.swift
//  Places
//
//  Created by Fer on 26/05/2025.
//
#if DEBUG

@MainActor
class WikipediaDeepLinkOpenerStub: WikipediaDeepLinkOpenerProtocol {
    func deepLinkToPlaces(name: String?, latitude: Double, longitude: Double) async throws { }
}

#endif
