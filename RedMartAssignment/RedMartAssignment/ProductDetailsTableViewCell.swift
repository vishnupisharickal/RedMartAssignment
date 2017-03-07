//
//  ProductDetailsTableViewCell.swift
//  RedMartAssignment
//
//  Created by VISHNU on 07/03/17.
//  Copyright © 2017 MyCompany. All rights reserved.
//

import UIKit

class ProductDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var deatilsTextView: UITextView!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()

    }

    func setupCellFor(product: Product) {
        
        deatilsTextView.text = product.details ?? ""
        
    }

}
