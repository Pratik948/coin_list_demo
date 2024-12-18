//
//  pratikcoinlistdemoTests.swift
//  pratikcoinlistdemoTests
//
//  Created by Pratik Jamariya on 18/12/24.
//

import XCTest
@testable import pratikcoinlistdemo

final class pratikcoinlistdemoTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func testApplyFilterCalledWithCorrectFilter() {
        // Given
        let mockPresenter = MockCoinListPresenterInterface(view: MockCoinListViewInterface())
        let expectedFilter = CoinFilterModel(isActive: true, isInActive: false, isNew: true, isToken: false, isCoin: true)

        // When
        mockPresenter.applyFilter(filter: expectedFilter)

        // Then
        XCTAssertTrue(mockPresenter.didApplyFilterCalled, "applyFilter should be called")
        XCTAssertEqual(mockPresenter.appliedFilter, expectedFilter, "Filter passed to applyFilter should match the expected filter")
    }
    
    func testSearchCoinsCalledWithCorrectQuery() {
        // Given
        let mockPresenter = MockCoinListPresenterInterface(view: MockCoinListViewInterface())
        let expectedQuery = "Bitcoin"

        // When
        mockPresenter.searchCoins(query: expectedQuery)

        // Then
        XCTAssertTrue(mockPresenter.didSearchCoinsCalled, "searchCoins should be called")
        XCTAssertEqual(mockPresenter.searchQuery, expectedQuery, "Search query passed should match the expected query")
    }

}
