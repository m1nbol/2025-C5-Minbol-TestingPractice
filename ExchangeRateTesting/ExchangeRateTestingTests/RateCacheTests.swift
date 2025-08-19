//
//  RateCacheTests.swift
//  ExchangeRateTesting
//
//  Created by BoMin Lee on 8/19/25.
//

import Foundation
import Testing
@testable import ExchangeRateTesting

@Suite(.tags(.unit))
struct RateCacheTests {
    @Test
    func storeAndHitBeforeTTL() {
        var base = Date(timeIntervalSince1970: 1_700_000_000)
        let clock = Clock(now: { base })
        let cache = RateCache(ttl: 60, clock: clock)

        cache.store(pairKey: "USDKRW", rate: 1350)
        #expect(cache.lookup(pairKey: "USDKRW") == 1350)

        // +59초 → 여전히 유효
        base.addTimeInterval(59)
        #expect(cache.lookup(pairKey: "USDKRW") == 1350)
    }

    @Test
    func expireAfterTTL() {
        var base = Date(timeIntervalSince1970: 1_700_000_000)
        let clock = Clock(now: { base })
        let cache = RateCache(ttl: 60, clock: clock)

        cache.store(pairKey: "USDKRW", rate: 1350)

        // +61초 → 만료
        base.addTimeInterval(61)
        #expect(cache.lookup(pairKey: "USDKRW") == nil)
    }
}
