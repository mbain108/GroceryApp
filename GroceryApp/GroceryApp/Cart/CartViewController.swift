//
//  CartViewController.swift
//  GroceryApp
//
//  Created by Melissa Bain on 3/21/19.
//  Copyright © 2019 MB Consulting. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {

    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var remainingBudgetLabel: UILabel!
    @IBOutlet weak var totalCostLabel: UILabel!
    
    let model = CartModel(persistence: GroceryItemPersistence(filename: "Cart"))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        cartTableView.dataSource = self
        cartTableView.delegate = self
        
        model.delegate = self
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "AddItemSegue", sender: nil)
    }
    
}

extension CartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.listCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cartTableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath)
        
        let groceryItem: GroceryItem? = model.groceryItemFor(row: indexPath.row)
        
        cell.textLabel?.text = groceryItem?.itemName
        cell.detailTextLabel?.text = groceryItem?.quantity != nil ? String(groceryItem!.quantity) : ""
        
        return cell
    }
}

extension CartViewController: CartModelDelegate {
    func dataUpdate() {
        cartTableView.reloadData()
    }
}
