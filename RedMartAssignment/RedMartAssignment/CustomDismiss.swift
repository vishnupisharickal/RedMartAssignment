//
//  CustomDismiss.swift
//  RedMartAssignment
//
//  Created by VISHNU on 03/03/17.
//  Copyright © 2017 MyCompany. All rights reserved.
//

import UIKit

class CustomDismiss: NSObject,UIViewControllerAnimatedTransitioning {
    
    let kTransitionDuration:TimeInterval = 0.3
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return kTransitionDuration
        
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning){
        
        let sourceViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let destinationViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        
        sourceViewController.view.isUserInteractionEnabled = false
        destinationViewController.view.isUserInteractionEnabled = false
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {[weak sourceViewController] () -> Void in
            
            sourceViewController!.view.alpha = 0.0
            
            
            }, completion: {[weak sourceViewController, weak transitionContext, weak destinationViewController] (Bool) -> Void in
                
                transitionContext!.completeTransition(true)
                destinationViewController?.viewWillAppear(true)
                sourceViewController!.view.isUserInteractionEnabled = true
                destinationViewController!.view.isUserInteractionEnabled = true
                sourceViewController!.view.removeFromSuperview()
                
        })


    }
    
}
