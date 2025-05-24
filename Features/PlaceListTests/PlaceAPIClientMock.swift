//
//  PlaceAPIClientMock.swift
//  Places
//
//  Created by Fer on 25/05/2025.
//

import Foundation
import PlacesAPI

struct PlaceAPIClientMock: PlacesAPIClientProtocol {
    
    let data: Data
    
    init(data: Data) {
        self.data = data
    }

    func send(request: any PlacesAPI.PlacesAPIRequest) async throws -> Data {
        return data
    }
}
