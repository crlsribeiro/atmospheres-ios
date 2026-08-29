//
//  SettingsView.swift
//  Atmospheres
//
//  Created by Carlos Ribeiro on 8/29/26.
//

import SwiftUI

struct SettingsView: View {
    var viewModel: SettingsViewModel

    var body: some View {
        NavigationStack {
            Form {
                Section("Units") {
                    Picker("Temperature", selection: Binding(
                        get: { viewModel.settingsStore.temperatureUnit },
                        set: { viewModel.settingsStore.temperatureUnit = $0 }
                    )) {
                        ForEach(TemperatureUnit.allCases, id: \.self) { unit in
                            Text(unit.rawValue).tag(unit)
                        }
                    }
                    .pickerStyle(.segmented)

                    Picker("Wind Speed", selection: Binding(
                        get: { viewModel.settingsStore.windUnit },
                        set: { viewModel.settingsStore.windUnit = $0 }
                    )) {
                        ForEach(WindUnit.allCases, id: \.self) { unit in
                            Text(unit.rawValue).tag(unit)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                Section("Notifications") {
                    Toggle("Rain Alerts", isOn: Binding(
                        get: { viewModel.settingsStore.rainAlertsEnabled },
                        set: { viewModel.settingsStore.rainAlertsEnabled = $0 }
                    ))
                    Toggle("Severe Alerts", isOn: Binding(
                        get: { viewModel.settingsStore.severeAlertsEnabled },
                        set: { viewModel.settingsStore.severeAlertsEnabled = $0 }
                    ))
                }

                Section("Appearance") {
                    Picker("Theme", selection: Binding(
                        get: { viewModel.settingsStore.theme },
                        set: { viewModel.settingsStore.theme = $0 }
                    )) {
                        ForEach(AppTheme.allCases, id: \.self) { theme in
                            Text(theme.rawValue).tag(theme)
                        }
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}
