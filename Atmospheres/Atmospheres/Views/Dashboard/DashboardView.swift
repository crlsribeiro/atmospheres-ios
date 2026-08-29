//
//  DashboardView.swift
//  Atmospheres
//
//  Created by Carlos Ribeiro on 8/29/26.
//

import SwiftUI
import CoreLocation

struct DashboardView: View {
    var viewModel: DashboardViewModel
    var locationManager: LocationManager

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    if let snapshot = viewModel.snapshot {
                        VStack(spacing: 8) {
                            Text(snapshot.cityName)
                                .font(.title.bold())
                            Text(snapshot.condition)
                                .foregroundStyle(.secondary)
                            Text("\(Int(snapshot.currentTemperature))°")
                                .font(.system(size: 72, weight: .thin))
                            Text("H:\(Int(snapshot.highTemperature))° L:\(Int(snapshot.lowTemperature))°")
                                .foregroundStyle(.secondary)
                        }
                        .padding(.top)
                        
                        VStack(alignment: .leading, spacing: 12) {
                            Text("HOURLY FORECAST")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(snapshot.hourly) { hour in
                                        HourlyForecastCard(hour: hour)
                                    }
                                }
                            }
                        }
                        .padding()
                        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 16))
                        .padding(.horizontal)
                    } else if viewModel.isLoading {
                        ProgressView("Loading weather…")
                            .padding(.top, 100)
                    } else if let error = viewModel.errorMessage {
                        VStack(spacing: 12) {
                            Image(systemName: "exclamationmark.triangle")
                                .font(.largeTitle)
                            Text(error)
                        }
                        .padding(.top, 100)
                    } else {
                        VStack(spacing: 12) {
                            Image(systemName: "location.circle")
                                .font(.largeTitle)
                            Text("Enable location to see the weather")
                                .multilineTextAlignment(.center)
                            Button("Enable Location") {
                                viewModel.requestLocationAndLoad()
                            }
                            .buttonStyle(.borderedProminent)
                        }
                        .padding(.top, 100)
                    }
                }
            }
            .navigationTitle("Atmos")
            .task {
                viewModel.requestLocationAndLoad()
            }
        }
        
        }
    }

