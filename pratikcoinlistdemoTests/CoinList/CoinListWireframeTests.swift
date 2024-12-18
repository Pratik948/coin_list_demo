//
//  CoinListWireframeTests.swift
//  pratikcoinlistdemoTests
//
//  Created by Pratik Jamariya on 18/12/24.
//

import XCTest
@testable import pratikcoinlistdemo

final class CoinListWireframeTests: XCTestCase {
    var wireframe: CoinListWireframeInterface!
    var mockDelegate: MockCoinFilterDelegate!
    var mockView: MockCoinListViewInterface!

    override func setUp() {
        super.setUp()
        wireframe = MockCoinListWireframe()
        mockDelegate = MockCoinFilterDelegate()
        mockView = MockCoinListViewInterface()
    }

    override func tearDown() {
        wireframe = nil
        mockDelegate = nil
        mockView = nil
        super.tearDown()
    }

    func testOpenFilterWireframe() {
        // When
        wireframe.openFilterWireframe(delegate: mockDelegate, filter: nil)

        // Then
        XCTAssertTrue(mockDelegate.didCallFilter)
    }
}

// MARK: - Mock Classes
class MockCoinListWireframe: CoinListWireframeInterface {
    var didPopFromNavigationController = false
    func popFromNavigationController(animated: Bool) {
        didPopFromNavigationController = true
    }
    
    var didDismiss = false
    func dismiss(animated: Bool) {
        didDismiss = true
    }
    
    var didOpenFilterWireframe = false

    func openFilterWireframe(delegate: CoinFilterDelegate, filter: CoinFilterModel?) {
        didOpenFilterWireframe = true
        delegate.didUpdateFilter(filter)
    }
}

class MockCoinFilterDelegate: CoinFilterDelegate {
    var didCallFilter = false

    func didUpdateFilter(_ filter: CoinFilterModel?) {
        didCallFilter = true
    }
}
