//
//  ExchangeRateAPI.swift
//  ExchangeRateTesting
//
//  Created by BoMin Lee on 8/19/25.
//

import Foundation
import Moya

protocol EXTarget: TargetType {}

extension EXTarget {
    var baseURL: URL {
        switch EXConfig.authStyle {
        case .header:
            // 키를 경로에 넣지 않음 (로그 노출 줄이기)
            return EXConfig.baseURL
        case .urlPath:
            // 키를 경로에 포함시키는 스타일 (문서/요구 사항에 따라)
            // 예: https://v6.exchangerate-api.com/v6/<KEY>
            return EXConfig.baseURL.appendingPathComponent(EXConfig.apiKey)
        }
    }

    var headers: [String : String]? {
        switch EXConfig.authStyle {
        case .header:
            // Authorization: Bearer <KEY> (또는 apikey: <KEY>)
            return [
                "Content-Type": "application/json",
                EXConfig.headerName: "Bearer \(EXConfig.apiKey)"
            ]
        case .urlPath:
            // 키를 경로로 보냈으므로 헤더엔 굳이 넣지 않음
            return ["Content-Type": "application/json"]
        }
    }
}

enum ExchangeRateAPI {
    case pair(base: String, quote: String) // /pair/BASE/QUOTE
    case latest(base: String)              // /latest/BASE
}

extension ExchangeRateAPI: EXTarget {
    var path: String {
        switch self {
        case let .pair(base, quote):
            return "/pair/\(base)/\(quote)"
        case let .latest(base):
            return "/latest/\(base)"
        }
    }

    var method: Moya.Method { .get }
    var task: Task { .requestPlain }

    var sampleData: Data {
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
