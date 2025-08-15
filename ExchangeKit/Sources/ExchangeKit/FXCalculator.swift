//
//  FXCalculator.swift
//  ExchangeKit
//
//  Created by BoMin Lee on 8/14/25.
//

import Foundation

public struct FXCalculator {
    public var feePercent: Double  // 0.02 => 2% 수수료
    public init(feePercent: Double = 0) { self.feePercent = feePercent }
    
    public enum Rounding {
        case none
        case toCents    // 소수 2자리
    }
    
    public func convert(amount: Double, rate: Double, rounding: Rounding = .toCents) -> Double {
        precondition(amount >= 0 && rate >= 0, "amount/rate must be non-negative")
        let converted = amount * rate
        let withFee = converted * (1 - feePercent)
        switch rounding {
        case .none:
            return withFee
        case .toCents:
            return (withFee * 100).rounded() / 100
        }
    }
}
