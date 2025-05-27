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
    weak var navigationController: UINavigationController?
    var factory: PlaceListFactory

    public init(navigationController: UINavigationController, factory: PlaceListFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }

    public func start() {
        showPlaceList()
    }

    private func showPlaceList() {
        guard let navigationController = navigationController else {
            assertionFailure()
            return
        }
        let placeListView = factory.newPlaceListView(coordinator: self)
        let homeVC = UIHostingController(rootView: placeListView)
        navigationController.setViewControllers([homeVC], animated: false)
    }
    
    fileprivate func pushCustomPlaceView() {
        
    }
}

extension PlaceListCoordinator: PlaceListCoordinatorProtocol {

    public func showCustomPlace() {
        pushCustomPlaceView()
    }
    
    public func showError(localizedMessage: String) {
        
    }
}

