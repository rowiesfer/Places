//
//  PlaceListRepositoryProtocol.swift
//  Places
//
//  Created by Fer on 24/05/2025.
//

public protocol PlaceListRepositoryProtocol {
    func getPlaceList() async throws -> [Place]
}
