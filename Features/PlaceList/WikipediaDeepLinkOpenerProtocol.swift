//
//  WikipediaDeepLinkOpenerProtocol.swift
//  Places
//
//  Created by Fer on 26/05/2025.
//

@MainActor
public protocol WikipediaDeepLinkOpenerProtocol {
    func deepLinkToPlaces(name: String?, latitude: Double, longitude: Double) async throws
}
