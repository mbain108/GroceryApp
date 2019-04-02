//
//  CartModel.swift
//  GroceryApp
//
//  Created by Melissa Bain on 3/23/19.
//  Copyright © 2019 MB Consulting. All rights reserved.
//

import Foundation

protocol CartModelDelegate: class {
    func dataUpdate()
}

class CartModel {
    weak var delegate: CartModelDelegate?
    
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
}

extension CartModel {
    private func validateNotEmpty(string: String?) throws -> String {
        guard let string = string, !string.isEmpty else {
            throw StringValidationError.emptyString
        }
        
        return string
    }
}
