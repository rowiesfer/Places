//
//  PlaceListCoordinator.swift
//  Places
//
//  Created by Fer on 27/05/2025.
//

import UIKit
import SwiftUI

fileprivate enum Constants {
    static let errorTitle = "Error"
    static let actionOK = "OK"
}

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
        guard let navigationController = navigationController else {
            assertionFailure()
            return
        }
        let customPlaceView = factory.customPlaceView(coordinator: self)
        let customPlaceVC = UIHostingController(rootView: customPlaceView)
        navigationController.pushViewController(customPlaceVC, animated: true)
    }
}

extension PlaceListCoordinator: PlaceListCoordinatorProtocol {

    public func showCustomPlace() {
        pushCustomPlaceView()
    }
    
    public func showError(localizedMessage: String) {
        guard let navigationController = navigationController else {
            assertionFailure("Navigation controller is nil.")
            return
        }
        let alertController = UIAlertController(title: Constants.errorTitle,
                                                message: localizedMessage,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: Constants.actionOK, style: .default))
        navigationController.present(alertController, animated: true)
    }
}
