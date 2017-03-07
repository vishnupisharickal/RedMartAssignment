//
//  ProductDetailsVC.swift
//  RedMartAssignment
//
//  Created by ARUNJITH on 07/03/17.
//  Copyright © 2017 MyCompany. All rights reserved.
//

import UIKit

class ProductDetailsVC: UIViewController {

    var product: Product?

    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK: View life cycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.titleLabel.text = product?.title
        
    }

    @IBAction func backButtonTapped(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
   
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
}

extension ProductDetailsVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        switch indexPath.row {
            
        case 0:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductImagesTableViewCell", for: indexPath) as! ProductImagesTableViewCell
            cell.setupCellFor(product: product!)
            return cell
        
        case 1:

            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductInfoTableViewCell", for: indexPath) as! ProductInfoTableViewCell
            cell.setupCellFor(product: product!)
            return cell

        case 2:

            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailsTableViewCell", for: indexPath) as! ProductDetailsTableViewCell
            cell.setupCellFor(product: product!)
            return cell

        default:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductInfoTableViewCell", for: indexPath) as! ProductInfoTableViewCell
            cell.setupCellFor(product: product!)
            return cell

        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
            
        case 0:
            return 250.0
        
        case 1:
            return 30.0
        
        case 2:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailsTableViewCell") as! ProductDetailsTableViewCell
            cell.deatilsTextView.text = product?.details
            let fixedWidth = cell.deatilsTextView.frame.size.width
            cell.deatilsTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
            let newSize = cell.deatilsTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
            var newFrame = cell.deatilsTextView.frame
            newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
            return newFrame.size.height + 50.0
            
        default:
            return 50.0
            
        }
        
    }
    
}

extension ProductDetailsVC: UIViewControllerTransitioningDelegate {
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return CustomDismiss()
        
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return CustomPresentation()
        
    }
    
}


