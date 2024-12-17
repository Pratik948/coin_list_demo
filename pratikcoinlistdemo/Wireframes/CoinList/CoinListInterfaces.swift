//
//  CoinListInterfaces.swift
//  pratikcoinlistdemo
//
//  Created by Pratik Jamariya on 17/12/24.
//  Copyright (c) 2024 Pratik Jamariya. All rights reserved.
//

import UIKit

protocol CoinListWireframeInterface: WireframeInterface {
    func openFilterWireframe(delegate: CoinFilterDelegate, filter: CoinFilterModel?)
}

protocol CoinListViewInterface: ViewInterface {
    func showCoinList(_ coins: [CoinModel])
    func showError(_ error: String)
    func updateUI()
}

protocol CoinListPresenterInterface: PresenterInterface {
    var currentFilter: CoinFilterModel? { get set }
    func didFetchCoinList(coins: [CoinModel])
    func didFailToFetchCoinList(error: Error)
    func openFilter()
    func applyFilter(filter: CoinFilterModel?)
    func searchCoins(query: String)
}

protocol CoinListInteractorInterface: InteractorInterface {
    var presenter: CoinListPresenterInterface? { get set }
    func fetchCoinList()
}
