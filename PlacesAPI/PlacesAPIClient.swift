//
//  PlacesAPIClient.swift
//  Places
//
//  Created by Fer on 25/05/2025.
//

import Foundation

public class PlacesAPIClient: PlacesAPIClientProtocol {

    private let baseURL: URL
    
    public init(baseURL: URL) {
        self.baseURL = baseURL
    }

    public func send(request: PlacesAPIRequest) async throws -> Data {
        
        var request = URLRequest(url: baseURL.appending(path: request.path))
        request.httpMethod = request.httpMethod
        request.allHTTPHeaderFields = [
            "Accept": "application/json"
        ]

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw PlacesAPIClientError.unableToParseResponse
        }

        guard httpResponse.statusCode == 200 else {
            throw PlacesAPIClientError.networkError(httpResponse: httpResponse, data: data)
        }

        return data
    }

}
