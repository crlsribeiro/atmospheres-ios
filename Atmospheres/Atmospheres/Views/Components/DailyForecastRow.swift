//
//  DailyForecastRow.swift
//  Atmospheres
//
//  Created by Carlos Ribeiro on 8/29/26.
//

import SwiftUI

struct DailyForecastRow: View {
    let day: DailyForecast

    var body: some View {
        HStack {
            Text(day.date, format: .dateTime.weekday(.abbreviated))
                .frame(width: 50, alignment: .leading)
            WeatherSymbolView(symbolName: day.symbolName, size: .title3)
                .frame(width: 40)
            Spacer()
            Text("\(Int(day.lowTemperature))°")
                .foregroundStyle(.secondary)
            Text("\(Int(day.highTemperature))°")
                .fontWeight(.semibold)
        }
        .padding(.vertical, 4)
    }
}
