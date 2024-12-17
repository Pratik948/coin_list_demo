//
//  CoinListFiltersWireframe.swift
//  pratikcoinlistdemo
//
//  Created by Pratik Jamariya on 18/12/24.
//  Copyright (c) 2024 Pratik Jamariya. All rights reserved.
//

import UIKit

final class CoinListFiltersWireframe: Wireframe {

    // MARK: - Private properties -

    // MARK: - Module setup -

    init(delegate: CoinFilterDelegate, filter: CoinFilterModel? = nil) {
        let moduleViewController = CoinListFiltersViewController()
        super.init(viewController: moduleViewController)

        let interactor = CoinListFiltersInteractor()
        let presenter = CoinListFiltersPresenter(view: moduleViewController, interactor: interactor, wireframe: self, delegate: delegate, filter: filter)
        moduleViewController.presenter = presenter
    }

}

// MARK: - Extensions -

extension CoinListFiltersWireframe: CoinListFiltersWireframeInterface {
}
