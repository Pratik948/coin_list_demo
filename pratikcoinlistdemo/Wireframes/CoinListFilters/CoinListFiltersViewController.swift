//
//  CoinListFiltersViewController.swift
//  pratikcoinlistdemo
//
//  Created by Pratik Jamariya on 18/12/24.
//  Copyright (c) 2024 Pratik Jamariya. All rights reserved.
//

import UIKit

enum CoinListFilterSections: Int, CaseIterable {
    case include
    case type
    var title: String {
        switch self {
        case .include: return "Include"
        case .type: return "Type Only"
        }
    }

}

final class CoinListFiltersViewController: UIViewController {
    
    // MARK: - Filter Option
    struct FilterOption: Hashable {
        let id = UUID()
        let title: String
        let keyPath: WritableKeyPath<CoinFilterModel, Bool>
        let icon: String
    }
    
    class CoinFilterSectionHeaderDataSource: UITableViewDiffableDataSource<CoinListFilterSections, FilterOption> {
        override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            let section = self.snapshot().sectionIdentifiers[section]
            return section.title
        }
    }

    // MARK: - Public properties -

    var presenter: CoinListFiltersPresenterInterface!
    
    // MARK: Private properties
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: UITableView.Style.insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var dataSource: CoinFilterSectionHeaderDataSource!

    private var filterModel: CoinFilterModel = CoinFilterModel()

    // MARK: - Filter Options
    private var filterOptions: [CoinListFilterSections: [FilterOption]] = [:]

    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Filters"
        view.backgroundColor = .systemBackground
        filterModel = presenter.currentFilter ?? CoinFilterModel()
        setupTableView()
        setupFilterOptions()
        setApplyButton()
        setupDataSource()
        applySnapshot()
    }

    // MARK: - Setup Filter Options
    private func setupFilterOptions() {
        filterOptions = [
            .include: [
                FilterOption(title: "Active", keyPath: \.isActive, icon: "checkmark.circle"),
                FilterOption(title: "Inactive", keyPath: \.isInActive, icon: "xmark.circle"),
                FilterOption(title: "New", keyPath: \.isNew, icon: "star.circle")
            ],
            .type: [
                FilterOption(title: "Coin", keyPath: \.isCoin, icon: "bitcoinsign"),
                FilterOption(title: "Token", keyPath: \.isToken, icon: "cube")
            ]
        ]
    }
    
    // MARK: - Setup TableView
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    // MARK: - Setup Diffable Data Source
    private func setupDataSource() {
        dataSource = CoinFilterSectionHeaderDataSource(tableView: tableView) { tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
            var content = cell.defaultContentConfiguration()
            content.text = item.title
            content.image = UIImage(systemName: item.icon)
            content.imageProperties.tintColor = .systemBlue
            cell.contentConfiguration = content
            // Set checkmark if option is selected
            let isSelected = self.filterModel[keyPath: item.keyPath]
            cell.accessoryType = isSelected ? .checkmark : .none
            return cell
        }
        
        tableView.delegate = self
    }
    
    // MARK: - Apply Snapshot
    private func applySnapshot() {
        setupFilterOptions()
        var snapshot = NSDiffableDataSourceSnapshot<CoinListFilterSections, FilterOption>()
        
        snapshot.appendSections([.include, .type])
        snapshot.appendItems(filterOptions[.include] ?? [], toSection: .include)
        snapshot.appendItems(filterOptions[.type] ?? [], toSection: .type)

        dataSource.apply(snapshot, animatingDifferences: false)
    }

    // MARK: - Apply Filter
    private func setApplyButton() {
        let barButton = UIBarButtonItem(systemItem: .done, primaryAction: UIAction(handler: { action in
            self.applyFilter()
        }))
        navigationItem.setRightBarButton(barButton, animated: false)
        let resetButton = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(resetFilter))
        navigationItem.setLeftBarButton(resetButton, animated: false)
    }
    @objc
    private func resetFilter() {
        filterModel = CoinFilterModel()
        applyFilter()
    }
    @objc
    private func applyFilter() {
        // Notify delegate of the updated filter
        presenter.applyFilter(filter: filterModel)
    }
    
}


// MARK: - UITableViewDelegate
extension CoinListFiltersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Get the section and filter option
        guard let section = CoinListFilterSections(rawValue: indexPath.section),
              let option = filterOptions[section]?[indexPath.row] else { return }
        
        // Toggle the value in the filter model
        filterModel[keyPath: option.keyPath].toggle()
        
        // Update the snapshot to refresh the UI
        applySnapshot()
    }
}

// MARK: - Extensions -

extension CoinListFiltersViewController: CoinListFiltersViewInterface {
}
