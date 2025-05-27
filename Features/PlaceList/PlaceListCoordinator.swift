//
//  PlaceListCoordinator.swift
//  Places
//
//  Created by Fer on 27/05/2025.
//

import UIKit
import SwiftUI

@MainActor
public final class PlaceListCoordinator {
    unowned var navigationController: UINavigationController
    var factory: PlaceListFactory

    public init(navigationController: UINavigationController, factory: PlaceListFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }

    public func start() {
        showPlaceList()
    }

    private func showPlaceList() {
        let placeListView = factory.newPlaceListView()
        let homeVC = UIHostingController(rootView: placeListView)
        navigationController.setViewControllers([homeVC], animated: false)
    }
}
