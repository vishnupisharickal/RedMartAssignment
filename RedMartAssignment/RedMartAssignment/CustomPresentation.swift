//
//  CustomPresentation.swift
//  RedMartAssignment
//
//  Created by VISHNU on 03/03/17.
//  Copyright © 2017 MyCompany. All rights reserved.
//

import UIKit

class CustomPresentation: NSObject,UIViewControllerAnimatedTransitioning {
    
    let kTransitionDuration:TimeInterval = 0.3
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return kTransitionDuration
        
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let sourceViewController:UIViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let destinationViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        let transitionContainerView = transitionContext.containerView
        
        sourceViewController.view.isUserInteractionEnabled = false
        destinationViewController?.view.isUserInteractionEnabled = false
    
        destinationViewController?.view.bounds = (transitionContainerView.bounds)
        transitionContainerView.backgroundColor = UIColor.clear

        destinationViewController?.view.alpha = 0.0
        transitionContainerView.addSubview((destinationViewController?.view)!)

        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {[weak destinationViewController] () -> Void in
            
                destinationViewController?.view.alpha = 1.0

            }, completion: {[weak sourceViewController, weak destinationViewController, weak transitionContext] (Bool) -> Void in
                
                transitionContext!.completeTransition(true)
                sourceViewController!.view.isUserInteractionEnabled = true
                destinationViewController!.view.isUserInteractionEnabled = true
        })

    }

}
