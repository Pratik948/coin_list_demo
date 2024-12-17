//
//  CoinListPresenter.swift
//  pratikcoinlistdemo
//
//  Created by Pratik Jamariya on 17/12/24.
//  Copyright (c) 2024 Pratik Jamariya. All rights reserved.
//

import Foundation

final class CoinListPresenter {

    // MARK: - Private properties -

    private unowned let view: CoinListViewInterface
    private let interactor: CoinListInteractorInterface
    private let wireframe: CoinListWireframeInterface

    // MARK: - Lifecycle -

    init(view: CoinListViewInterface, interactor: CoinListInteractorInterface, wireframe: CoinListWireframeInterface) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
        self.interactor.presenter = self
    }
}

// MARK: - Extensions -

extension CoinListPresenter: CoinListPresenterInterface {
    func viewDidLoad() {
        interactor.fetchCoinList()
        view.showSpinner()
    }
    
    func didFetchCoinList(coins: [CoinModel]) {
        DispatchQueue.main.async {
            self.view.showCoinList(coins)
            self.view.hideSpinner()
        }
    }
    
    func didFailToFetchCoinList(error: Error) {
        DispatchQueue.main.async {
            self.view.showError(error.localizedDescription)
            self.view.hideSpinner()
        }
    }
}
