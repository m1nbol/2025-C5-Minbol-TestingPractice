//
//  ConvertView.swift
//  ExchangeRateTesting
//
//  Created by BoMin Lee on 8/19/25.
//

import SwiftUI

struct ConvertView: View {
    @ObservedObject var viewModel: ConvertViewModel

    var body: some View {
        NavigationStack {
            Form {
                Section("Currency Pair") {
                    TextField("Base (e.g. USD)", text: $viewModel.base)
                        .textInputAutocapitalization(.characters)
                        .accessibilityIdentifier("baseField")
                    TextField("Quote (e.g. KRW)", text: $viewModel.quote)
                        .textInputAutocapitalization(.characters)
                        .accessibilityIdentifier("quoteField")
                }
                Section("Amount") {
                    TextField("Amount", text: $viewModel.amount)
                        .keyboardType(.decimalPad)
                        .accessibilityIdentifier("amountField")
                }
                Section("Result") {
                    if viewModel.isLoading {
                        ProgressView()
                    } else {
                        Text(viewModel.resultText)
                            .font(.title3).bold()
                            .accessibilityIdentifier("resultText")
                    }
                    if let err = viewModel.errorMessage {
                        Text(err).foregroundStyle(.red)
                            .accessibilityIdentifier("errorText")
                    }
                }
                Button {
                    Task {
                        await viewModel.convert()
                    }
                    endEditing()
                } label: {
                    Text("Convert")
                        .accessibilityIdentifier("convertButton")
                }
            }
            .navigationTitle("Exchange Rate")
        }
    }
}

extension View {
    /// 빈 곳 탭 시 키보드 내리기 (resignFirstResponder)
    func endEditing() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil, from: nil, for: nil
        )
    }
}
