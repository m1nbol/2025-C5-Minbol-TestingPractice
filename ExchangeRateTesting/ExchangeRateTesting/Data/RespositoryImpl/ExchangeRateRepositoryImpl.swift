//
//  ExchangeRateRepositoryImpl.swift
//  ExchangeRateTesting
//
//  Created by BoMin Lee on 8/19/25.
//

import Foundation
import Moya

struct ExchangeRateRepositoryImpl: ExchangeRateRepository {
    private let provider: MoyaProvider<ExchangeRateAPI>
    private let cache: RateCache

    init(provider: MoyaProvider<ExchangeRateAPI>, cache: RateCache) {
        self.provider = provider
        self.cache = cache
    }

    func fetchRate(pair: CurrencyPair) async throws -> Rate {
        // 1) 캐시
        if let cached = cache.lookup(pairKey: pair.key) {
            return Rate(cached)
        }

        // 2) 네트워크 (pair 엔드포인트 사용)
        let res = try await provider.requestAsync(.pair(base: pair.base, quote: pair.quote))
        guard (200..<300).contains(res.statusCode) else {
            throw AppError.network(statusCode: res.statusCode)
        }

        let dto = try JSONDecoder().decode(PairDTO.self, from: res.data)
        let rate = try ExchangeRateMapper.toDomain(from: dto)

        // 3) 캐시 저장
        cache.store(pairKey: pair.key, rate: rate.value)
        return rate
    }
}
