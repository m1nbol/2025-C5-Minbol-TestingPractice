//
//  MoyaProvider+Async.swift
//  ExchangeRateTesting
//
//  Created by BoMin Lee on 8/19/25.
//

import Foundation
import Moya

let exLogger = NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))
let exProvider = MoyaProvider<ExchangeRateAPI>(plugins: [exLogger])

extension MoyaProvider {
    func requestAsync(_ target: Target) async throws -> Response {
        try await withCheckedThrowingContinuation { cont in
            self.request(target) { result in
                switch result {
                case .success(let res): cont.resume(returning: res)
                case .failure(let err): cont.resume(throwing: err)
                }
            }
        }
    }
}
