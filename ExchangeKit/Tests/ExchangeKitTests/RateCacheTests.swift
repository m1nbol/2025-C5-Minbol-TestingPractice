//
//  RateCacheTests.swift
//  ExchangeKit
//
//  Created by BoMin Lee on 8/18/25.
//

import Foundation
import Testing

@testable import ExchangeKit

/// Unit Test
@Suite(.tags(.unit))
struct RateCacheTests {
    /// 저장 직후 조회
    @Test(.timeLimit(.minutes(1)))
    func storeAndLookup() {
        let base = Date(timeIntervalSince1970: 1_700_000_000) // 기준 시간
        let now: () -> Date = { base } // 현재 시각 반환하는 클로저
        let sut = RateCache(ttl: 60, now: now) // TTL 60초짜리 캐시. now를 주입해서 '현재'를 통제 가능.

        sut.store(pair: "USDKRW", rate: 1350) // 저장
        #expect(sut.lookup(pair: "USDKRW") == 1350) // 즉시 조회
    }

    /// TTL 만료 시나리오(시간을 인위적으로 진행)
    @Test(.timeLimit(.minutes(1)))
    func expiry() {
        var base = Date(timeIntervalSince1970: 1_700_000_000)
        func tick(_ sec: TimeInterval) { base.addTimeInterval(sec) }
        let now: () -> Date = { base }

        /// 저장
        let sut = RateCache(ttl: 60, now: now)
        sut.store(pair: "USDKRW", rate: 1350)

        /// +30초 → TTL(60초) 이내이므로 아직 유효
        tick(30)
        #expect(sut.lookup(pair: "USDKRW") == 1350, "TTL 전에는 살아있어야 함")

        /// 추가로 +31초 (총 +61초) → TTL 초과 → 만료되어 nil이어야 함
        tick(31) // 총 +61초
        #expect(sut.lookup(pair: "USDKRW") == nil, "TTL 초과 후에는 만료되어야 함")
    }
}
