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
    
    
    
    
    func getNewMoonDate() {
    
        Alamofire.request(.GET, serverAddress, parameters: ["t": "\(NSDate.init().timeIntervalSince1970)"]).responseJSON { response in
            print(response.request)  // original URL request
            print(response.response) // URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {

            var dateNewMoon  = NSDate.init(timeIntervalSince1970:JSON["new_moon"] as! Double )
             
            
            
            }
        }
        
        
            }
    

        
        func createLunarMonthByNewMoonDate() {
        
        }
    
    
    
    
    func getNewMoonRiseSet(day:Int, month: Int, year: Int, lat: Float, lon: Float) {
        
        
        
        let params =   ["day":"\(day)",
            "month":"\(month)",
            "year":"\(year)",
            "lat":"\(lat)",
            "lon":"\(lon)",]
        
        Alamofire.request(.GET, serverAddress, parameters: params).responseJSON { response in
            print(response.request)  // original URL request
            print(response.response) // URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                
                var moonSet  = NSDate.init(timeIntervalSince1970:JSON["moonrise"] as! Double )
                var moonRise  = NSDate.init(timeIntervalSince1970:JSON["moonset"] as! Double )
                
                
            }
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
}
