//
//  ClientTests.swift
//  ExchangeKit
//
//  Created by BoMin Lee on 8/19/25.
//

import Testing
@testable import ExchangeKit

@Suite(.tags(.unit))
struct ClientTests {
    @Test
    func mockClientReturnsStub() async throws {
        let client = MockClient(stubbedRate: 1234.5)
        let rate = try await client.fetchRate(base: "USD", quote: "KRW")
        #expect(rate == 1234.5)
    }

    @Test
    func mockClientDefaultRate() async throws {
        let client = MockClient() // 기본 1.0
        let rate = try await client.fetchRate(base: "USD", quote: "KRW")
        #expect(rate == 1.0)
    }
}

@Suite(.tags(.integration))
struct LiveClientTests {
    @Test
    func fetchesLiveRate() async throws {
        let client = LiveClient()
        let rate = try await client.fetchRate(base: "USD", quote: "KRW")

        #expect(rate > 100.0, "비정상적으로 낮은 환율")
        #expect(rate < 3000.0, "비정상적으로 높은 환율")
    }
}
