//
//  FetchPairRateMock.swift
//  ExchangeRateTesting
//
//  Created by BoMin Lee on 8/19/25.
//


import Foundation
import Testing
@testable import ExchangeRateTesting

private struct FetchPairRateMock: FetchPairRateUseCase {
    let behavior: (String, String) async throws -> Rate
    func callAsFunction(base: String, quote: String) async throws -> Rate {
        try await behavior(base, quote)
    }
}

@Suite(.tags(.unit))
@MainActor
struct ConvertViewModelTests {
    @Test
    func successUpdatesResult() async throws {
        let fetch = FetchPairRateMock { _,_ in Rate(1300) }
        let convert = ConvertCurrencyUseCase(feePercent: 0.0)

        let vm = ConvertViewModel(fetchRate: fetch, convertCurrency: convert)
        vm.base = "USD"; vm.quote = "KRW"; vm.amount = "2"

        await vm.convert()
        #expect(vm.resultText == "2600.00")
        #expect(vm.errorMessage == nil)
    }

    @Test
    func invalidAmountShowsError() async throws {
        let fetch = FetchPairRateMock { _,_ in Rate(1.0) }
        let vm = ConvertViewModel(fetchRate: fetch, convertCurrency: .init())
        vm.amount = "-1"

        await vm.convert()
        #expect(vm.errorMessage != nil)
    }

    @Test
    func fetchErrorShowsMessage() async throws {
        enum Demo: Error { case boom }
        let fetch = FetchPairRateMock { _,_ in throw Demo.boom }
        let vm = ConvertViewModel(fetchRate: fetch, convertCurrency: .init())
        vm.amount = "10"

        await vm.convert()
        #expect(vm.errorMessage?.isEmpty == false)
    }
}
