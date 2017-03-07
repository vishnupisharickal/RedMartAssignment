//
//  ProductInfoTableViewCell.swift
//  RedMartAssignment
//
//  Created by VISHNU on 07/03/17.
//  Copyright © 2017 MyCompany. All rights reserved.
//

import UIKit

class ProductInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var lifeTimeLabel: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()

    }

    func setupCellFor(product: Product) {
        
        priceLabel.text = product.price ?? ""
        lifeTimeLabel.text = product.stockMeasure ?? ""
        
    }

}
