//
//  PlaceListRepository.swift
//  Places
//
//  Created by Fer on 24/05/2025.
//
import Foundation
import PlacesAPI

struct PlaceListRepository: PlaceListRepositoryProtocol {
    
    @MainActor private let client: PlacesAPIClientProtocol
    
    private struct PlaceListRequest: PlacesAPIRequest {
        let httpMethod = "GET"
        let path = "/locations.json"
        var parameters: [String : String] = [:]
    }
    
    init(client: PlacesAPIClientProtocol) {
        self.client = client
    }
    
    func getPlaceList() async throws -> [Place] {
        let placeListData = try await client.send(request: PlaceListRequest())
        let placeList = try JSONDecoder().decode(PlaceListResponse.self, from: placeListData)
        return placeList.places
    }

}
