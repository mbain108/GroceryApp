//
//  ShoppingListViewController.swift
//  GroceryApp
//
//  Created by Melissa Bain on 3/17/19.
//  Copyright © 2019 MB Consulting. All rights reserved.
//

import UIKit

class ShoppingListViewController: UIViewController {
    
    let model = ShoppingListModel(persistence: GroceryItemPersistence(filename: "ShoppingList"))
    
    @IBOutlet weak var shoppingListTableView: UITableView!
    
    override func viewDidLoad() {
        print(#function + "Shooping List")
        super.viewDidLoad()
        
        shoppingListTableView.dataSource = self
        shoppingListTableView.delegate = self
        
        model.delegate = self
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "AddItemSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? AddItemViewController else {
            return
        }
        
        destination.model = model
    }
    
    deinit {
        print("deinit ShoppingListViewController")
    }
}

extension ShoppingListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    }
}

extension ShoppingListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.listCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = shoppingListTableView.dequeueReusableCell(withIdentifier: "shoppingListCell", for: indexPath)
        
        let groceryItem: GroceryItem? = model.groceryItemFor(row: indexPath.row)
        
        cell.textLabel?.text = groceryItem?.itemName
        cell.detailTextLabel?.text = groceryItem?.quantity != nil ? String(groceryItem!.quantity) : ""
        
        return cell
    }
}

extension ShoppingListViewController: ShoppingListModelDelegate {
    func dataUpdate() {
        shoppingListTableView.reloadData()
    }
}
