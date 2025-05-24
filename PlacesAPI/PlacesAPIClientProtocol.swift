//
//  PlacesAPIClientProtocol.swift
//  Places
//
//  Created by Fer on 25/05/2025.
//

import Foundation

@MainActor
public protocol PlacesAPIClientProtocol {
    func send(request: PlacesAPIRequest) async throws -> Data
}

public protocol PlacesAPIRequest {
    var httpMethod: String { get }
    var path: String { get }
    var parameters: [String: String] { get }
}

public enum PlacesAPIClientError: Error, LocalizedError {
    case networkError(httpResponse: HTTPURLResponse, data: Data)
    case unableToParseResponse
}
