//
//  ProductImagesTableViewCell.swift
//  RedMartAssignment
//
//  Created by VISHNU on 07/03/17.
//  Copyright © 2017 MyCompany. All rights reserved.
//

import UIKit

class ProductImagesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        self.productImageView.clipsToBounds = true
        
    }

    func setupCellFor(product: Product) {
    
        productImageView.setImageFromURL(product.coverImage!, placeHolder: nil)
        
    }
    
}
