//
//  ServerManager.swift
//  Lunascope
//
//  Created by Андрей Кропотов on 12/30/15.
//  Copyright © 2015 ACE Solutions. All rights reserved.
//

import Foundation
import Alamofire



class ServerManager: NSObject {
    
    static let sharedInstance = ServerManager()
    let serverAddress = "http://lab.ace-solutions.ru/moon/"
    
    
    
    
    internal func getNewMoonDate() -> NSDate {
    
        Alamofire.request(.GET, serverAddress, parameters: ["t": "\(NSDate.init().timeIntervalSince1970)"]).responseJSON { response in
            print(response.request)  // original URL request
            print(response.response) // URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                print("JSON: \(JSON["new_moon"])")
            }
        }
        
        
        
        
       
    
    return NSDate.init()
    }
    
    


}

