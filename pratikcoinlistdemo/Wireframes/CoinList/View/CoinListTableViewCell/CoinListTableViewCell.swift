//
//  CoinListTableViewCell.swift
//  pratikcoinlistdemo
//
//  Created by Pratik Jamariya on 18/12/24.
//

import UIKit

class CoinListTableViewCell: UITableViewCell {

    // MARK: - UI Elements
    private let nameLabel = UILabel()
    private let symbolLabel = UILabel()
    private let typeImageView = UIImageView()
    private let ribbonView = UIImageView(image: UIImage(named: "ic_new"))

    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup UI
    private func setupUI() {
        // Name Label
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        nameLabel.textColor = .label
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        // Symbol Label
        symbolLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        symbolLabel.textColor = .secondaryLabel
        symbolLabel.translatesAutoresizingMaskIntoConstraints = false

        // Type Image View
        typeImageView.contentMode = .scaleAspectFit
        typeImageView.translatesAutoresizingMaskIntoConstraints = false

        // Ribbon View
        ribbonView.translatesAutoresizingMaskIntoConstraints = false

        // Add subviews
        contentView.addSubview(ribbonView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(symbolLabel)
        contentView.addSubview(typeImageView)

        setupConstraints()
    }

    // MARK: - Setup Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Ribbon View (left side)
            ribbonView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            ribbonView.topAnchor.constraint(equalTo: contentView.topAnchor),
            ribbonView.widthAnchor.constraint(equalToConstant: 30),
            ribbonView.heightAnchor.constraint(equalToConstant: 30),

            // Type Image View (trailing side)
            typeImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            typeImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            typeImageView.widthAnchor.constraint(equalToConstant: 40),
            typeImageView.heightAnchor.constraint(equalToConstant: 40),

            // Name Label
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: typeImageView.leadingAnchor, constant: -8),

            // Symbol Label
            symbolLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            symbolLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            symbolLabel.trailingAnchor.constraint(lessThanOrEqualTo: typeImageView.leadingAnchor, constant: -8),
            symbolLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -12)
        ])
    }

    // MARK: - Configure Cell
    func configure(coin: CoinModel) {
        nameLabel.text = coin.name
        symbolLabel.text = coin.symbol.uppercased()

        // Show or hide ribbon for new coins
        ribbonView.isHidden = !coin.isNew

        // Set trailing image based on type
        if coin.type.lowercased() == "coin" {
            typeImageView.image = UIImage(named: coin.isActive ? "ic_coin_active" : "ic_inactive")
        } else if coin.type.lowercased() == "token" {
            typeImageView.image = UIImage(named: "ic_token_active")?.withRenderingMode(.alwaysTemplate)
            typeImageView.tintColor = coin.isActive ? UIColor.black : UIColor.lightGray
        } else {
            typeImageView.image = nil // No type
        }
    }

}
