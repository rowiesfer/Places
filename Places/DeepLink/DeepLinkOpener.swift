//
//  DeepLinkOpener.swift
//  Places
//
//  Created by Fer on 26/05/2025.
//

import UIKit

final class DeepLinkOpener: DeepLinkOpenerProtocol {
    func open(_ url: URL) async -> Bool {
        await withCheckedContinuation { continuation in
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:]) { success in
                    continuation.resume(returning: success)
                }
            } else {
                continuation.resume(returning: false)
            }
        }
    }
}
