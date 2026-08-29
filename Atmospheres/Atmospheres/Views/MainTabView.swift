//
//  MainTabView.swift
//  Atmospheres
//
//  Created by Carlos Ribeiro on 8/29/26.
//

import SwiftUI

struct MainTabView: View {
    let locationManager: LocationManager
    let cityStore: CityStore
    let settingsStore: SettingsStore

    @State private var dashboardViewModel: DashboardViewModel
    @State private var citiesViewModel: CitiesViewModel
    @State private var settingsViewModel: SettingsViewModel

    init(locationManager: LocationManager, cityStore: CityStore, settingsStore: SettingsStore) {
        self.locationManager = locationManager
        self.cityStore = cityStore
        self.settingsStore = settingsStore
        _dashboardViewModel = State(initialValue: DashboardViewModel(locationManager: locationManager))
        _citiesViewModel = State(initialValue: CitiesViewModel(cityStore: cityStore))
        _settingsViewModel = State(initialValue: SettingsViewModel(settingsStore: settingsStore))
    }

    var body: some View {
        TabView {
            DashboardView(viewModel: dashboardViewModel, locationManager: locationManager)
                .tabItem { Label("Weather", systemImage: "cloud.sun.fill") }

            ForecastView(snapshot: dashboardViewModel.snapshot)
                .tabItem { Label("Forecast", systemImage: "calendar") }

            CitiesView(viewModel: citiesViewModel)
                .tabItem { Label("Cities", systemImage: "list.bullet") }

            SettingsView(viewModel: settingsViewModel)
                .tabItem { Label("Settings", systemImage: "gearshape.fill") }
        }
    }
}
