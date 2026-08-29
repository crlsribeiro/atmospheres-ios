//
//  CityStore.swift
//  Atmospheres
//
//  Created by Carlos Ribeiro on 8/29/26.
//

import Foundation

@Observable
final class CityStore {
    private let defaultsKey = "saved_cities"

    var cities: [SavedCity] = [] {
        didSet { persist() }
    }

    init() {
        load()
    }

    func add(_ city: SavedCity) {
        guard !cities.contains(where: { $0.name.lowercased() == city.name.lowercased() }) else { return }
        cities.append(city)
    }

    func remove(_ city: SavedCity) {
        cities.removeAll { $0.id == city.id }
    }

    private func persist() {
        if let data = try? JSONEncoder().encode(cities) {
            UserDefaults.standard.set(data, forKey: defaultsKey)
        }
    }

    private func load() {
        guard let data = UserDefaults.standard.data(forKey: defaultsKey),
              let decoded = try? JSONDecoder().decode([SavedCity].self, from: data) else { return }
        cities = decoded
    }
}
