//
//  CoinListWireframe.swift
//  pratikcoinlistdemo
//
//  Created by Pratik Jamariya on 17/12/24.
//  Copyright (c) 2024 Pratik Jamariya. All rights reserved.
//

import UIKit

final class CoinListWireframe: Wireframe {

    // MARK: - Private properties -

    // MARK: - Module setup -

    init() {
        let moduleViewController = CoinListViewController()
        super.init(viewController: moduleViewController)

        let interactor = CoinListInteractor()
        let presenter = CoinListPresenter(view: moduleViewController, interactor: interactor, wireframe: self)
        moduleViewController.presenter = presenter
    }

}

// MARK: - Extensions -

extension CoinListWireframe: CoinListWireframeInterface {
}