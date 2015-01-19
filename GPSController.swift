//
//  GPSController.swift
//  Test
//
//  Created by Yongbo on 1/19/15.
//  Copyright (c) 2015 Yongbo. All rights reserved.
//

import Foundation
import CoreLocation

//examples: http://dev.iachieved.it/iachievedit/corelocation-on-ios-8-with-swift/
//http://nshipster.com/core-location-in-ios-8/

class GPSController:NSObject, CLLocationManagerDelegate{
    ///Singleton design model of location controller
    struct Static {
        static let instance = GPSController()
    }
    class var sharedInstance:GPSController{
        return Static.instance
    }
    
    
    
    var locationManager:CLLocationManager = CLLocationManager()
    ///Init GPSController
    override init(){
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        self.locationManager.pausesLocationUpdatesAutomatically = false ///Ask for always updating location service
        self.locationManager.requestAlwaysAuthorization()
        
        ///Observe GPS status change
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "stopGPS", name: "GPS_STOP", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "runGPS", name: "GPS_RUN", object: nil)
        
    }
    
    
    func runGPS(notification:NSNotification) -> Void{
        //if(locationManager)
        if(CLLocationManager.locationServicesEnabled()){
            self.locationManager.startUpdatingLocation()
        }else{
            self.locationManager.requestAlwaysAuthorization()
        }
        
    }
    func stopGPS(notificaton:NSNotification) -> Void{
        locationManager.stopUpdatingLocation()
    }
    
    ///Handle Authorization Changed
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        println("didChangeAuthorizationStatus")
        
        switch status {
        case .NotDetermined:
            println(".NotDetermined")
            self.locationManager.requestAlwaysAuthorization()
            break
            
        case .Authorized:
            println(".Authorized")
            self.locationManager.startUpdatingLocation()
            break
            
        case .Denied:
            println(".Denied")
            self.locationManager.requestAlwaysAuthorization()
            break
            
        default:
            println("Unhandled authorization status")
            break
        }
    }
    
    ///Handle location updating
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        let location = locations.last as CLLocation
        
        println("didUpdateLocations:  \(location.coordinate.latitude), \(location.coordinate.longitude)")
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, e) -> Void in
            if let error = e {
                println("Error:  \(e.localizedDescription)")
            } else {
                let placemark = placemarks.last as CLPlacemark
                
                let userInfo = [
                    "city":     placemark.locality,
                    "state":    placemark.administrativeArea,
                    "country":  placemark.country
                ]
                
                println("Location:  \(userInfo)")
                
                NSNotificationCenter.defaultCenter().postNotificationName("LOCATION_AVAILABLE", object: nil, userInfo: userInfo)
                
            }
        })
        
        self.sendGPSToServer(location)
    }
    
    func sendGPSToServer(location:CLLocation){
        var params = [
            "lat": location.coordinate.latitude,
            "lng": location.coordinate.longitude
        ]
        //println(manager.location)
        
        //Alamofire.request(.GET, "https://djwong.net/driver/gps", parameters: params)
        //    .responseJSON{ (request, response, data, error) in
        //}
        
        var prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults();
        prefs.setObject(location.timestamp, forKey: "lastUpdated")

    }

    
    

}
