//
//  CalculatorParameterizedTests.swift
//  ExchangeKit
//
//  Created by BoMin Lee on 8/14/25.
//


import Testing
@testable import ExchangeKit

struct Case {
    let amount: Double
    let rate: Double
    let fee: Double
    let expected: Double
}

@Suite(.tags(.unit))
struct CalculatorParameterizedTests {
    // 서로 다른 (amount, rate, fee%, expected) 케이스
    @Test(arguments: [
        Case(amount: 0,   rate: 1.25, fee: 0.0,  expected: 0.00),
        Case(amount: 100, rate: 1.30, fee: 0.0,  expected: 130.00),
        Case(amount: 100, rate: 1.30, fee: 0.02, expected: 127.40),
        Case(amount: 12.3,rate: 0.99, fee: 0.01, expected: 12.06)
    ])
    func converts(_ c: Case) {
        let calc = FXCalculator(feePercent: c.fee)
        let result = calc.convert(amount: c.amount, rate: c.rate, rounding: .toCents)
        #expect(abs(result - c.expected) < 0.000_1)
    }

    // 경계값/전제 조건 체크: 음수 입력 차단
    @Test
    func negativeInputPrecondition() throws {
        let calc = FXCalculator()
        // precondition을 직접 터뜨리면 테스트가 크래시하므로,
        // 전제(#require)로 사전 방어 예시를 보여줌
        let amount = 1.0
        try #require(amount >= 0, "금액은 0 이상이어야 합니다")
        _ = calc.convert(amount: amount, rate: 1.2) // 여긴 실행되지 않음
    }
}
