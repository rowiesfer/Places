//
//  Place.swift
//  Places
//
//  Created by Fer on 24/05/2025.
//

public struct Place: Codable {
    let name: String?
    let latitude: Double
    let longitude: Double
    
    private enum CodingKeys: String, CodingKey {
        case name
        case latitude = "lat"
        case longitude = "long"
    }
}
