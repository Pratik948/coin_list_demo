//
//  CoinListFiltersInterfaces.swift
//  pratikcoinlistdemo
//
//  Created by Pratik Jamariya on 18/12/24.
//  Copyright (c) 2024 Pratik Jamariya. All rights reserved.
//

import UIKit

protocol CoinFilterDelegate: AnyObject {
    func didUpdateFilter(_ filter: CoinFilterModel?)
}

protocol CoinListFiltersWireframeInterface: WireframeInterface {
}

protocol CoinListFiltersViewInterface: ViewInterface {
}

protocol CoinListFiltersPresenterInterface: PresenterInterface {
    var currentFilter: CoinFilterModel? { get set }
    func applyFilter(filter: CoinFilterModel)
}

protocol CoinListFiltersInteractorInterface: InteractorInterface {
}
