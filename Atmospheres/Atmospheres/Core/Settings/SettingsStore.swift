//
//  SettingsStore.swift
//  Atmospheres
//
//  Created by Carlos Ribeiro on 8/29/26.
//

import Foundation

enum TemperatureUnit: String, CaseIterable {
    case celsius = "°C"
    case fahrenheit = "°F"
}

enum WindUnit: String, CaseIterable {
    case kmh = "km/h"
    case mph = "mph"
}

enum AppTheme: String, CaseIterable {
    case light = "Light"
    case dark = "Dark"
    case automatic = "Automatic"
}

@Observable
final class SettingsStore {
    var temperatureUnit: TemperatureUnit {
        didSet { UserDefaults.standard.set(temperatureUnit.rawValue, forKey: "temperature_unit") }
    }

    var windUnit: WindUnit {
        didSet { UserDefaults.standard.set(windUnit.rawValue, forKey: "wind_unit") }
    }

    var theme: AppTheme {
        didSet { UserDefaults.standard.set(theme.rawValue, forKey: "app_theme") }
    }

    var rainAlertsEnabled: Bool {
        didSet { UserDefaults.standard.set(rainAlertsEnabled, forKey: "rain_alerts") }
    }

    var severeAlertsEnabled: Bool {
        didSet { UserDefaults.standard.set(severeAlertsEnabled, forKey: "severe_alerts") }
    }

    init() {
        let defaults = UserDefaults.standard
        temperatureUnit = TemperatureUnit(rawValue: defaults.string(forKey: "temperature_unit") ?? "") ?? .celsius
        windUnit = WindUnit(rawValue: defaults.string(forKey: "wind_unit") ?? "") ?? .kmh
        theme = AppTheme(rawValue: defaults.string(forKey: "app_theme") ?? "") ?? .automatic
        rainAlertsEnabled = defaults.object(forKey: "rain_alerts") as? Bool ?? true
        severeAlertsEnabled = defaults.object(forKey: "severe_alerts") as? Bool ?? false
    }
}
