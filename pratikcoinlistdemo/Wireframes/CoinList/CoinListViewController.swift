//
//  CoinListViewController.swift
//  pratikcoinlistdemo
//
//  Created by Pratik Jamariya on 17/12/24.
//  Copyright (c) 2024 Pratik Jamariya. All rights reserved.
//

import UIKit

enum CoinListSection: Hashable {
    case main
}

final class CoinListViewController: UIViewController {

    // MARK: - Public properties -

    var presenter: CoinListPresenterInterface!

    // MARK: - Private properties
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: UITableView.Style.insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    private lazy var searchBarController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.searchBar.delegate = self
        return controller
    }()
    
    var dataSource: UITableViewDiffableDataSource<CoinListSection, CoinModel>!

    var coins: [CoinModel] = []

    
    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Coins"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupTableView()
        setupSpinner()
        setupDataSource()
        applySnapshot()
        setupSearchBar()
        presenter.viewDidLoad()
    }
}

// MARK: - Extensions -

extension CoinListViewController: CoinListViewInterface {
    func showCoinList(_ coins: [CoinModel]) {
        self.coins = coins
        applySnapshot()
    }
    
    func showError(_ error: String) {
        print("Error: \(error)")
    }
    
    func showSpinner() {
        spinner.startAnimating()
    }
    
    func hideSpinner() {
        spinner.stopAnimating()
    }
    
    func setupSpinner() {
        view.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func setupTableView() {
        view.backgroundColor = UIColor.white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func setupDataSource() {
        dataSource = UITableViewDiffableDataSource<CoinListSection, CoinModel>(tableView: tableView) { tableView, indexPath, coin in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = "\(coin.name) (\(coin.symbol))"
            return cell
        }
    }
    
    func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<CoinListSection, CoinModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(coins, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    func setupSearchBar() {
        navigationItem.searchController = searchBarController
    }
}


extension CoinListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.searchCoins(query: searchText)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter.searchCoins(query: "")
    }
}
