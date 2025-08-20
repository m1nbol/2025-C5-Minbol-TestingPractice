//
//  ConvertViewModel.swift
//  ExchangeRateTesting
//
//  Created by BoMin Lee on 8/19/25.
//

import Foundation

@MainActor
final class ConvertViewModel: ObservableObject {
    @Published var base: String = ""
    @Published var quote: String = ""
    @Published var amount: String = ""
    @Published var resultText: String = "-"
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let fetchRate: FetchPairRateUseCase
    private let convertCurrency: ConvertCurrencyUseCase

    init(fetchRate: FetchPairRateUseCase, convertCurrency: ConvertCurrencyUseCase) {
        self.fetchRate = fetchRate
        self.convertCurrency = convertCurrency
    }

    func convert() async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        guard let amt = Double(amount), amt >= 0 else {
            errorMessage = "금액을 올바르게 입력하세요."
            return
        }

        do {
            let rate = try await fetchRate(base: base, quote: quote)
            let out = convertCurrency(amount: amt, rate: rate, rounding: .toCents)
            resultText = String(format: "%.2f", out)
        } catch let e as AppError {
            errorMessage = e.localizedDescription
        } catch {
            errorMessage = AppError.unknown(error).localizedDescription
        }
    }
}
