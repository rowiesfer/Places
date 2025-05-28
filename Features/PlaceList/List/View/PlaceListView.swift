//
//  PlaceListView.swift
//  Places
//
//  Created by Fer on 23/05/2025.
//

import SwiftUI

fileprivate enum Constants {
    static let title = "placelist.title"
    static let subtitle = "placelist.subtitle"
    static let buttonCustomPlace = "placelist.button.customplace"
    static let accessibilityTitle = "placelist.title"
    static let accessibilityButtonCustomPlace = "placelist.button.customplace"
}

public struct PlaceListView: View {
    
    @ObservedObject var viewModel: PlaceListViewModel
    
    public init(viewModel: PlaceListViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack {
            title
            button
            Spacer()
            list
            Spacer()
        }
        .onAppear {
            viewModel.fetchPlaces()
        }
    }
    
    @ViewBuilder
    private var title: some View {
        Text(localized: Constants.title)
            .font(.largeTitle)
            .fontWeight(.bold)
            .accessibilityIdentifier(Constants.accessibilityTitle)
        Text(localized: Constants.subtitle)
            .font(.caption)
            .fontWeight(.bold)
    }
    
    @ViewBuilder
    private var button: some View {
        Button(Constants.buttonCustomPlace.localized) {
            viewModel.tryOwnPlaceTapped()
        }
        .font(.caption)
        .fontWeight(.bold)
        .accessibilityIdentifier(Constants.accessibilityButtonCustomPlace)
    }
    
    @ViewBuilder
    private var list: some View {
        switch viewModel.viewState.loadingState {
        case .loading:
            Text(viewModel.viewState.messageText)
        case .error:
            Text(viewModel.viewState.messageText)
        case .success:
            List(viewModel.viewState.places) { place in
                VStack{
                    HStack{
                        Text(place.title)
                            .font(.headline)
                        Spacer()
                    }
                    HStack{
                        Text(place.subtitle)
                            .font(.subheadline)
                            .padding(.bottom)
                        Spacer()
                    }
                }.onTapGesture {
                    viewModel.placeTapped(id: place.id)
                }
            }
        }
    }

}

#Preview {
    PlaceListView(viewModel: PlaceListViewModel(repository: PlaceListRepositoryStub(),
                                                wikipedia: WikipediaDeepLinkOpenerStub(),
                                                coordinator: PlaceListCoordinatorStub())
    )
}
