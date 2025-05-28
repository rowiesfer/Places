//
//  SceneDelegate.swift
//  Places
//
//  Created by Fer on 27/05/2025.
//

import UIKit
import SwiftUI
import PlaceList

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: PlaceListCoordinator!

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else {
            // Using precondition failure with a message since this situation is unrecoverable.
            // This will be catch by UI tests.
            preconditionFailure("UIWindowScene not found.")
        }

        let baseURL = Configuration.assignmentURL
        let navigationController = UINavigationController()
        let wikipedia = WikipediaDeepLinkOpener(deepLinkOpener: DeepLinkOpener())
        let placeListFactory = PlaceListFactory(baseURL: baseURL, wikipedia: wikipedia)
        coordinator = PlaceListCoordinator(navigationController: navigationController, factory: placeListFactory)
        coordinator.start()

        window = UIWindow(windowScene: windowScene)
        guard window != nil else {
            // Using precondition failure with a message since this situation is unrecoverable.
            // This will be catch by UI tests.
            preconditionFailure("UIWindow not found.")
        }
        window!.rootViewController = navigationController
        window!.makeKeyAndVisible()
    }
}
