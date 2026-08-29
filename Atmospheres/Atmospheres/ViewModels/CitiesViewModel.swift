//
//  CitiesViewModel.swift
//  Atmospheres
//
//  Created by Carlos Ribeiro on 8/29/26.
//

import Foundation
import CoreLocation

@Observable
final class CitiesViewModel {
    private let cityStore: CityStore
    private let weatherService = WeatherService()

    var searchText: String = ""
    var cityWeather: [UUID: WeatherSnapshot] = [:]
    var isSearching = false

    var cities: [SavedCity] {
        cityStore.cities
    }

    init(cityStore: CityStore) {
        self.cityStore = cityStore
    }

    func addCity(_ city: SavedCity) {
        cityStore.add(city)
        Task { await loadWeather(for: city) }
    }

    func removeCity(_ city: SavedCity) {
        cityStore.remove(city)
        cityWeather[city.id] = nil
    }

    @MainActor
    func loadWeather(for city: SavedCity) async {
        do {
            let snapshot = try await weatherService.fetchSnapshot(for: city.location, cityName: city.name)
            cityWeather[city.id] = snapshot
        } catch {
            // Silently ignore for now; card will show without data
        }
    }

    @MainActor
    func loadAllCities() async {
        for city in cities {
            await loadWeather(for: city)
        }
    }

    @MainActor
    func searchCity(named query: String) async -> SavedCity? {
        guard !query.isEmpty else { return nil }
        isSearching = true
        defer { isSearching = false }

        let geocoder = CLGeocoder()
        do {
            let placemarks = try await geocoder.geocodeAddressString(query)
            guard let placemark = placemarks.first,
                  let location = placemark.location else { return nil }
            let name = placemark.locality ?? query
            return SavedCity(name: name, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        } catch {
            return nil
        }
    }
}
