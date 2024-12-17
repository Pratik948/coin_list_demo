//
//  CoreDataManager.swift
//  pratikcoinlistdemo
//
//  Created by Pratik Jamariya on 17/12/24.
//

import CoreData
import Foundation

final class CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}

    // Persistent Container
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoinDataModel")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
        return container
    }()

    // Save Context
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Failed to save Core Data context: \(error)")
            }
        }
    }
}
