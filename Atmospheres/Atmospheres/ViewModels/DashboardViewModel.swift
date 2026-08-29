//
//  DashboardViewModel.swift
//  Atmospheres
//
//  Created by Carlos Ribeiro on 8/29/26.
//

import Foundation
import CoreLocation

@Observable
final class DashboardViewModel {
    private let weatherService = WeatherService()
    private let locationManager: LocationManager

    var snapshot: WeatherSnapshot?
    var isLoading = false
    var errorMessage: String?

    init(locationManager: LocationManager) {
            self.locationManager = locationManager
            locationManager.onLocationUpdate = { [weak self] location in
                Task { await self?.loadWeather(for: location) }
            }
        }

    func requestLocationAndLoad() {
            print("🔵 requestLocationAndLoad called, status: \(locationManager.authorizationStatus.rawValue)")
            if locationManager.authorizationStatus == .notDetermined {
                locationManager.requestPermission()
            } else {
                locationManager.requestLocation()
            }
        }

    @MainActor
       func loadWeather(for location: CLLocation) async {
           print("🔵 loadWeather called with location: \(location)")
           isLoading = true
           errorMessage = nil
           do {
               let cityName = try await resolveCityName(for: location)
               print("🔵 resolved city name: \(cityName)")
               snapshot = try await weatherService.fetchSnapshot(for: location, cityName: cityName)
               print("🟢 snapshot loaded successfully")
           } catch {
               print("🔴 ERROR loading weather: \(error)")
               errorMessage = "Couldn't load weather. Please try again."
           }
           isLoading = false
       }
    private func resolveCityName(for location: CLLocation) async throws -> String {
        let geocoder = CLGeocoder()
        let placemarks = try await geocoder.reverseGeocodeLocation(location)
        return placemarks.first?.locality ?? "Current Location"
    }
}
