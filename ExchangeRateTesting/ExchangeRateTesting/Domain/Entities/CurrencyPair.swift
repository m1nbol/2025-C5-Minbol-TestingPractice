//
//  CurrencyPair.swift
//  ExchangeRateTesting
//
//  Created by BoMin Lee on 8/19/25.
//

import Foundation

public struct CurrencyPair: Hashable {
    public let base: String
    public let quote: String
    public init(base: String, quote: String) {
        self.base = base.uppercased()
        self.quote = quote.uppercased()
    }

    public var key: String { base + quote }
}
