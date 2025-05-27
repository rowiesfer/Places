//
//  DeepLinkOpenerMock.swift
//  Places
//
//  Created by Fer on 27/05/2025.
//

import Foundation

@MainActor
final class DeepLinkOpenerMock: DeepLinkOpenerProtocol {
   
    var success = true
    var url: URL? = nil
    
    func open(_ url: URL) async -> Bool {
        self.url = url
        return success
    }
}
