//
//  CoinListViewTests.swift
//  pratikcoinlistdemoTests
//
//  Created by Pratik Jamariya on 18/12/24.
//

import XCTest
@testable import pratikcoinlistdemo

final class CoinListViewTests: XCTestCase {
    var mockView: MockCoinListViewInterface!

    override func setUp() {
        super.setUp()
        mockView = MockCoinListViewInterface()
    }

    override func tearDown() {
        mockView = nil
        super.tearDown()
    }

    func testShowCoinList() {
        // Given
        let coins = [CoinModel(name: "Bitcoin", symbol: "BTC", isNew: true, isActive: true, type: "coin")]

        // When
        mockView.showCoinList(coins)

        // Then
        XCTAssertTrue(mockView.didShowCoinList)
        XCTAssertEqual(mockView.displayedCoins, coins)
    }

    func testShowError() {
        // Given
        let errorMessage = "Error occurred"

        // When
        mockView.showError(errorMessage)

        // Then
        XCTAssertTrue(mockView.didShowError)
        XCTAssertEqual(mockView.errorMessage, errorMessage)
    }

    func testUpdateUI() {
        // When
        mockView.updateUI()

        // Then
        XCTAssertTrue(mockView.didUpdateUI)
    }
}

// MARK: - Mock Classes
class MockCoinListViewInterface: CoinListViewInterface {
    var didShowCoinList = false
    var displayedCoins: [CoinModel]?
    var didShowError = false
    var errorMessage: String?
    var didUpdateUI = false

    func showCoinList(_ coins: [CoinModel]) {
        didShowCoinList = true
        displayedCoins = coins
    }

    func showError(_ error: String) {
        didShowError = true
        errorMessage = error
    }

    func updateUI() {
        didUpdateUI = true
    }
}
