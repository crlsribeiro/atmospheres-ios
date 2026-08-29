//
//  HourlyForecastCard.swift
//  Atmospheres
//
//  Created by Carlos Ribeiro on 8/29/26.
//

import SwiftUI

struct HourlyForecastCard: View {
    let hour: HourlyForecast

    var body: some View {
        VStack(spacing: 8) {
            Text(hour.time, format: .dateTime.hour())
                .font(.caption)
                .foregroundStyle(.secondary)
            WeatherSymbolView(symbolName: hour.symbolName, size: .title3)
            Text("\(Int(hour.temperature))°")
                .font(.subheadline.bold())
        }
        .frame(width: 60)
    }
}
