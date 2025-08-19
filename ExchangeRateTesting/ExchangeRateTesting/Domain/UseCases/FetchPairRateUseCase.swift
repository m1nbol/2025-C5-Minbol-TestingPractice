//
//  FetchPairRateUseCase.swift
//  ExchangeRateTesting
//
//  Created by BoMin Lee on 8/19/25.
//

import Foundation

public protocol FetchPairRateUseCase {
    func callAsFunction(base: String, quote: String) async throws -> Rate
}

public struct FetchPairRateUseCaseImpl: FetchPairRateUseCase {
    private let repository: ExchangeRateRepository
    public init(repository: ExchangeRateRepository) { self.repository = repository }

    public func callAsFunction(base: String, quote: String) async throws -> Rate {
        try await repository.fetchRate(pair: .init(base: base, quote: quote))
    }
}
