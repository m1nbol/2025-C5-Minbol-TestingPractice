//
//  EXConfig.swift
//  ExchangeRateTesting
//
//  Created by BoMin Lee on 8/19/25.
//

import Foundation

/// Data 레이어가 참조하는 "현재 세션 설정"
enum EXAuthStyle {
    case header      // Authorization: Bearer <KEY>
    case urlPath     // baseURL 뒤 경로에 키 포함: /v6/<KEY>/...
}

enum EXConfig {
    // AppDI에서 주입됨
    static var baseURL: URL = URL(string: "https://v6.exchangerate-api.com/v6")!
    static var apiKey: String = "114cd2b00b3690592a77f2b1"
    static var headerName: String = "Authorization"
    static var authStyle: EXAuthStyle = .header
}
