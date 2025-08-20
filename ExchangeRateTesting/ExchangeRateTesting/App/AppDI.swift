//
//  AppDI.swift
//  ExchangeRateTesting
//
//  Created by BoMin Lee on 8/19/25.
//

import Foundation
import Moya

@MainActor
final class AppDI: ObservableObject {
    @Published var convertVM: ConvertViewModel

    private init(convertVM: ConvertViewModel) {
        self.convertVM = convertVM
    }
    static func bootstrap() -> AppDI {
        // DI 조립 그대로
        EXConfig.baseURL    = URL(string: AppConfig.baseURLString)!
        EXConfig.apiKey     = AppConfig.apiKey
        EXConfig.headerName = AppConfig.headerName
        EXConfig.authStyle  = .header

        let isUITestStub = ProcessInfo.processInfo.environment["UITESTS_STUB"] == "1"

        let provider: MoyaProvider<ExchangeRateAPI> = {
            if isUITestStub {
                // 즉시 스텁: ExchangeRateAPI.sampleData 사용
                return MoyaProvider<ExchangeRateAPI>(
                    stubClosure: MoyaProvider.immediatelyStub
                )
            } else {
                return MoyaProvider<ExchangeRateAPI>(
                    plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))]
                )
            }
        }()
        
//        let provider = MoyaProvider<ExchangeRateAPI>(
//            plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))]
//        )

        let cache   = RateCache(ttl: 60)
        let repo    = ExchangeRateRepositoryImpl(provider: provider, cache: cache)
        let fetch   = FetchPairRateUseCaseImpl(repository: repo)
        let convert = ConvertCurrencyUseCase(feePercent: 0.0)

        let vm = ConvertViewModel(fetchRate: fetch, convertCurrency: convert)
        return AppDI(convertVM: vm)
    }
}
