//
//  AddItemToCartViewController.swift
//  GroceryApp
//
//  Created by Melissa Bain on 3/27/19.
//

import UIKit

class AddItemToCartViewController: UIViewController {
    var model: CartModel?
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var quantityTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        saveButton.isEnabled = false
        
        nameTextField.delegate = self
        quantityTextField.delegate = self
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
        print("deinit AddItemToCartViewController")
    }
}

extension AddItemToCartViewController: UITextFieldDelegate {
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
        }
        
        if name != nil, quantity != nil {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
        
        return true
    }
}
