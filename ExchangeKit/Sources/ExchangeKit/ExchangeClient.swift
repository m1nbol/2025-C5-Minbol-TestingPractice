//
//  ExchangeClient.swift
//  ExchangeKit
//
//  Created by BoMin Lee on 8/14/25.
//

import Foundation

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

// 나중 Step에서 구현할 실제 네트워크 클라이언트 뼈대
public struct LiveClient: ExchangeClient {
    public init() {}
    public func fetchRate(base: String, quote: String) async throws -> Double {
        // TODO: Step 3에서 URLSession으로 구현
        throw URLError(.unsupportedURL)
    }
}
