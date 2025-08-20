//
//  ExchangeRateTestingUITests.swift
//  ExchangeRateTestingUITests
//
//  Created by BoMin Lee on 8/19/25.
//

import XCTest

final class ExchangeRateTestingUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testConvertSuccessStubbed() {
        let app = XCUIApplication()
        app.launchEnvironment["UITESTS_STUB"] = "1"  // ✅ 스텁 모드로 실행
        app.launch()
        
        // 1) 필드 입력
        let base = app.textFields["baseField"]
        base.tap()
        base.typeText("USD")
        
        let quote = app.textFields["quoteField"]
        quote.tap()
        quote.typeText("KRW")
        
        let amount = app.textFields["amountField"]
        amount.tap()
        amount.typeText("100")
        
        app.swipeDown()
        
        // 2) convert 버튼 누름
        app.buttons["convertButton"].tap()
        
        // 4) 결과 확인: 샘플 JSON의 conversion_rate = 1234.56 → 100 * 1234.56 = 123456.00
        let result = app.staticTexts["resultText"]
        XCTAssertTrue(result.waitForExistence(timeout: 3))
        XCTAssertEqual(result.label, "123456.00")
    }
    
    func testConvertInvalidAmountShowsError() {
        let app = XCUIApplication()
        app.launchEnvironment["UITESTS_STUB"] = "1"
        app.launch()

        app.textFields["amountField"].tap()
        app.textFields["amountField"].typeText("-1")  // 음수 → 에러

        app.swipeDown()
        app.buttons["convertButton"].tap()

        let err = app.staticTexts["errorText"]
        XCTAssertTrue(err.waitForExistence(timeout: 2))
        XCTAssertFalse(err.label.isEmpty)
    }

    @MainActor
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
