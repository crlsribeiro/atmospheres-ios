//
//  SettingsViewModel.swift
//  Atmospheres
//
//  Created by Carlos Ribeiro on 8/29/26.
//

import Foundation

@Observable
final class SettingsViewModel {
    let settingsStore: SettingsStore

    init(settingsStore: SettingsStore) {
        self.settingsStore = settingsStore
    }
}

