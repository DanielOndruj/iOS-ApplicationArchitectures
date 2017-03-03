//
//  APIService.swift
//  MVC
//
//  Created by Daniel on 2/4/17.
//  Copyright © 2017 STRV s.r.o. All rights reserved.
//

import Foundation

enum Response {
    
    case success(value:[String:AnyObject])
    case failure(error:Error)
}

class APIService {
    
    public static let sharedService = APIService()
    
    func makeAPIRequest(urlString:String, completion: @escaping (_ response:Response)->Void)->Void {
        
        guard let url = URL(string: urlString) else {
            completion(.failure(error: NSError(domain:"", code: 999, userInfo:nil)))
            return
        }
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let urlRequest = URLRequest(url: url)
        let task = session.dataTask(with: urlRequest, completionHandler: {(data, response, error) -> Void in
            if let data = data, let jsonData = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String:AnyObject] {
                completion(.success(value: jsonData))
            } else {
                let err = error ?? NSError(domain:"", code: 999, userInfo:nil)
                completion(.failure(error: err))
            }
        })
        task.resume()
    }
}
