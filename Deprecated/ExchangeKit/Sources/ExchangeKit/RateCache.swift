//
//  RateCache.swift
//  ExchangeKit
//
//  Created by BoMin Lee on 8/14/25.
//

import Foundation

public final class RateCache {
    public let ttl: TimeInterval
    private let now: () -> Date
    private var store: [String: (rate: Double, expiry: Date)] = [:]

    public init(ttl: TimeInterval, now: @escaping () -> Date = Date.init) {
        self.ttl = ttl
        self.now = now
    }

    public func store(pair: String, rate: Double) {
        store[pair] = (rate, now().addingTimeInterval(ttl))
    }

    public func lookup(pair: String) -> Double? {
        guard let entry = store[pair] else { return nil }
        if entry.expiry > now() {
            return entry.rate
        } else {
            store.removeValue(forKey: pair)
            return nil
        }
    }

    public func clear() { store.removeAll() }
}
