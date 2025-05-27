//
//  PlaceListViewState.swift
//  Places
//
//  Created by Fer on 23/05/2025.
//

struct PlaceListViewState {

    enum LoadingState {
        case loading
        case error
        case success
    }
    
    struct PlaceViewData: Identifiable {
        let id: String
        let title: String
        let subtitle: String
    }

    let loadingState: LoadingState
    let messageText: String
    let places: [PlaceViewData]
}
