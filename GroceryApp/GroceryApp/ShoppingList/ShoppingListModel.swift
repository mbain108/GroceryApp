//
//  ShoppingListModel.Swift
//  GroceryApp
//
//  Created by Melissa Bain on 3/17/19.
//  Copyright © 2019 MB Consulting. All rights reserved.
//

import Foundation

protocol ShoppingListModelDelegate: class {
    func dataUpdate()
}

class ShoppingListModel {
    weak var delegate: ShoppingListModelDelegate?
    
    private let persistence: GroceryItemPersistence
    private var shoppingList: [GroceryItem] {
        didSet {
            persistence.write(shoppingList)
        }
    }
    
    //
    init(persistence: GroceryItemPersistence) {
        self.persistence = persistence
        shoppingList = persistence.shoppingList()
    }
//    private var shoppingList: [GroceryItem] = [
//    GroceryItem(itemName: "Pears", quantity: 5),
//    GroceryItem(itemName: "Oranges", quantity: 7),
//    GroceryItem(itemName: "Grapes", quantity: 24),
//    GroceryItem(itemName: "Pineapple", quantity: 1)
//    ]

    var listCount: Int { return shoppingList.count }

    func groceryItemFor(row: Int) -> GroceryItem? {
        guard row < listCount else { return nil }
        return shoppingList[row]
    }
    
    func addItemToShoppingList(name: String, quantity: Int) -> GroceryItem {
        let groceryItem = GroceryItem(itemName: name, quantity: quantity)
        shoppingList.append(groceryItem)

        delegate?.dataUpdate()
        
        return groceryItem
    }
    
    func validate(name: String?) throws -> String {
        let name = try validateNotEmpty(string: name)
        
        return name
    }
    
    func validate(quantity: String?) throws -> Int {
        let quantityString = try validateNotEmpty(string: quantity)
        
        guard let quantityInt = Int(quantityString) else {
            throw StringValidationError.nonNumericCharacters
        }
        
        return quantityInt
    }
    
    deinit {
        print("deinit ShoppingListModel")
    }
}

extension ShoppingListModel {
    private func validateNotEmpty(string: String?) throws -> String {
        guard let string = string, !string.isEmpty else {
            throw StringValidationError.emptyString
        }
        
        return string
    }
}

enum StringValidationError: Error {
    case emptyString
    case nonNumericCharacters
}
