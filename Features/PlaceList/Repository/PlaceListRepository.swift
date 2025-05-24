//
//  PlaceListRepository.swift
//  Places
//
//  Created by Fer on 24/05/2025.
//
import Foundation

struct PlaceListRepository: PlaceListRepositoryProtocol {
    
    private let placeListData: Data
    
    init(placeListData: Data) {
        self.placeListData = placeListData
    }
    
    func getPlaceList() async throws -> [Place] {
        let placeListData = try JSONDecoder().decode(PlaceListResponse.self, from: placeListData)
        return placeListData.places
    }
}
