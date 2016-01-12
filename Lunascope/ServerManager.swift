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
    
    
     struct MoonSetRiseParams {
        var day: Int
        var month: Int
        var year: Int
        var lat: Double
        var lon: Double
    
    }
    
    static let sharedInstance = ServerManager()
    let serverAddress = "http://lab.ace-solutions.ru/moon/"
    
    
    
    
    func getNewMoonDate() {
    
        Alamofire.request(.GET, serverAddress, parameters: ["t": "\(NSDate.init().timeIntervalSince1970)"]).responseJSON { response in
            
            if let JSON = response.result.value {

                let dateNewMoon  = NSDate.init(timeIntervalSince1970:JSON["new_moon"] as! Double )
                self.createLunarMonthByNewMoonDate(dateNewMoon)
            }
        }
    }
    
    func getNewMoonRiseSet(param : MoonSetRiseParams, dayNumber : Int) {
        
        let params = ["day":"\(param.day)",
                    "month":"\(param.month)",
                     "year":"\(param.year)",
                      "lat":"\(param.lat)",
                      "lon":"\(param.lon)",]
        
        Alamofire.request(.GET, serverAddress, parameters: params).responseJSON { response in
            
            if let JSON = response.result.value {
                
                let moonSet  = NSDate.init(timeIntervalSince1970:JSON["moonrise"] as! Double )
                let moonRise  = NSDate.init(timeIntervalSince1970:JSON["moonset"] as! Double )
                
                DataManager.sharedInstance.createDay(dayNumber, moonSet: moonSet, moonRise: moonRise);
            }
        }
    }
    
    func createLunarMonthByNewMoonDate(newMoonDate : NSDate) {
        
        
        
        var curDate = newMoonDate
        let daysToAdd = 1.0;
        
        
        for index in 1...32 {
            curDate = curDate.dateByAddingTimeInterval((60*60*24*daysToAdd) as Double)
            
            let calendar = NSCalendar.currentCalendar()
            let components = calendar.components([.Day , .Month , .Year], fromDate: curDate)
            
            let year =  components.year
            let month = components.month
            let day = components.day
            let defaults = NSUserDefaults.standardUserDefaults()
            
            let paramsDay = MoonSetRiseParams.init(day: day, month: month, year: year, lat: defaults.doubleForKey("lat"), lon: defaults.doubleForKey("lat"))
            
            getNewMoonRiseSet(paramsDay, dayNumber: index)

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
