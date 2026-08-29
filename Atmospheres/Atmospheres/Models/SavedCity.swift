//
//  SavedCity.swift
//  Atmospheres
//
//  Created by Carlos Ribeiro on 8/29/26.
//

import Foundation
import CoreLocation

struct SavedCity: Identifiable, Codable, Equatable {
    let id: UUID
    let name: String
    let latitude: Double
    let longitude: Double

    init(id: UUID = UUID(), name: String, latitude: Double, longitude: Double) {
        self.id = id
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }

    var location: CLLocation {
        CLLocation(latitude: latitude, longitude: longitude)
    }
}
