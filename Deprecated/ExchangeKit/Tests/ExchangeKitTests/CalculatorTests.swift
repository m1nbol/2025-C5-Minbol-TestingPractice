//
//  CalculatorTests.swift
//  ExchangeKit
//
//  Created by BoMin Lee on 8/14/25.
//

import Testing
@testable import ExchangeKit

@Suite(.tags(.unit))
struct CalculatorTests {

    @Test
    func simpleConversion() {
        let calc = FXCalculator()
        let result = calc.convert(amount: 100, rate: 1.3, rounding: .toCents)
        #expect(result == 130.00)
    }

    @Test
    func feeApplied() {
        let calc = FXCalculator(feePercent: 0.02)
        let result = calc.convert(amount: 100, rate: 1.3, rounding: .toCents)
        // 100 * 1.3 = 130 → 2% fee → 127.4
        #expect(abs(result - 127.4) < 0.000_1)
    }
}
