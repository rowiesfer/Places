//
//  Place.swift
//  Places
//
//  Created by Fer on 24/05/2025.
//

public struct Place: Codable, Identifiable, Sendable, Equatable {
    let name: String?
    let latitude: Double
    let longitude: Double
    
    private enum CodingKeys: String, CodingKey {
        case name
        case latitude = "lat"
        case longitude = "long"
    }
    
    public var id: String {
        return "\(latitude):\(longitude)"
    }
}
