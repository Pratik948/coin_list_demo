//
//  StorageProtocol.swift
//  pratikcoinlistdemo
//
//  Created by Pratik Jamariya on 17/12/24.
//

import Foundation

// MARK: - Generic Storage Protocol
protocol StorageProtocol {
    associatedtype T: Codable
    func save(_ items: [T])
    func load() -> [T]
    func clear()
}

class Storage<T: Codable & Hashable>: StorageProtocol {
    func save(_ items: [T]) {
        fatalError("Unimplemented: Please override")
    }
    func load() -> [T] {
        fatalError("Unimplemented: Please override")
    }
    func clear() {
        fatalError("Unimplemented: Please override")
    }
}
