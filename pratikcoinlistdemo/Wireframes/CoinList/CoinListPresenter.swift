//
//  CoinListPresenter.swift
//  pratikcoinlistdemo
//
//  Created by Pratik Jamariya on 17/12/24.
//  Copyright (c) 2024 Pratik Jamariya. All rights reserved.
//

import Foundation

final class CoinListPresenter {

    var currentFilter: CoinFilterModel? // Holds the current filter
    
    // MARK: - Private properties -

    private unowned let view: CoinListViewInterface
    private let interactor: CoinListInteractorInterface
    private let wireframe: CoinListWireframeInterface

    private var allCoins: [CoinModel] = []       // Original full dataset
    private var filteredCoins: [CoinModel] = []  // Filtered list
    private var currentSearchQuery: String = ""  // Holds the current search query

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
        allCoins = coins
        filteredCoins = coins
        applyFilter(filter: currentFilter)
    }
    
    func didFailToFetchCoinList(error: Error) {
        DispatchQueue.main.async {
            self.view.showError(error.localizedDescription)
            self.view.hideSpinner()
        }
    }
    
    func openFilter() {
        wireframe.openFilterWireframe(delegate: self, filter: currentFilter)
    }
    
    func applyFilter(filter: CoinFilterModel?) {
        currentFilter = filter
        
        if (filter != nil) {
            // Filter coins based on the filter model
            filteredCoins = allCoins.filter {
                let typeFilterActive = filter!.isCoin || filter!.isToken
                var typeMatches = false
                if (typeFilterActive && ((filter!.isCoin ? $0.type.lowercased() == "coin" : false) || (filter!.isToken ? $0.type.lowercased() == "token" : false))) {
                    typeMatches = true
                }
                let filterActive = filter!.isActive || filter!.isInActive || filter!.isNew
                var filterMatches = false
                if (filterActive && ((filter!.isNew && $0.isNew) || (filter!.isActive && $0.isActive) || (filter!.isInActive && !$0.isActive))) {
                    filterMatches = true
                }
                return typeFilterActive ? typeMatches && (filterActive ? filterMatches : true) : (filterActive ? filterMatches : true)
            }
        }
        else {
            filteredCoins = allCoins
        }
        
        // Apply search query on top of filters
        searchCoins(query: currentSearchQuery)
    }
    
    func searchCoins(query: String) {
        currentSearchQuery = query
        let result = query.isEmpty ? filteredCoins : filteredCoins.filter {
            $0.name.lowercased().contains(query.lowercased()) ||
            $0.symbol.lowercased().contains(query.lowercased())
        }
        showCoinList(coins: result)
    }
    
    private func showCoinList(coins:[CoinModel]) {
        DispatchQueue.main.async {
            self.view.showCoinList(coins)
            self.view.hideSpinner()
        }
    }
}

extension CoinListPresenter: CoinFilterDelegate {
    func didUpdateFilter(_ filter: CoinFilterModel?) {
        applyFilter(filter: filter)
        view.updateUI()
    }
}
