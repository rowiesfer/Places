//
//  CustomPlaceViewModel.swift
//  Places
//
//  Created by Fer on 27/05/2025.
//

import Combine

enum CoordinateValidationError: String, Error {
    case emptyLatitude = "customplace.error.emptyLatitude"
    case emptyLongitude = "customplace.error.emptyLongitude"
    case cantParseLatitude = "customplace.error.cantParseLatitude"
    case cantParseLongitude = "customplace.error.cantParseLongitude"
}

@MainActor
public final class CustomPlaceViewModel: ObservableObject {
    
    let wikipedia: WikipediaDeepLinkOpenerProtocol
    var deepLinkTask: Task<Void, Error>? = nil

    public init(wikipedia: WikipediaDeepLinkOpenerProtocol) {
        self.wikipedia = wikipedia
    }

    deinit {
        deepLinkTask?.cancel()
    }

    func openPlaceInWikipedia(name: String, latitude: String, longitude: String) {
        var coordinates: (latitude: Double, longitude: Double) = (0.0, 0.0)
        
        do {
            coordinates = try convertToCoordinates(latitudeString: latitude, longitudeString: longitude)
        } catch {
            // TODO: show error
        return
        }

        deepLinkTask?.cancel()
        deepLinkTask = Task {
            do {
                try await wikipedia.deepLinkToPlaces(name: name, latitude: coordinates.latitude, longitude: coordinates.longitude)
            } catch {
                // TODO: show error
            }
        }
    }

    // This whole logic should be taken out to another class and use some regular expressions to properly check for valid coordinates and give proper feedback to the user
    func convertToCoordinates(latitudeString: String, longitudeString: String) throws(CoordinateValidationError) -> (latitude: Double, longitude: Double) {
        
        guard latitudeString.isEmpty == false else {
            throw CoordinateValidationError.emptyLatitude
        }
        
        guard longitudeString.isEmpty == false else {
            throw CoordinateValidationError.emptyLongitude
        }
        
        guard let latitudeDouble = Double(latitudeString) else {
            throw CoordinateValidationError.cantParseLatitude
        }

        guard let longitudeDouble = Double(longitudeString) else {
            throw CoordinateValidationError.cantParseLongitude
        }

        return (latitude: latitudeDouble, longitude: longitudeDouble)
    }

}
