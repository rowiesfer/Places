//
//  PlaceListResponse.swift
//  Places
//
//  Created by Fer on 24/05/2025.
//

struct PlaceListResponse: Codable {
    var places: [Place]
    
    private enum CodingKeys: String, CodingKey {
        case places = "locations"
    }
}
