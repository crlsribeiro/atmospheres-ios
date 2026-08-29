//
//  AtmospheresApp.swift
//  Atmospheres
//
//  Created by Carlos Ribeiro on 8/29/26.
//
import SwiftUI

@main
struct AtmospheresApp: App {
    @State private var locationManager = LocationManager()
    @State private var cityStore = CityStore()
    @State private var settingsStore = SettingsStore()

    var body: some Scene {
        WindowGroup {
            MainTabView(
                locationManager: locationManager,
                cityStore: cityStore,
                settingsStore: settingsStore
            )
        }
    }
}
