//
//  Location.swift
//  SharkAlert
//
//  Created by Renato Martins on 31/07/2023.
//

import Foundation
import MapKit

struct Location: Identifiable, Codable {
    var id: UUID
    let latitude: Double
    let longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static let example = Location(id: UUID(), latitude: 51.501, longitude: -0.141)
}
