//
//  CoinModel.swift
//  pratikcoinlistdemo
//
//  Created by Pratik Jamariya on 17/12/24.
//

import Foundation

class CoinModel: Codable, Hashable {

    let name: String
    let symbol: String
    let isNew: Bool
    let isActive: Bool
    let type: String

    enum CodingKeys: String, CodingKey {
        case name, symbol
        case isNew = "is_new"
        case isActive = "is_active"
        case type
    }

    init(name: String, symbol: String, isNew: Bool, isActive: Bool, type: String) {
        self.name = name
        self.symbol = symbol
        self.isNew = isNew
        self.isActive = isActive
        self.type = type
    }
    
    static func == (lhs: CoinModel, rhs: CoinModel) -> Bool {
        return lhs.symbol == rhs.symbol
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(symbol)
    }
}
