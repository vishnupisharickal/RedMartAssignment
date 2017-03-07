//
//  UIImageView+LazyLoader.swift
//  RedMartAssignment
//
//  Created by VISHNU on 03/03/17.
//  Copyright © 2017 MyCompany. All rights reserved.
//

import Foundation
import UIKit

public extension UIImageView {
    
    fileprivate func setImageData(_ cachedResponse:CachedURLResponse?,placeHolder:String?) {
        
        if let data = cachedResponse?.data {
            
            if let img = UIImage(data: data) {
                
                DispatchQueue.main.async(execute: { () -> Void in
                    
                    self.image = img
                    
                })
                
            } else {
                
                if let hlder = placeHolder {
                    
                    DispatchQueue.main.async(execute: { () -> Void in
                        
                        self.image = UIImage(named: hlder)
                        
                    })
                    
                }
                
            }
            
        } else {
            
            if let hlder = placeHolder {
                
                DispatchQueue.main.async(execute: { () -> Void in
                    
                    self.image = UIImage(named: hlder)
                    
                })
                
            }
            
        }
        
    }
    
    func setImageFromURL(_ urlString:String,placeHolder:String?) {
        
        DispatchQueue.global(qos: .background).async(execute: { () -> Void in
            
            if let url =  URL(string: urlString) {
                
                let request = URLRequest(url: url)
                
                if let cachedUrlResponse = URLCache.shared.cachedResponse(for: request) {
                    
                    self.setImageData(cachedUrlResponse,placeHolder: placeHolder)
                    
                } else {
                    
                    //Set place holder
                    if let placeHolder = placeHolder {
                        
                        self.setImageData(nil, placeHolder: placeHolder)
                        
                    }
                    
                    //Fetch remote image
                    let urlInstance = URL(string: urlString)
                    let request = URLRequest(url: urlInstance!, cachePolicy: NSURLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 30)
                    
                    do {
                        
                        let urlSession = URLSession(configuration: URLSessionConfiguration.default)
                        
                        urlSession.sendSynchronousRequest(request: request, completionHandler: { (data, response) in
                            
                            let cachedResponse = CachedURLResponse(response: response!, data: data!)
                            URLCache.shared.storeCachedResponse(cachedResponse , for: request)
                            self.setImageData(cachedResponse, placeHolder: placeHolder)
                            
                        })
                        
                        
                    }
                    
                }
                
            } else {
                
                if let placeHolder = placeHolder {
                    
                    self.setImageData(nil, placeHolder: placeHolder)
                    
                }
                
            }
            
        })
        
    }
    
}

extension URLSession {
    
    func sendSynchronousRequest(request:URLRequest, completionHandler:@escaping (Data?, URLResponse?) -> Void) {
    
        let semaphore =  DispatchSemaphore(value: 0)
        let task = self.dataTask(with: request){ (data, response, error) in
            
            completionHandler(data, response)
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
        
    }
    
}
