//
//  ConvertCurrencyUseCase.swift
//  ExchangeRateTesting
//
//  Created by BoMin Lee on 8/19/25.
//

import Foundation

public struct ConvertCurrencyUseCase {
    public enum Rounding { case none, toCents }
    private let feePercent: Double

    public init(feePercent: Double = 0.0) { self.feePercent = feePercent }

    public func callAsFunction(amount: Double, rate: Rate, rounding: Rounding = .toCents) -> Double {
        let converted = amount * rate.value * (1.0 - feePercent)
        switch rounding {
        case .none: return converted
        case .toCents:
            return (converted * 100).rounded() / 100
        }
    }
}
