//
//  ExchangeRateMapper.swift
//  ExchangeRateTesting
//
//  Created by BoMin Lee on 8/19/25.
//

import Foundation

enum ExchangeRateMapper {
    static func toDomain(from dto: PairDTO) throws -> Rate {
        guard dto.result == "success" else { throw AppError.server("API result: \(dto.result)") }
        return Rate(dto.conversion_rate)
    }

    static func toDomain(from dto: LatestDTO, quote: String) throws -> Rate {
        guard dto.result == "success" else { throw AppError.server("API result: \(dto.result)") }
        guard let v = dto.conversion_rates[quote.uppercased()] else {
            throw AppError.server("Missing rate for \(quote)")
        }
        return Rate(v)
    }
}
