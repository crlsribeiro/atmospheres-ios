//
//  ForecastView.swift
//  Atmospheres
//
//  Created by Carlos Ribeiro on 8/29/26.
//

import SwiftUI

struct ForecastView: View {
    let snapshot: WeatherSnapshot?

    var body: some View {
        NavigationStack {
            if let snapshot {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("7-DAY FORECAST")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            VStack(spacing: 0) {
                                ForEach(snapshot.daily) { day in
                                    DailyForecastRow(day: day)
                                    if day.id != snapshot.daily.last?.id {
                                        Divider()
                                    }
                                }
                            }
                            .padding()
                            .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 16))
                        }

                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                            InfoCard(title: "UV Index", value: "\(snapshot.uvIndex)", icon: "sun.max")
                            InfoCard(title: "Feels Like", value: "\(Int(snapshot.feelsLike))°", icon: "thermometer")
                            InfoCard(title: "Humidity", value: "\(Int(snapshot.humidity * 100))%", icon: "humidity")
                            InfoCard(title: "Wind", value: "\(Int(snapshot.windSpeed)) km/h", icon: "wind")
                        }
                    }
                    .padding()
                }
                .navigationTitle(snapshot.cityName)
            } else {
                ContentUnavailableView(
                    "No forecast yet",
                    systemImage: "calendar",
                    description: Text("Open the Weather tab first to load your location.")
                )
            }
        }
    }
}
