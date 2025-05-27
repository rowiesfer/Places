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
        
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let navigationController = UINavigationController()
        let baseURL = URL(string: "https://raw.githubusercontent.com/abnamrocoesd/assignment-ios/main")!
        let wikipedia = WikipediaDeepLinkOpener(deepLinkOpener: DeepLinkOpener())
        let placeListFactory = PlaceListFactory(baseURL: baseURL, wikipedia: wikipedia)
        coordinator = PlaceListCoordinator(navigationController: navigationController, factory: placeListFactory)
        coordinator.start()

        window = UIWindow(windowScene: windowScene)
        window!.rootViewController = navigationController
        window!.makeKeyAndVisible()
    }
}
