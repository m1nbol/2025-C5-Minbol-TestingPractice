//
//  ExchangeAPI.swift
//  ExchangeKit
//
//  Created by BoMin Lee on 8/19/25.
//

import Foundation
import Moya

public enum ExchangeRateAPI {
    // 문서의 "pair" 엔드포인트 (응답: conversion_rate)
    case pair(base: String, quote: String)
    // 문서의 "latest" 엔드포인트 (응답: conversion_rates 딕셔너리)
    case latest(base: String)
}

extension ExchangeRateAPI: EXTarget {
    public var path: String {
        switch self {
        case let .pair(base, quote):
            return "/pair/\(base)/\(quote)"
        case let .latest(base):
            return "/latest/\(base)"
        }
    }

    public var method: Moya.Method { .get }

    // GET이라 바디/파라미터 없음 (문서 기준)
    public var task: Task { .requestPlain }

    // 헤더 인증: Authorization: Bearer <KEY>
    public var headers: [String : String]? {
        var h = (self as EXTarget).headers ?? [:]
        switch EXConfig.auth {
        case let .header(name):
            h[name] = "Bearer \(EXConfig.apiKey)"
        }
        return h
    }

    // sampleData: 네가 강조한 "미리 UI/테스트 진행" 패턴 반영
    public var sampleData: Data {
        switch self {
        case let .pair(base, quote):
            let body: [String: Any] = [
                "result": "success",
                "base_code": base,
                "target_code": quote,
                "conversion_rate": 1234.56
            ]
            return try! JSONSerialization.data(withJSONObject: body)
        case let .latest(base):
            let body: [String: Any] = [
                "result": "success",
                "base_code": base,
                "conversion_rates": ["KRW": 1350.0, "EUR": 0.92]
            ]
            return try! JSONSerialization.data(withJSONObject: body)
        }
    }
}
