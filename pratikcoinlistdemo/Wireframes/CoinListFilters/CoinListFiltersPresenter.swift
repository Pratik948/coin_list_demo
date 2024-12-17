//
//  CoinListFiltersPresenter.swift
//  pratikcoinlistdemo
//
//  Created by Pratik Jamariya on 18/12/24.
//  Copyright (c) 2024 Pratik Jamariya. All rights reserved.
//

import Foundation

final class CoinListFiltersPresenter {

    var currentFilter: CoinFilterModel?
    // MARK: - Private properties -

    private unowned let view: CoinListFiltersViewInterface
    private let interactor: CoinListFiltersInteractorInterface
    private let wireframe: CoinListFiltersWireframeInterface
    private weak var delegate: (any CoinFilterDelegate)?

    // MARK: - Lifecycle -

    init(view: CoinListFiltersViewInterface, interactor: CoinListFiltersInteractorInterface, wireframe: CoinListFiltersWireframeInterface, delegate: CoinFilterDelegate, filter: CoinFilterModel? = nil) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
        self.delegate = delegate
        self.currentFilter = filter
    }
}

// MARK: - Extensions -

extension CoinListFiltersPresenter: CoinListFiltersPresenterInterface {
    func applyFilter(filter: CoinFilterModel) {
        delegate?.didUpdateFilter(filter.isAllDisabled ? nil : filter)
        wireframe.dismiss(animated: true)
    }
}
