//
//  GroceryItemPersistence.Swift
//  GroceryApp
//
//  Created by Melissa Bain on 3/17/19.
//  Copyright © 2019 MB Consulting. All rights reserved.
//

import Foundation

class GroceryItemPersistence {
    // take in generic persistence class by adding a parameter to the persistence for the filename
    private let filename: String // = "ShoppingList"
    private let type = "json"
    
    private let fileURL: URL
    
    init(filename: String) {
        self.filename = filename
        
        fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            .first!
            .appendingPathComponent(filename, isDirectory: false)
            .appendingPathExtension(type)
    }
    
    func shoppingList() -> [GroceryItem] {
        do {
            let data = try Data(contentsOf: fileURL)
            return try decode(type: [GroceryItem].self, data)
        } catch let error as NSError {
              print(error.debugDescription)
        }
        
        return []
    }
    
    func write(_ list: [GroceryItem]) {
        do {
            let data = try encode(list)
            try data.write(to: fileURL, options: .atomicWrite)
        } catch let error as NSError {
            print(error.debugDescription)
        }
    }
    
    private func decode<T>(type: T.Type, _ data: Data) throws -> T where T: Decodable {
        return try JSONDecoder().decode(type, from: data)
    }
    
    private func encode<T>(_ item: T) throws -> Data where T: Encodable {
        return try JSONEncoder().encode(item)
    }
}
