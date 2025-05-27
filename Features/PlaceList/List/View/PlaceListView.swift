//
//  PlaceListView.swift
//  Places
//
//  Created by Fer on 23/05/2025.
//

import SwiftUI

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
        Text(localized: "placelist.title")
            .font(.largeTitle)
            .fontWeight(.bold)
            .accessibilityIdentifier("placelist.title")
        Text(localized: "placelist.subtitle")
            .font(.caption)
            .fontWeight(.bold)
    }
    
    @ViewBuilder
    private var button: some View {
        Button("placelist.button.customplace".localized) {
            viewModel.tryOwnPlaceTapped()
        }
        .font(.caption)
        .fontWeight(.bold)
        .accessibilityIdentifier("placelist.button.customplace")
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
