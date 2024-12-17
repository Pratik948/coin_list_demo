//
//  AppStorage.swift
//  pratikcoinlistdemo
//
//  Created by Pratik Jamariya on 17/12/24.
//

import Foundation

func defaultStorage<T: Codable & Hashable>(_ t: T.Type) -> Storage<T> {
    return CoreDataStorage<T>() // Change the default storage object whenever required
}

final class AppStorage<T: Codable & Hashable>: StorageProtocol {
    private let _save: ([T]) -> Void
    private let _load: () -> [T]
    private let _clear: () -> Void

    init() {
        let storage = defaultStorage(T.self)
        _save = storage.save
        _load = storage.load
        _clear = storage.clear
    }

    func save(_ items: [T]) {
        _save(items)
    }

    func load() -> [T] {
        return _load()
    }

    func clear() {
        _clear()
    }
}
