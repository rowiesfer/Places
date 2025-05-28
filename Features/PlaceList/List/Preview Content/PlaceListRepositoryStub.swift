//
//  PlaceListRepositoryStub.swift
//  Places
//
//  Created by Fer on 24/05/2025.
//
#if DEBUG

public struct PlaceListRepositoryStub: PlaceListRepositoryProtocol {
    
    public init() { }
    
    public func getPlaceList() async throws -> [Place] {
        [
            .init(name: "Amsterdam", latitude: 52.3547498, longitude: 4.8339215),
            .init(name: "Mumbai", latitude: 19.0823998, longitude: 72.8111468),
            .init(name: "Copenhagen", latitude: 55.6713442, longitude: 12.523785),
            .init(name: nil, latitude: 40.4380638, longitude: -3.7495758)
        ]
    }
}

#endif
