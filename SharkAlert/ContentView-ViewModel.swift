//
//  ContentView-ViewModel.swift
//  SharkAlert
//
//  Created by Renato Martins on 31/07/2023.
//

import Foundation
import MapKit

    @MainActor class ViewModel: ObservableObject {
        
        @Published var isShowingSheet = false
        @Published var currentDate = Date.now
        
        @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5))
        @Published var locations: [Location]
        
        let savePath = FileManager.documentsDirectory.appendingPathExtension("SavedEvents")
        
        //Event Type Button Properties
        @Published var eventType = ""
        
        //AddEventView Properties
        @Published var isSeen = false
        @Published var isAttack = false
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
        }
        
        private func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }
        
        func addEvent() {
            let newEvent = Location(id: UUID(), latitude: mapRegion.center.latitude, longitude: mapRegion.center.longitude)
            locations.append(newEvent)
            save()
        }
    }
