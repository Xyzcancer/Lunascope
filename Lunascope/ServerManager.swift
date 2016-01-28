//
//  ServerManager.swift
//  Lunascope
//
//  Created by Андрей Кропотов on 12/30/15.
//  Copyright © 2015 ACE Solutions. All rights reserved.
//

import Foundation
import Alamofire
import Parse
import SwiftyJSON




class ServerManager: NSObject {
    
   
    
    static let sharedInstance = ServerManager()
    let serverAddress = "http://lab.ace-solutions.ru/moon/"
    
    
    func getMoonMonth(Longitude lon : Double,Latitude lat : Double, requestTimestamp timestamp: Double) {
        PFCloud.callFunctionInBackground("getLunarMonthData", withParameters: ["lon": lon, "lat": lat, "requestTimestamp": timestamp]) {
            (responsObj, error) in
            if (error == nil) {
                let dataManager = DataManager.sharedInstance
                let monthData = JSON(responsObj!)
                for dayData in monthData.array! {
                    dataManager.createDay(dayData["moonday"].intValue, moonSet: dayData["moonset"].doubleValue, moonRise: dayData["moonrise"].doubleValue)
                }
            }
        }
    }
    
    func getNewMoonDate() {
    
        Alamofire.request(.GET, serverAddress, parameters: ["t": "\(NSDate.init().timeIntervalSince1970)"]).responseJSON { response in
            
            if let JSON = response.result.value {

                _  = NSDate.init(timeIntervalSince1970:JSON["new_moon"] as! Double )
            }
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
