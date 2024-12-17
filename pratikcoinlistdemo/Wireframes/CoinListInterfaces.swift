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
    func setupView()
}

protocol CoinListPresenterInterface: PresenterInterface {
}

protocol CoinListInteractorInterface: InteractorInterface {
}
