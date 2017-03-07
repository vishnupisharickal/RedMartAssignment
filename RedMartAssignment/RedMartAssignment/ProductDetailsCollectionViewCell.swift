//
//  ProductDetailsCollectionViewCell.swift
//  RedMartAssignment
//
//  Created by VISHNU on 07/03/17.
//  Copyright © 2017 MyCompany. All rights reserved.
//

import UIKit

class ProductDetailsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    func setupCellForProduct(product: Product)  {
        
        coverImageView.setImageFromURL((product.coverImage ?? ""), placeHolder: nil)
        coverImageView.clipsToBounds = true
        productNameLabel.text = product.title ?? ""
        priceLabel.text = product.price ?? ""
        
    }
    
}
