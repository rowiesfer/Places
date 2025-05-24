//
//  PlaceListViewModel.swift
//  Places
//
//  Created by Fer on 23/05/2025.
//
import Combine

public final class PlaceListViewModel: ObservableObject {
    
    public init() {
    }
    
    @Published var viewState: PlaceListViewState = .init(loadingState: .success, messageText: "", places: [
        .init(id: "1",
              locationName: "Amsterdam",
              locationCoordinates: "lat: 52.3547498, long: 4.8339215"),
        .init(id: "2",
              locationName: "Mumbai",
              locationCoordinates: "lat: 19.0823998, long: 72.8111468"),
        .init(id: "3",
              locationName: "Copenhagen",
              locationCoordinates: "lat: 55.6713442, long: 12.523785"),
        .init(id: "4",
              locationName: "",
              locationCoordinates: "lat: 40.4380638, long: -3.7495758")
    ])
}
