//
//  ProductListVC.swift
//  RedMartAssignment
//
//  Created by VISHNU on 03/03/17.
//  Copyright © 2017 MyCompany. All rights reserved.
//

import UIKit
import Alamofire

class ProductListVC: UIViewController {

    var productCollection: ProductCollection?
    let productCellID = "ProductCell"
    let footerHeight: CGFloat = 44.0
    let collectionViewTopSpaceInset: CGFloat = 16.0
    var collectionFooterView: UIView?
    @IBOutlet weak var productListingCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK:View life cycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        productListingCollectionView.contentInset = UIEdgeInsets(top: collectionViewTopSpaceInset, left: 0, bottom: 0, right: 0)
        navigationController?.navigationBar.barTintColor = UIColor.navigationBarPinkRedColor()
        self.navigationItem.title = "Products"
        
        WebServiceManager.shared().fetchProducts {(collection:ProductCollection?, error:Error?) -> Void in
            
            self.activityIndicator.stopAnimating()
            
            if nil != collection {
                
                self.productCollection = collection
                self.productListingCollectionView.reloadData()
                
            }
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()

    }

    //MARK: Private methods
    
    func shouldLoadNewPage(_ indexPath : IndexPath) -> Bool {
        
        if (indexPath.row + 1 ==  productCollection?.productList.count) {
            
            return true
            
        }
        
        return false
        
    }

    func setCollectionViewFooterLoadingIndicatorView(_ activityIndicator: Bool) -> () {
        
        if activityIndicator {
            
            let footerView = UIView(frame: CGRect(x: 0, y: productListingCollectionView.contentSize.height - footerHeight, width: productListingCollectionView.bounds.width, height: footerHeight))
            footerView.backgroundColor = UIColor.clear
            productListingCollectionView.addSubview(footerView)

            let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
            activityIndicator.tintColor = UIColor.gray
            activityIndicator.center = CGPoint(x:footerView.frame.size.width/2.0, y:footerView.frame.size.height/2.0)
            activityIndicator.startAnimating()
            footerView.addSubview(activityIndicator)

            productListingCollectionView.contentInset = UIEdgeInsets(top: collectionViewTopSpaceInset, left: 0, bottom: footerHeight, right: 0)
            collectionFooterView = footerView


        } else {
            
            if let _ = collectionFooterView?.superview {
                
                collectionFooterView?.removeFromSuperview()
                collectionFooterView = nil
                productListingCollectionView.contentInset = UIEdgeInsets(top: collectionViewTopSpaceInset, left: 0, bottom: 0, right: 0)
                
            }
            
        }
        
    }
    
}

//MARK:
//MARK:Collectionview Datasources And Delegates
//MARK:

extension ProductListVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK:Collectionview datasources
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (productCollection?.productList.count) ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: productCellID, for: indexPath) as! ProductDetailsCollectionViewCell
        cell.setupCellForProduct(product: (productCollection?.productList[indexPath.row])!)
        
        return cell
        
    }
    
    //MARK:Collectionview delegates
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let productDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailsVC") as! ProductDetailsVC
        productDetailsVC.product = productCollection?.productList[indexPath.row]
        productDetailsVC.transitioningDelegate = self
        productDetailsVC.modalPresentationStyle = .custom
        present(productDetailsVC, animated: true, completion: nil)
                
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if shouldLoadNewPage(indexPath) {
            
            setCollectionViewFooterLoadingIndicatorView(true)
            WebServiceManager.shared().fetchNextPageForProductCollection(productCollection!) {(collection, error) in
                
                self.setCollectionViewFooterLoadingIndicatorView(false)

                if nil != collection {
                    
                    self.productCollection = collection
                    self.productListingCollectionView.reloadData()
                    
                }
                
                
            }
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        
        let numberOfCell: CGFloat = 3
        let cellWidth = ((productListingCollectionView.bounds.size.width) / numberOfCell) - 8.0
        return CGSize(width:cellWidth, height:cellWidth + (0.5 * cellWidth))
        
        
    }

    
}

extension ProductListVC: UIViewControllerTransitioningDelegate {
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return CustomDismiss()
        
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return CustomPresentation()
        
    }

}
