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
            Spacer()
            list
        }
        .onAppear {
        }
    }
    
    @ViewBuilder
    private var title: some View {
        Text("Places")
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding(.top)
        Text("Tap on a place below to open it in the Wikipedia app")
            .font(.caption)
            .fontWeight(.bold)
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
                }
            }
        }
    }

}

#Preview {
    PlaceListView(viewModel: PlaceListViewModel())
}
