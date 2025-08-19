//
//  ExchangeRateDTO.swift
//  ExchangeRateTesting
//
//  Created by BoMin Lee on 8/19/25.
//

import Foundation

struct PairDTO: Decodable {
    let result: String
    let base_code: String
    let target_code: String
    let conversion_rate: Double
}

struct LatestDTO: Decodable {
    let result: String
    let base_code: String
    let conversion_rates: [String: Double]
}
