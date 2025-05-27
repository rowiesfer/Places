//
//  CustomPlaceView.swift
//  PlaceList
//
//  Created by Fer on 27/05/2025.
//

import SwiftUI

public struct CustomPlaceView: View {
    @State private var placeName: String = ""
    @State private var latitude: String = ""
    @State private var longitude: String = ""

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
        Text(localized: "customplace.title")
            .font(.largeTitle)
            .fontWeight(.bold)
        Text(localized: "customplace.subtitle")
            .font(.caption)
            .fontWeight(.bold)
    }

    @ViewBuilder
    private var inputs: some View {
        TextField("customplace.name.placeholder".localized, text: $placeName)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .keyboardType(.default)

        TextField("customplace.latitude.placeholder".localized, text: $latitude)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .keyboardType(.decimalPad)

        TextField("customplace.longitude.placeholder".localized, text: $longitude)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .keyboardType(.decimalPad)
    }

    @ViewBuilder
    private var button: some View {
        Button("customplace.button.wikipedia".localized) {
            // call view model
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.blue)
        .foregroundColor(.white)
        .cornerRadius(8)
    }
}

#Preview {
    CustomPlaceView()
}

