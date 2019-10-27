//
//  Networkservice.swift
//
//  Created by Debabiswa Panda on 10/05/19.
//  Copyright © 2019 Debabiswa Panda. All rights reserved.

import Foundation
import Alamofire
class servicecall{
    static let shared =  servicecall()
    typealias jsonMutablearray = (NSMutableArray) -> ()
    typealias jsonDictionay = (NSDictionary)-> ()
    var network = 0
    func getsuccess(params:[String:Any],urlhit: String, completion: @escaping jsonDictionay) {
        let urllink = urlhit
        print("URl:-",urllink)
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 2
        manager.session.configuration.timeoutIntervalForResource = 30
        if network == 0{
            manager.request(urllink).responseJSON(queue: nil)
            { response in
                //var responseArray:NSMutableArray!
                if let error = response.result.error {
                    if error._code == NSURLErrorTimedOut {
                        print("network error")
                    } else {
                    print("delay in service")
                    }
                } else {
                    switch (response.result) {
                    case .success:
                        if response.result.value != nil {
                            let result = response.result.value as! NSDictionary
                            completion(result)
                        } else {
                            print("Error in service")
                        }
                        break
                    case .failure(let error):
                        print("Can't Connect to Server / TimeOut",error)
                        break
                    }
                }
            }
        } else {
           print("network issue in get method")
        }
    }
    func getsuccessArray(params:[String:Any],urlhit: String, completion: @escaping jsonMutablearray) {
        let urllink = urlhit
        print("URl:-",urllink)
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 2
        manager.session.configuration.timeoutIntervalForResource = 30
        if network == 1{
            manager.request(urllink).responseJSON(queue: nil)
            { response in
                var responseArray:NSMutableArray!
                if let error = response.result.error {
                    if error._code == NSURLErrorTimedOut {
                        print("network error")
                    } else {
                        print("delay in service")
                    }
                } else {
                    switch (response.result) {
                    case .success:
                        if response.result.value != nil {
                            let val = response.result.value as! NSArray
                            let responseArray = val.mutableCopy() as? NSMutableArray
                            completion(responseArray!)
                        } else {
                            print("Error in service")
                        }
                        break
                    case .failure(let error):
                        print("Can't Connect to Server / TimeOut",error)
                        break
                    }
                }
            }
        } else {
            print("network issue")
        }
    }
    func Postsuccess(params:[String:Any],urlhit: String, completion: @escaping jsonDictionay){
        let parameter = params
        Alamofire.request(urlhit, method: .post, parameters: parameter as Parameters, encoding: JSONEncoding.default)
            .responseJSON() { response in
                switch response.result {
                case .success:
                    if let httpStatusCode = response.response?.statusCode {
                        switch(httpStatusCode) {
                        case 200:
                            let result = response.result.value as! NSDictionary
                            completion(result)
                           // print("result",result)
                        default:
                            print("invalid")
                        }
                    } else {
                        print("error")
                    }
                    
                    break
                case .failure:
                    print("error")
                    
                    break
                }
        }
    }
    func PostsuccessArray(params:[String:Any],urlhit: String, completion: @escaping jsonMutablearray){
        let parameter = params
        Alamofire.request(urlhit, method: .post, parameters: parameter as Parameters, encoding: JSONEncoding.default)
            .responseJSON() { response in
                switch response.result {
                case .success:
                    if let httpStatusCode = response.response?.statusCode {
                        switch(httpStatusCode) {
                        case 200:
                            let val = response.result.value as! NSArray
                            let responseArray = val.mutableCopy() as? NSMutableArray
                            completion(responseArray!)
                        // print("result",result)
                        default:
                            print("invalid")
                        }
                    } else {
                        print("error")
                    }
                    
                    break
                case .failure:
                    print("error")
                    
                    break
                }
        }
    }
  

}

