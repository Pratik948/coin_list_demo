//
//  CoreDataStorage.swift
//  pratikcoinlistdemo
//
//  Created by Pratik Jamariya on 17/12/24.
//

import CoreData
import Foundation

final class CoreDataStorage<T: Codable & Hashable>: Storage<T> {
    private let context = CoreDataManager.shared.persistentContainer.viewContext
    
    override func save(_ items: [T]) {
        clear() // Clear old data before saving new ones
        
        for item in items {
            guard let coin = item as? CoinModel else { continue }
            let entity = CoinEntity(context: context)
            entity.name = coin.name
            entity.symbol = coin.symbol
            entity.isNew = coin.isNew
            entity.isActive = coin.isActive
            entity.type = coin.type
        }
        
        do {
            try context.save()
        } catch {
            print("CoreData: Failed to save data: \(error)")
        }
    }
    
    override func load() -> [T] {
        let fetchRequest: NSFetchRequest<CoinEntity> = CoinEntity.fetchRequest()
        do {
            let results = try context.fetch(fetchRequest)
            let coins: [T] = results.map {
                CoinModel(
                    name: $0.name ?? "",
                    symbol: $0.symbol ?? "",
                    isNew: $0.isNew,
                    isActive: $0.isActive,
                    type: $0.type ?? ""
                ) as! T
            }
            return coins
        } catch {
            print("CoreData: Failed to fetch data: \(error)")
            return []
        }
    }
    
    override func clear() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CoinEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print("CoreData: Failed to clear data: \(error)")
        }
    }
}
