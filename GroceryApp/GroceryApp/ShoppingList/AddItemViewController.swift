//
//  AddItemViewController.Swift
//  GroceryApp
//
//  Created by Melissa Bain on 3/17/19.
//  Copyright © 2019 MB Consulting. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController {
    var model: ShoppingListModel?
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var quantityTextField: UITextField!
    
    override func viewDidLoad() {
        print(#function + "Add Item")
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        saveButton.isEnabled = false
        
        nameTextField.delegate = self
        quantityTextField.delegate = self
        
//        print("--> RUN Test Environment <--")
//        let hotdogs = GroceryItem(itemName: "Hot dogs", quantity: 1, cost: 2.99)
//        let buns = GroceryItem(itemName: "Buns", quantity: 1, cost: 1.79)
//        let coffee = GroceryItem(itemName: "Coffee", quantity: 1, cost: 6.99)
//        let yogurt = GroceryItem(itemName: "Yogurt", quantity: 5, cost: 1.09)
//        let tofu = GroceryItem(itemName: "Tofu", quantity: 2) //, cost: 3.75)
//
//        var myShoppingList = [GroceryItem]()
//
//        myShoppingList.append(hotdogs)
//        myShoppingList.append(buns)
//        myShoppingList.append(coffee)
//        myShoppingList.append(yogurt)
//        myShoppingList.append(tofu)
//
//        let schnucks = GroceryTrip(budget: 50.00, arrShoppingList: myShoppingList) //, taxRate: 0.03)
//
//        //schnucks.addToCart(name: hotdogs.itemName, unit: hotdogs.quantity, price: hotdogs.cost!)
//        //schnucks.addToCart(name: hotdogs.itemName, unit: hotdogs.quantity, price: hotdogs.cost!)
//        //schnucks.addToCart(name: buns.itemName, unit: buns.quantity, price: buns.cost!)
//        //schnucks.addToCart(name: coffee.itemName, unit: coffee.quantity, price: coffee.cost!)
//        //schnucks.addToCart(name: yogurt.itemName, unit: yogurt.quantity, price: yogurt.cost!)
//        //schnucks.addToCart(name: tofu.itemName, unit: tofu.quantity, price: tofu.cost!)
//
//
//        do {
//            try schnucks.addToCart(name: tofu.itemName, unit: tofu.quantity, price: 3.75)
//        } catch GroceryTripError.noItem {
//            print("Error: No item")
//        } catch GroceryTripError.exceedsAmount {
//            print("Error: Exceeds Amount")
//        } catch GroceryTripError.belowAmount {
//            print("Error: Below Amount")
//        } catch GroceryTripError.exceedsBudget {
//            print("Error : Exceeds Budget")
//        } catch {
//            print("Unexpected Error: \(error)")
//        }
//
//        //schnucks.removeFromCart(item: tofu)
//
//        do {
//            try print(schnucks.checkout())
//        } catch GroceryTripError.noTax {
//            print("Error: No Tax")
//        } catch GroceryTripError.exceedsBudget {
//            print("Error: Exceeds Budget")
//        } catch {
//            print("Unexpected Error: \(error)")
//        }
    }
    
    @IBAction func userTappedCancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func userTappedSave(_ sender: UIButton) {
        nameTextField.resignFirstResponder()
        quantityTextField.resignFirstResponder()
        
        guard let name = nameTextField.text, let quantity = Int(quantityTextField.text ?? "") else {
            return
        }
        
        let groceryItem = model?.addItemToShoppingList(name: name, quantity: quantity)
        
        guard groceryItem != nil else {
            return
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    deinit {
        print("deinit AddItemViewController")
    }
}

extension AddItemViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let model = model else {
            saveButton.isEnabled = false
            return true
        }
        
        var name: String?
        var quantity: Int?
        
        if textField == quantityTextField {
            name = try? model.validate(name: nameTextField.text)
            quantity = try? model.validate(quantity: string)
        } else if textField == nameTextField {
            name = try? model.validate(name: string)
            quantity = try? model.validate(quantity: quantityTextField.text)
//        } else {
//
        }
        
        if name != nil, quantity != nil {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
        
//        do {
//            if textField == nameTextField {
//                _ = try model.validate(name: textField.text)
//            }
//
//            if textField == quantityTextField {
//                _ = try model.validate(quantity: textField.text)
//            }
//
//            saveButton.isEnabled = true
//        } catch is StringValidationError {
//            saveButton.isEnabled = false
//        } catch {
//            print("Unknown error \(error)")
//        }
        
        return true
    }
}
