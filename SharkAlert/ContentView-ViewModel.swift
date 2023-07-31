//
//  ContentView-ViewModel.swift
//  SharkAlert
//
//  Created by Renato Martins on 31/07/2023.
//

import Foundation
import MapKit

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        
        @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
        @Published private(set) var locations: [Location]
        
        init() {
            locations = [Location.example]
        }
    }
}
