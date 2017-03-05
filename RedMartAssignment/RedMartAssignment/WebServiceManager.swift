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
    
    static var productList = "https://api.redmart.com/v1.5.7/catalog/search?theme=all-sales&"
    static var productImage = "http://media.redmart.com/newmedia/200p"
    
}

class WebServiceManager: NSObject {
    
    //MARK:
    //MARK: Public methods
    //MARK:
    
    private static var sharedNetworkManager: WebServiceManager = {
        
        let networkManager = WebServiceManager()
        return networkManager
        
    }()
    
    class func shared() -> WebServiceManager {
        
        return sharedNetworkManager
        
    }
    
    func fetchProducts(_ completion:@escaping ((ProductCollection?, Error?) -> Void)) {
        
        fetchProductsFor(collection: ProductCollection(), completion: completion)
        
    }
    
    func fetchNextPageForProductCollection(_ collection:ProductCollection, completion:@escaping ((ProductCollection?, Error?) -> Void)) {
        
        collection.page.index += 1
        fetchProductsFor(collection: collection, completion: completion)
        
    }
    
    //MARK:
    //MARK:Private methods
    //MARK:
    
    private func fetchProductsFor(collection:ProductCollection, completion:@escaping ((ProductCollection?, Error?) -> Void)) {
        
        let getProductListAPI = API.productList.appending("pageSize=\(collection.page.size)&Page=\(collection.page.index)")
        Alamofire.request(getProductListAPI).validate().responseJSON { response in
            
            switch response.result {
                
            case .success:
                
                if let data = response.data {
                    
                    let jsonError:NSErrorPointer? = nil
                    let json = JSON(data: data, options:JSONSerialization.ReadingOptions.allowFragments, error: jsonError)
                    
                    if let jsonError = jsonError {
                        
                        completion(nil, jsonError as? Error)

                    }
                    else {
                        
                        if let productList = json["products"].array {
                            
                            for productJson in productList {
                                
                                let product = Product(json: productJson)
                                collection.productList.append(product)
                                
                            }
                            
                        }
                        
                        completion(collection, nil)
                        
                    }
                    
                }
                
            case.failure(let error):
                
                completion(nil, error)
                
            }
            
            
        }
        
    }
    
}
