//
//  ExchangeClient.swift
//  ExchangeKit
//
//  Created by BoMin Lee on 8/14/25.
//

import Foundation
import Moya

public protocol ExchangeClient {
    func fetchRate(base: String, quote: String) async throws -> Double
}

public struct MockClient: ExchangeClient {
    public var stubbedRate: Double
    public init(stubbedRate: Double = 1.0) { self.stubbedRate = stubbedRate }
    public func fetchRate(base: String, quote: String) async throws -> Double {
        // 네트워크 없이 즉시 반환하는 목 더블
        stubbedRate
    }
}

public struct LiveClient: ExchangeClient {
    private let provider = MoyaProvider<ExchangeAPI>()
    public init() {}

    public func fetchRate(base: String, quote: String) async throws -> Double {
        let response = try await provider.request(.latest(base: base, symbols: quote))

        struct Response: Decodable {
            let conversion_rates: [String: Double]
        }

        let decoded = try JSONDecoder().decode(Response.self, from: response.data)
        guard let rate = decoded.conversion_rates[quote] else {
            throw URLError(.badServerResponse)
        }
        return rate
    }
}
