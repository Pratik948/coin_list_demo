//
//  FileStorage.swift
//  pratikcoinlistdemo
//
//  Created by Pratik Jamariya on 18/12/24.
//

import Foundation

class FileStorage<T: Codable & Hashable>: Storage<T> {
    private let fileManager = FileManager.default
    private let fileURL: URL

    // MARK: - Initializer
    init(fileName: String, directoryName: String = "FileStorage") {
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let directoryURL = urls[0].appendingPathComponent(directoryName)

        // Create the directory if it doesn't exist
        if !fileManager.fileExists(atPath: directoryURL.path) {
            do {
                try fileManager.createDirectory(at: directoryURL, withIntermediateDirectories: true, attributes: nil)
            } catch {
                fatalError("Failed to create directory: \(error.localizedDescription)")
            }
        }

        // Set the file URL
        self.fileURL = directoryURL.appendingPathComponent(fileName)
    }

    // MARK: - Save Items
    override func save(_ items: [T]) {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(items)
            try data.write(to: fileURL, options: .atomic)
            print("Data saved successfully to \(fileURL.path)")
        } catch {
            print("Failed to save data: \(error.localizedDescription)")
        }
    }

    // MARK: - Load Items
    override func load() -> [T] {
        guard fileManager.fileExists(atPath: fileURL.path) else {
            print("No file exists at \(fileURL.path)")
            return []
        }

        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let items = try decoder.decode([T].self, from: data)
            return items
        } catch {
            print("Failed to load data: \(error.localizedDescription)")
            return []
        }
    }

    // MARK: - Clear Items
    override func clear() {
        guard fileManager.fileExists(atPath: fileURL.path) else {
            print("No file exists to clear at \(fileURL.path)")
            return
        }

        do {
            try fileManager.removeItem(at: fileURL)
            print("Data cleared successfully from \(fileURL.path)")
        } catch {
            print("Failed to clear data: \(error.localizedDescription)")
        }
    }
}
