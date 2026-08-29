//
//  WeatherService.swift
//  Atmospheres
//
//  Created by Carlos Ribeiro on 8/29/26.
//

import Foundation
import WeatherKit
import CoreLocation

final class WeatherService {
    private let service = WeatherKit.WeatherService.shared

    func fetchSnapshot(for location: CLLocation, cityName: String) async throws -> WeatherSnapshot {
        let weather = try await service.weather(for: location)

        let current = weather.currentWeather
        let hourly = weather.hourlyForecast.forecast
            .prefix(24)
            .map {
                HourlyForecast(
                    time: $0.date,
                    temperature: $0.temperature.value,
                    symbolName: $0.symbolName
                )
            }

        let daily = weather.dailyForecast.forecast
            .prefix(7)
            .map {
                DailyForecast(
                    date: $0.date,
                    highTemperature: $0.highTemperature.value,
                    lowTemperature: $0.lowTemperature.value,
                    symbolName: $0.symbolName,
                    condition: $0.condition.description
                )
            }

        return WeatherSnapshot(
            cityName: cityName,
            currentTemperature: current.temperature.value,
            condition: current.condition.description,
            symbolName: current.symbolName,
            highTemperature: daily.first?.highTemperature ?? current.temperature.value,
            lowTemperature: daily.first?.lowTemperature ?? current.temperature.value,
            feelsLike: current.apparentTemperature.value,
            humidity: current.humidity,
            windSpeed: current.wind.speed.value,
            uvIndex: current.uvIndex.value,
            hourly: Array(hourly),
            daily: Array(daily)
        )
    }
}
