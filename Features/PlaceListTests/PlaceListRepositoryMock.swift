//
//  PlaceListRepositoryMock.swift
//  Places
//
//  Created by Fer on 24/05/2025.
//

struct PlaceListRepositoryMock: PlaceListRepositoryProtocol {
    
    let places: [Place]
    let error: Error?
    
    init(places: [Place] = [], error: Error? = nil) {
        self.places = places
        self.error = error
    }
    
    func getPlaceList() async throws -> [Place] {
        if let error = error {
            throw error
        }
        return self.places
    }
}
