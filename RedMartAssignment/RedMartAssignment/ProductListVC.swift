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

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        WebServiceManager.shared().fetchProducts {(collection:ProductCollection?, error:Error?) -> Void in
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()

    }


}
