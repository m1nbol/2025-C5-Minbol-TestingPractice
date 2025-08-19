//
//  ExchangeRateRepository.swift
//  ExchangeRateTesting
//
//  Created by BoMin Lee on 8/19/25.
//

import Foundation

public protocol ExchangeRateRepository {
    func fetchRate(pair: CurrencyPair) async throws -> Rate
}
