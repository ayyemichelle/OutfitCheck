//
//  ViewController.swift
//  OutfitCheck
//
//  Created by Karla on 3/11/20.
//  Copyright © 2020 Karla. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class WelcomeViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    var longitude: CLLocationDegrees = 0.0
    var latitude: CLLocationDegrees = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // API call to Open Weather API - need to move to correct view controller
        // get user's location
        locationManager.delegate = self
        // Authorization from the user
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        //print("longitude: \(longitude) & latitude: \(latitude)" )
        
        // use user's location to make call to API
      
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
     
        
       let locValue = manager.location?.coordinate
        
       longitude = locValue!.longitude
       latitude = locValue!.latitude
        
       locationManager.stopUpdatingLocation()
        print("updated location")
       
        
    }
    
    
       // MARK: - Navigation

       // In a storyboard-based application, you will often want to do a little preparation before navigation
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           // Get the new view controller using segue.destination.
           // Pass the selected object to the new view controller.
            if(segue.identifier == "suggestOutfit"){
                let nav = segue.destination as! UINavigationController
                let suggestOutfitViewController = nav.topViewController as! SuggestOutfitViewController
                suggestOutfitViewController.latitude = latitude
                suggestOutfitViewController.longitude = longitude
            }else if(segue.identifier == "outfitCheck"){
                let nav = segue.destination as! UINavigationController
                let outfitCheckViewController = nav.topViewController as! OutfitCheckViewController
                outfitCheckViewController.latitude = latitude
                outfitCheckViewController.longitude = longitude
            }
       }
       

    
}

