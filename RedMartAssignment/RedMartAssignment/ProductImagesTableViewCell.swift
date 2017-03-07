//
//  ProductImagesTableViewCell.swift
//  RedMartAssignment
//
//  Created by VISHNU on 07/03/17.
//  Copyright © 2017 MyCompany. All rights reserved.
//

import UIKit

class ProductImagesTableViewCell: UITableViewCell, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    var product: Product?
    var imageViewFrame: CGRect = CGRect(x:0, y:0, width:0, height:0)
    var imageViews = [UIImageView]()
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        scrollView.delegate = self
        
    }

    func setupCellFor(product: Product) {
        
        self.product = product
        
        configurePageControl()
        
        for index in 0..<product.images.count {
            
            imageViewFrame.origin.x = self.scrollView.frame.size.width * CGFloat(index)
            imageViewFrame.size = self.scrollView.frame.size
            self.scrollView.isPagingEnabled = true
            
            let productImageView = UIImageView(frame: imageViewFrame)
            productImageView.clipsToBounds = true
            productImageView.contentMode = .scaleAspectFill
            
            self.scrollView.addSubview(productImageView)
            imageViews.append(productImageView)
            productImageView.setImageFromURL(product.images[index], placeHolder: "PlaceHolder")
            
        }
        
        self.scrollView.contentSize = CGSize(width:self.scrollView.frame.size.width * CGFloat(product.images.count), height:self.scrollView.frame.size.height)
        pageControl.addTarget(self, action: #selector(ProductImagesTableViewCell.changePage(sender:)), for: UIControlEvents.valueChanged)
        
    }
    
    func configurePageControl() {
       
        self.pageControl.numberOfPages = (product?.images.count)!
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.red
        self.pageControl.pageIndicatorTintColor = UIColor.black
        self.pageControl.currentPageIndicatorTintColor = UIColor.green
        
        if product?.images.count == 1 {
            
            pageControl.isHidden = true
            scrollView.isScrollEnabled = false
            
        }
        
    }
    
    func changePage(sender: AnyObject) -> () {
        
        let x = CGFloat(pageControl.currentPage) * scrollView.frame.size.width
        scrollView.setContentOffset(CGPoint(x:x, y:0), animated: true)
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let pageNumber = Int (round(scrollView.contentOffset.x / scrollView.frame.size.width))
        
        if pageNumber < (product?.images.count)! {
            
            let imageView = imageViews[pageNumber]
            imageViewFrame.origin.x = self.scrollView.frame.size.width * CGFloat(pageNumber)
            imageViewFrame.size = self.scrollView.frame.size
            imageView.frame = imageViewFrame
            pageControl.currentPage = Int(pageNumber)
            
        }
        
    }
    
}
