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
        setupFilterButton()
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
    
    func updateUI() {
        setupFilterButton()
    }
}

extension CoinListViewController {
    
    // MARK: - Setup
    func setupSpinner() {
        view.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func setupTableView() {
        view.backgroundColor = UIColor.systemBackground
        tableView.register(CoinListTableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupDataSource() {
        dataSource = UITableViewDiffableDataSource<CoinListSection, CoinModel>(tableView: tableView) { tableView, indexPath, coin in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CoinListTableViewCell
            cell.configure(coin: coin)
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
    
    func setupFilterButton() {
        let filterBarButton = UIBarButtonItem(image: UIImage.init(systemName: "line.horizontal.3.decrease.circle\((presenter.currentFilter != nil ? ".fill" : ""))"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(filterAction))
        var barButtons: [UIBarButtonItem] = [filterBarButton]
        if let titleButton = filterTitle() {
            titleButton.addTarget(self, action: #selector(filterAction), for: .touchUpInside)
            barButtons.append(contentsOf: [
                UIBarButtonItem(systemItem: UIBarButtonItem.SystemItem.flexibleSpace),
                UIBarButtonItem(customView: titleButton),
                UIBarButtonItem(systemItem: UIBarButtonItem.SystemItem.flexibleSpace)
            ])
        }
        setToolbarItems(barButtons, animated: true)
        navigationController?.setToolbarHidden(false, animated: false)
    }
    
    func filterTitle() -> UIButton? {
        if (presenter.currentFilter != nil) {
            let button = UIButton(type: .custom)
            let heading = UILabel()
            heading.text = "Filtered by:"
            heading.textColor = UIColor.label
            heading.font = UIFont.systemFont(ofSize: 12)
            let title = UILabel()
            title.textColor = UIColor.link
            let filter = presenter.currentFilter!
            let includedText = [filter.isActive ? "Active" : nil, filter.isInActive ? "Inactive" : nil, filter.isNew ? "New" : nil].compactMap { $0 }.joined(separator: ", ")
            let onlyText = [filter.isCoin ? "Coin" : nil, filter.isToken ? "Token" : nil].compactMap { $0 }.joined(separator: ", ")
            title.text = "" + (!includedText.isEmpty ? "\(includedText)" : "") + (!onlyText.isEmpty ? "\(!includedText.isEmpty ? ", " : "")Only: \(onlyText)" : "")
            title.font = UIFont.systemFont(ofSize: 10)
            let stackView = UIStackView(arrangedSubviews: [heading, title])
            stackView.axis = .vertical
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.alignment = .center
            stackView.isUserInteractionEnabled = false
            button.addSubview(stackView)
            NSLayoutConstraint.activate([
                stackView.leadingAnchor.constraint(equalTo: button.leadingAnchor),
                stackView.trailingAnchor.constraint(equalTo: button.trailingAnchor),
                stackView.topAnchor.constraint(equalTo: button.topAnchor),
                stackView.bottomAnchor.constraint(equalTo: button.bottomAnchor)
            ])
            return button
        }
        return nil
    }
    
    @objc
    private func filterAction() {
        presenter.openFilter()
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
