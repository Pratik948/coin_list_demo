//
//  CoinListInteractorTests.swift
//  pratikcoinlistdemoTests
//
//  Created by Pratik Jamariya on 18/12/24.
//

import XCTest
@testable import pratikcoinlistdemo

final class CoinListInteractorTests: XCTestCase {
    var interactor: MockCoinListInteractorInterface!
    var mockPresenter: MockCoinListPresenterInterface!

    override func setUp() {
        super.setUp()
        mockPresenter = MockCoinListPresenterInterface(view: MockCoinListViewInterface())
        interactor = MockCoinListInteractorInterface()
        interactor.presenter = mockPresenter
    }

    override func tearDown() {
        interactor = nil
        mockPresenter = nil
        super.tearDown()
    }

    func testFetchCoinList() {
        // When
        interactor.fetchCoinList()

        // Then
        XCTAssertTrue(interactor.didFetchCoinList)
    }
}

// MARK: - Mock Classes
class MockCoinListPresenterInterface: CoinListPresenterInterface {
    var currentFilter: pratikcoinlistdemo.CoinFilterModel?
    var view: MockCoinListViewInterface
    init(view: MockCoinListViewInterface) {
        self.view = view
    }
    
    // Flag to track if the method was called
    var didFailToFetchCoinListCalled = false
    var didOpenFilterCalled = false
    var didApplyFilterCalled = false
    var didSearchCoinsCalled = false
    var didFetchCoinListCalled = false

    // Recorded parameters to verify test data
    var fetchedError: Error?
    var appliedFilter: CoinFilterModel?
    var searchQuery: String?

    // MARK: - Implementation of Protocol Functions
    func didFailToFetchCoinList(error: Error) {
        didFailToFetchCoinListCalled = true
        fetchedError = error
        view.showError(error.localizedDescription)
    }
    
    func openFilter() {
        didOpenFilterCalled = true
    }
    
    func applyFilter(filter: CoinFilterModel?) {
        didApplyFilterCalled = true
        appliedFilter = filter
    }
    
    func searchCoins(query: String) {
        didSearchCoinsCalled = true
        searchQuery = query
    }
    
    func didFetchCoinList(coins: [CoinModel]) {
        didFetchCoinListCalled = true
        view.showCoinList(coins)
    }
}
