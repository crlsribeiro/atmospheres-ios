//
//  WeatherSymbolView.swift
//  Atmospheres
//
//  Created by Carlos Ribeiro on 8/29/26.
//

import SwiftUI

struct WeatherSymbolView: View {
    let symbolName: String
    var size: Font = .largeTitle

    var body: some View {
        Image(systemName: symbolName)
            .font(size)
            .symbolRenderingMode(.multicolor)
    }
}
