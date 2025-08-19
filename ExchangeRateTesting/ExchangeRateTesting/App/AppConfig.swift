//
//  AppConfig.swift
//  ExchangeRateTesting
//
//  Created by BoMin Lee on 8/19/25.
//

import Foundation

enum AppConfig {
    // 스킴 환경변수 > Info.plist(User-Defined) > 기본값 순
    static var baseURLString: String = {
        if let v = ProcessInfo.processInfo.environment["EX_BASE_URL"] { return v }
        if let v = Bundle.main.object(forInfoDictionaryKey: "EX_BASE_URL") as? String { return v }
        return "https://v6.exchangerate-api.com/v6"
    }()

    static var apiKey: String = {
        if let v = ProcessInfo.processInfo.environment["EX_API_KEY"] { return v }
        if let v = Bundle.main.object(forInfoDictionaryKey: "EX_API_KEY") as? String { return v }
        return "114cd2b00b3690592a77f2b1"
    }()

    // 인증 헤더 이름(서비스 문서에 맞춰 조정)
    static var headerName: String = {
        if let v = ProcessInfo.processInfo.environment["EX_AUTH_HEADER"] { return v }
        if let v = Bundle.main.object(forInfoDictionaryKey: "EX_AUTH_HEADER") as? String { return v }
        return "Authorization" // 기본값: Bearer 토큰
    }()
}
