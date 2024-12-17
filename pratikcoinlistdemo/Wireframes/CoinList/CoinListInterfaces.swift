//
//  CoinListInterfaces.swift
//  pratikcoinlistdemo
//
//  Created by Pratik Jamariya on 17/12/24.
//  Copyright (c) 2024 Pratik Jamariya. All rights reserved.
//

import UIKit

protocol CoinListWireframeInterface: WireframeInterface {
}

protocol CoinListViewInterface: ViewInterface {
    func showCoinList(_ coins: [CoinModel])
    func showError(_ error: String)
}

protocol CoinListPresenterInterface: PresenterInterface {
    func didFetchCoinList(coins: [CoinModel])
    func didFailToFetchCoinList(error: Error)
    func searchCoins(query: String)
}

protocol CoinListInteractorInterface: InteractorInterface {
    var presenter: CoinListPresenterInterface? { get set }
    func fetchCoinList()
}
