//
//  WikipediaDeepLinkOpener.swift
//  Places
//
//  Created by Fer on 26/05/2025.
//

// TODO: Move this implementation into the main app module
import Foundation
import UIKit

struct WikipediaDeepLinkOpener: WikipediaDeepLinkOpenerProtocol {

    @MainActor func deepLinkToPlaces(at place: Place) {
        if let url = URL(string: "wikipedia://places?name=\(place.name ?? "")&lat=\(place.latitude)&lon=\(place.longitude)") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                print("Wikipedia app not installed")
            }
        }
    }
}
