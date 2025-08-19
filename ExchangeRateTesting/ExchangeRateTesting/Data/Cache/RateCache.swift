//
//  RateCache.swift
//  ExchangeRateTesting
//
//  Created by BoMin Lee on 8/19/25.
//

import Foundation

final class RateCache {
    private let ttl: TimeInterval
    private let clock: Clock
    private var store: [String: (rate: Double, expiry: Date)] = [:]

    init(ttl: TimeInterval = 60, clock: Clock = .live) {
        self.ttl = ttl
        self.clock = clock
    }

    func store(pairKey: String, rate: Double) {
        let expiry = clock.now().addingTimeInterval(ttl)
        store[pairKey] = (rate, expiry)
    }

    func lookup(pairKey: String) -> Double? {
        guard let entry = store[pairKey] else { return nil }
        if entry.expiry > clock.now() { return entry.rate }
        store.removeValue(forKey: pairKey)
        return nil
    }

    func clear() { store.removeAll() }
}
