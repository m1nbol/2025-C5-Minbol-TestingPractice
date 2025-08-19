//
//  AppError.swift
//  ExchangeRateTesting
//
//  Created by BoMin Lee on 8/19/25.
//

import Foundation

enum AppError: Error, LocalizedError {
    case network(statusCode: Int)
    case server(String)
    case decoding
    case invalidInput(String)
    case unknown(Error)

    var errorDescription: String? {
        switch self {
        case .network(let code): return "Network error (\(code))"
        case .server(let msg):   return "Server error: \(msg)"
        case .decoding:          return "Failed to decode response"
        case .invalidInput(let m): return "Invalid input: \(m)"
        case .unknown(let e):    return "Unknown error: \(e.localizedDescription)"
        }
    }
}
