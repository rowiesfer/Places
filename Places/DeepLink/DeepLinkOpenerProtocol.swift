//
//  DeepLinkOpenerProtocol.swift
//  Places
//
//  Created by Fer on 26/05/2025.
//
import Foundation

@MainActor
protocol DeepLinkOpenerProtocol {
    func open(_ url: URL) async -> Bool
}
