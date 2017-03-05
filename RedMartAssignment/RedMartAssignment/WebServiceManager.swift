//
//  WebServiceManager.swift
//  RedMartAssignment
//
//  Created by VISHNU on 03/03/17.
//  Copyright © 2017 MyCompany. All rights reserved.
//

import UIKit
import Alamofire

struct API {
    
    static let productList = "https://api.redmart.com/v1.5.7/catalog/search?theme=all-sales&pageSize=30&"
    
}

class WebServiceManager: NSObject {

    private static var sharedNetworkManager: WebServiceManager = {
        
        let networkManager = WebServiceManager()
        return networkManager
        
    }()
    
    class func shared() -> WebServiceManager {
        
        return sharedNetworkManager
        
    }
    
    func fetchProducts(_ completion:@escaping ((ProductCollection?) -> Void)) {
        
    }
    
    func fetchNextPageForProductCollection(_ collection:ProductCollection, completion:((ProductCollection?) -> Void)) {
        
    }
    
}
