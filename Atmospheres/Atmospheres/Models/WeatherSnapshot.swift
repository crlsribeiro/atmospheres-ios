//
//  WeatherSnapshot.swift
//  Atmospheres
//
//  Created by Carlos Ribeiro on 8/29/26.
//

import Foundation

struct WeatherSnapshot {
    let cityName: String
    let currentTemperature: Double
    let condition: String
    let symbolName: String
    let highTemperature: Double
    let lowTemperature: Double
    let feelsLike: Double
    let humidity: Double
    let windSpeed: Double
    let uvIndex: Int
    let hourly: [HourlyForecast]
    let daily: [DailyForecast]
}

struct HourlyForecast: Identifiable {
    let id = UUID()
    let time: Date
    let temperature: Double
    let symbolName: String
}

struct DailyForecast: Identifiable {
    let id = UUID()
    let date: Date
    let highTemperature: Double
    let lowTemperature: Double
    let symbolName: String
    let condition: String
}
