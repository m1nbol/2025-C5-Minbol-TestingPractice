//
//  EXAuthStyle.swift
//  ExchangeKit
//
//  Created by BoMin Lee on 8/19/25.
//

import Foundation
import Moya

// 문서: https://www.exchangerate-api.com/docs/standard-requests
// 권장: 헤더 인증 (키가 URL 로그에 남지 않도록)
public enum EXAuthStyle { case header(name: String = "Authorization") }

public protocol EXTarget: TargetType {}

public enum EXConfig {
    // v6 베이스 URL (문서 기준)
    public static var baseURL = URL(string: "https://v6.exchangerate-api.com/v6")!
    // 앱/테스트에서 주입하거나, 환경변수/xcconfig/Info.plist 등에서 읽어와 주입
    public static var apiKey: String = "<PUT_YOUR_KEY_HERE>"
    public static var auth: EXAuthStyle = .header()
}

public extension EXTarget {
    var baseURL: URL { EXConfig.baseURL }

    // Content-Type 자동 관리(네가 준 방식 반영)
    var headers: [String: String]? {
        switch task {
        case .uploadMultipart:
            return ["Content-Type": "multipart/form-data"]
        case .requestJSONEncodable, .requestParameters, .requestCompositeParameters:
            return ["Content-Type": "application/json"]
        default:
            return ["Content-Type": "application/json"]
        }
    }
}
