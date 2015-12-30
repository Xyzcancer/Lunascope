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
    
    
    
    
    func getNewMoonDate() -> NSDate {
    
        Alamofire.request(.GET, serverAddress, parameters: ["t": "\(NSDate.init().timeIntervalSince1970)"]).responseJSON { response in
            print(response.request)  // original URL request
            print(response.response) // URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {

            var dateNewMoon  = NSDate.init(timeIntervalSince1970:JSON["new_moon"] as! Double )
                
            
            
            }
        }
        
        
        
        
       
    
    return NSDate.init()
    }
    
    
    
    func getDaysBetweenTwoDates(startDate: NSDate, endDate: NSDate) -> NSDateComponents {
        
        
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        
        
        let cal = NSCalendar.currentCalendar()
        
        
        let unit:NSCalendarUnit = .Day
        
        let components = cal.components(unit, fromDate: startDate, toDate: endDate, options: .MatchFirst)
        
        
        return components;
    
    }
    
    


}

