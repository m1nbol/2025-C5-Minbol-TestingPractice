//
//  ExchangeRateTestingApp.swift
//  ExchangeRateTesting
//
//  Created by BoMin Lee on 8/19/25.
//

import SwiftUI

@main
struct ExchangeRateTestingApp: App {
    @StateObject private var container = AppDI.bootstrap()

    var body: some Scene {
        WindowGroup {
            ConvertView(viewModel: container.convertVM)
        }
    }
}
