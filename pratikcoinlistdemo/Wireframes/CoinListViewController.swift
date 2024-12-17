//
//  CoinListViewController.swift
//  pratikcoinlistdemo
//
//  Created by Pratik Jamariya on 17/12/24.
//  Copyright (c) 2024 Pratik Jamariya. All rights reserved.
//

import UIKit

final class CoinListViewController: UIViewController {

    // MARK: - Public properties -

    var presenter: CoinListPresenterInterface!

    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: - Extensions -

extension CoinListViewController: CoinListViewInterface {
    func setupView() {
        view.backgroundColor = UIColor.white
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false;
        view.addSubview(label)
        label.text = "Hello world!"
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
