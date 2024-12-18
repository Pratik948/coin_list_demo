//
//  CoinListPresenterTests.swift
//  pratikcoinlistdemoTests
//
//  Created by Pratik Jamariya on 18/12/24.
//

import XCTest
@testable import pratikcoinlistdemo

final class CoinListPresenterInterfaceTests: XCTestCase {
    var presenter: MockCoinListPresenterInterface!
    var mockView: MockCoinListViewInterface!
    var mockInteractor: MockCoinListInteractorInterface!

    override func setUp() {
        super.setUp()
        mockView = MockCoinListViewInterface()
        mockInteractor = MockCoinListInteractorInterface()
        presenter = MockCoinListPresenterInterface(view: mockView)
    }

    override func tearDown() {
        presenter = nil
        mockView = nil
        mockInteractor = nil
        super.tearDown()
    }

    func testDidFetchCoinList() {
        // Given
        let coins = [CoinModel(name: "Ethereum", symbol: "ETH", isNew: false, isActive: true, type: "token")]

        // When
        presenter.didFetchCoinList(coins: coins)

        // Then
        XCTAssertTrue(mockView.didShowCoinList)
        XCTAssertEqual(mockView.displayedCoins, coins)
    }

    func testDidFailToFetchCoinList() {
        // Given
        let error = NSError(domain: "Test", code: 1, userInfo: nil)

        // When
        presenter.didFailToFetchCoinList(error: error)

        // Then
        XCTAssertTrue(mockView.didShowError)
    }

    func testOpenFilter() {
        // When
        presenter.openFilter()

        // Then
        XCTAssertTrue(presenter.didOpenFilterCalled)
    }
}

// MARK: - Mock Classes
class MockCoinListInteractorInterface: CoinListInteractorInterface {
    var presenter: (any pratikcoinlistdemo.CoinListPresenterInterface)?

    var didFetchCoinList = false
    func fetchCoinList() {
        didFetchCoinList = true
    }
    
}
