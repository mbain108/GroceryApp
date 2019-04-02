//
//  ShoppingListModelTests.Swift
//  GroceryApp
//
//  Created by Melissa Bain on 3/17/19.
//  Copyright © 2019 MB Consulting. All rights reserved.
//

import XCTest
@testable import GroceryApp

class ShoppingListModelTests: XCTestCase {

    var testShoppingListModel: ShoppingListModel!

    override func setUp() {
        testShoppingListModel = ShoppingListModel(persistence: GroceryItemPersistence(filename: "ShoppingList"))

        continueAfterFailure = false
    }

    func test_addItemToShoppingList_CorrectlyAddsItem() {
        XCTAssertEqual(testShoppingListModel.listCount, 0)

        let expectedName = "test"
        let expectedQuantity = 1

        let actualShoppingListItem: GroceryItem = testShoppingListModel.addItemToShoppingList(name: expectedName, quantity: expectedQuantity)

        XCTAssertEqual(testShoppingListModel.listCount, 1)
        XCTAssertEqual(actualShoppingListItem.itemName, expectedName)
        XCTAssertEqual(actualShoppingListItem.quantity, expectedQuantity)
        XCTAssertNil(actualShoppingListItem.cost)
    }
    
    func test_validateName_EmptyString_ThrowsError() {
        let testString = ""
        
        XCTAssertThrowsError(try testShoppingListModel.validate(name: testString)) { error in
            XCTAssertEqual(error as? StringValidationError, StringValidationError.emptyString)
        }
    }
    
    func test_validateName_validName_ReturnsName() {
        let testString = "bananas"
        
        let actualResult = try? testShoppingListModel.validate(name: testString)
        
        XCTAssertEqual(actualResult, testString)
    }
    
    
    func test_validateQuantity_StringWithNonNumericaCharacters_ThrowsError() {
        let testString = "123abc"
        
        XCTAssertThrowsError(try testShoppingListModel.validate(quantity: testString)) { error in
            XCTAssertEqual(error as? StringValidationError, StringValidationError.nonNumericCharacters)
        }
    }
    
    func test_validateQuantity_validQuantity_ReturnsQuantity() {
        let testString = "123"
        
        let actualResult = try? testShoppingListModel.validate(quantity: testString)
        
        XCTAssertEqual(actualResult, Int(testString))
    }
    
}
