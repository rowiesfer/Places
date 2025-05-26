//
//  DeepLinkOpenerProtocol.swift
//  Places
//
//  Created by Fer on 26/05/2025.
//

import UIKit

@MainActor
protocol DeepLinkOpenerProtocol {
    func open(_ url: URL, options: [UIApplication.OpenExternalURLOptionsKey: Any]) async -> Bool
}
