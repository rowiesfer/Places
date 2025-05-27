//
//  PlaceListCoordinatorProtocol.swift
//  Places
//
//  Created by Fer on 27/05/2025.
//

@MainActor
public protocol PlaceListCoordinatorProtocol: AnyObject {
    func showError(localizedMessage: String)
    func showCustomPlace()
}
