//
//  CustomPlaceView.swift
//  PlaceList
//
//  Created by Fer on 27/05/2025.
//

import SwiftUI

fileprivate enum Constants {
    static let title = "customplace.title"
    static let subtitle = "customplace.subtitle"
    static let namePlaceholder = "customplace.name.placeholder"
    static let latitudePlaceholder = "customplace.latitude.placeholder"
    static let longitudePlaceholder = "customplace.longitude.placeholder"
    static let buttonWikipedia = "customplace.button.wikipedia"
}

public struct CustomPlaceView: View {
    @State private var placeName: String = ""
    @State private var latitude: String = ""
    @State private var longitude: String = ""
    
    @ObservedObject var viewModel: CustomPlaceViewModel

    public init(viewModel: CustomPlaceViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        VStack(spacing: 16) {
            title
            inputs
            button
            Spacer()
        }
        .padding()
    }

    @ViewBuilder
    private var title: some View {
        Text(localized: Constants.title)
            .font(.largeTitle)
            .fontWeight(.bold)
            .accessibilityIdentifier(Constants.title)
        Text(localized: Constants.subtitle)
            .font(.caption)
            .fontWeight(.bold)
    }

    @ViewBuilder
    private var inputs: some View {
        TextField(Constants.namePlaceholder.localized, text: $placeName)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .keyboardType(.default)

        TextField(Constants.latitudePlaceholder.localized, text: $latitude)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .keyboardType(.decimalPad)

        TextField(Constants.longitudePlaceholder.localized, text: $longitude)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .keyboardType(.decimalPad)
    }

    @ViewBuilder
    private var button: some View {
        Button(Constants.buttonWikipedia.localized) {
            viewModel.openPlaceInWikipedia(name: placeName, latitude: latitude, longitude: longitude)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.blue)
        .foregroundColor(.white)
        .cornerRadius(8)
    }
}

#Preview {
    CustomPlaceView(viewModel: CustomPlaceViewModel(wikipedia: WikipediaDeepLinkOpenerStub()))
}
