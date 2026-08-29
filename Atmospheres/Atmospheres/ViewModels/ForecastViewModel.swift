//
//  ForecastViewModel.swift
//  Atmospheres
//
//  Created by Carlos Ribeiro on 8/29/26.
//

import Foundation

@Observable
final class ForecastViewModel {
    var snapshot: WeatherSnapshot?

    func update(with snapshot: WeatherSnapshot?) {
        self.snapshot = snapshot
    }
}
