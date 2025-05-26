//
//  Place.swift
//  Places
//
//  Created by Fer on 24/05/2025.
//

public struct Place: Codable, Identifiable {
    public let name: String?
    public let latitude: Double
    public let longitude: Double
    
    private enum CodingKeys: String, CodingKey {
        case name
        case latitude = "lat"
        case longitude = "long"
    }
    
    public var id: String {
        return "\(latitude):\(longitude)"
    }
}
