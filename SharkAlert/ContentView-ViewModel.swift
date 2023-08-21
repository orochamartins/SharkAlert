//
//  ContentView-ViewModel.swift
//  SharkAlert
//
//  Created by Renato Martins on 31/07/2023.
//

import Foundation
import MapKit
import SwiftUI

    class ViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
        
        @Published var isShowingSheet = false
        @Published var currentDate = Date.now
        @Published var selectedEvent: Location?
        
        @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5))
        @Published var locations: [Location]
      
        let savePath = FileManager.documentsDirectory.appendingPathExtension("SavedEvents")
        
        //User location manager
        
        @Published var locationManager: CLLocationManager?
        
        //Sheet height properties
        @Published var addEventHeight: CGFloat = .zero
        @Published var eventDetailsHeight: CGFloat = .zero
        
        //Event Type Button Properties
        @Published var eventType = ""
        
        //AddEventView Properties
        @Published var isSeen = false
        @Published var isAttack = false
        
        //EventDetailsView Properties
        @Published var isReported = false
        @Published var reportSent = false
        @Published var reportTitle = ""
        
        override init() {
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
            let newEvent = Location(id: UUID(), latitude: mapRegion.center.latitude, longitude: mapRegion.center.longitude, date: currentDate, eventType: eventType)
            locations.append(newEvent)
            save()
            reset()
        }
        
        func reset() {
            eventType = ""
            reportSent = false
            withAnimation {
                mapRegion.span = MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5)
            }
        }
        
        func centerUserLocation() {
            withAnimation {
                mapRegion = MKCoordinateRegion(center: locationManager?.location?.coordinate ?? CLLocationCoordinate2D(latitude: 50, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5))
            }
        }
        
        func checkIfLocationManagerIsEnabled() {
            DispatchQueue.global().async {
                if CLLocationManager.locationServicesEnabled() {
                    self.locationManager = CLLocationManager()
                    self.locationManager!.delegate = self
                } else {
                    print("Turn location services on.")
                }
            }
        }
        
        private func checkLocationAuthorization() {
            guard let locationManager = locationManager else { return }
            
            switch locationManager.authorizationStatus {
                
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .restricted:
                print("Your location is restricted. Check parental controls.")
            case .denied:
                print("You have denied this app location permission. Go into settings to change it.")
            case .authorizedAlways, .authorizedWhenInUse:
                mapRegion = MKCoordinateRegion(center: locationManager.location?.coordinate ?? CLLocationCoordinate2D(latitude: 50, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5))
            @unknown default:
                break
            }
        }
        
        func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
            checkLocationAuthorization()
        }
    }
