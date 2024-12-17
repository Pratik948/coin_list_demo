//
//  CoinListInteractor.swift
//  pratikcoinlistdemo
//
//  Created by Pratik Jamariya on 17/12/24.
//  Copyright (c) 2024 Pratik Jamariya. All rights reserved.
//

import Foundation

final class CoinListInteractor {
    weak var presenter: CoinListPresenterInterface?
}

// MARK: - Extensions -

extension CoinListInteractor: CoinListInteractorInterface {
    func fetchCoinList() {
        let url = "https://37656be98b8f42ae8348e4da3ee3193f.api.mockbin.io"
        
        NetworkManager.shared.request(urlString: url) { (result: Result<[CoinModel], NetworkError>) in
            switch result {
            case .success(let coins):
                self.presenter?.didFetchCoinList(coins: coins)
            case .failure(let error):
                self.presenter?.didFailToFetchCoinList(error: error)
            }
        }
    }

}
