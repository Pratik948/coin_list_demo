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
    }
}

// MARK: - Extensions -

extension CoinListPresenter: CoinListPresenterInterface {
}
