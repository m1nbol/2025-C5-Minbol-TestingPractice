//
//  Clock.swift
//  ExchangeRateTesting
//
//  Created by BoMin Lee on 8/19/25.
//

import Foundation

struct Clock {
    var now: () -> Date = Date.init
    static let live = Clock()
}
