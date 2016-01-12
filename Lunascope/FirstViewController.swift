//
//  FirstViewController.swift
//  Lunascope
//
//  Created by Андрей Кропотов on 12/30/15.
//  Copyright © 2015 ACE Solutions. All rights reserved.
//

import UIKit
import CoreLocation

class FirstViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        let serverManager = ServerManager.sharedInstance;
        serverManager.getNewMoonDate();
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

   

    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
    }
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        defaults.setDouble(locValue.latitude, forKey: "lat")
        defaults.setDouble(locValue.longitude, forKey: "long")
        defaults.synchronize()
        
        
        
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        locationManager.stopUpdatingLocation();
        
    }


}

