//
//  CartTableViewCell.swift
//  GroceryApp
//
//  Created by Melissa Bain on 3/21/19.
//  Copyright © 2019 MB Consulting. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var unitCostLabel: UILabel!
    @IBOutlet weak var subTotalLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
