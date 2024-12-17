//
//  CoinFilterModel.swift
//  pratikcoinlistdemo
//
//  Created by Pratik Jamariya on 18/12/24.
//

import Foundation

class CoinFilterModel {
    var isActive: Bool
    var isInActive: Bool
    var isNew: Bool
    var isToken: Bool
    var isCoin: Bool
    
    init(isActive: Bool = false, isInActive: Bool = false, isNew: Bool = false, isToken: Bool = false, isCoin: Bool = false) {
        self.isActive = isActive
        self.isInActive = isInActive
        self.isNew = isNew
        self.isToken = isToken
        self.isCoin = isCoin
    }
    
    var isAllDisabled: Bool {
        !isActive && !isInActive && !isNew && !isToken && !isCoin
    }
    
}
