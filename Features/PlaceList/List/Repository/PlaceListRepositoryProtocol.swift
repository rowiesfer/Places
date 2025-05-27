//
//  PlaceListRepositoryProtocol.swift
//  Places
//
//  Created by Fer on 24/05/2025.
//

@MainActor
public protocol PlaceListRepositoryProtocol {
    func getPlaceList() async throws -> [Place]
}

public enum PlaceListRepositoryError: Error {
    case networkError
    case unableToParseResponse
}
