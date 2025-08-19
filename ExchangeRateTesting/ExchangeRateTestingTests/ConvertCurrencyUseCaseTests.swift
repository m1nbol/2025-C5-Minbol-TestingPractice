//
//  ConvertCurrencyUseCaseTests.swift
//  ExchangeRateTesting
//
//  Created by BoMin Lee on 8/19/25.
//

import Testing
@testable import ExchangeRateTesting

@Suite(.tags(.unit))
struct ConvertCurrencyUseCaseTests {
    @Test
    func roundingToCents() {
        let usecase = ConvertCurrencyUseCase(feePercent: 0.0)
        let out = usecase(amount: 10.005, rate: Rate(1.0), rounding: .toCents)
        #expect(out == 10.01)
    }

    @Test
    func feeApplied() {
        let usecase = ConvertCurrencyUseCase(feePercent: 0.1) // 10% 수수료
        let out = usecase(amount: 100, rate: Rate(2.0), rounding: .toCents)
        // 100 * 2.0 * (1 - 0.1) = 180.0
        #expect(out == 180.0)
    }

    @Test
    func noRounding() {
        let usecase = ConvertCurrencyUseCase(feePercent: 0.0)
        let out = usecase(amount: 1.111, rate: Rate(1.111), rounding: .none)
        #expect(out == 1.234321)
    }
}
