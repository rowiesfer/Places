//
//  PlaceListViewModel.swift
//  Places
//
//  Created by Fer on 23/05/2025.
//
import Combine

public final class PlaceListViewModel: ObservableObject {
    
    let repository: PlaceListRepositoryProtocol
    
    public init(repository: PlaceListRepositoryProtocol) {
        self.repository = repository
    }
    
    @Published var viewState: PlaceListViewState = .init(loadingState: .loading, messageText: "", places: [])
}
