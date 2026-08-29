//
//  CitiesView.swift
//  Atmospheres
//
//  Created by Carlos Ribeiro on 8/29/26.
//

import SwiftUI

struct CitiesView: View {
    var viewModel: CitiesViewModel
    @State private var searchText = ""

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.cities) { city in
                    CityRow(city: city, snapshot: viewModel.cityWeather[city.id])
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        viewModel.removeCity(viewModel.cities[index])
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Cities")
            .searchable(text: $searchText, prompt: "Search for a city")
            .onSubmit(of: .search) {
                Task {
                    if let city = await viewModel.searchCity(named: searchText) {
                        viewModel.addCity(city)
                        searchText = ""
                    }
                }
            }
            .task {
                await viewModel.loadAllCities()
            }
        }
    }
}

private struct CityRow: View {
    let city: SavedCity
    let snapshot: WeatherSnapshot?

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(city.name)
                    .font(.headline)
                Text(snapshot?.condition ?? "Loading…")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            if let snapshot {
                VStack(alignment: .trailing, spacing: 4) {
                    Text("\(Int(snapshot.currentTemperature))°")
                        .font(.title2.bold())
                    Text("H:\(Int(snapshot.highTemperature))° L:\(Int(snapshot.lowTemperature))°")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
            } else {
                ProgressView()
            }
        }
        .padding(.vertical, 6)
    }
}
