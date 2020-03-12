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


class ViewController: UIViewController, CLLocationManagerDelegate {

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
       sendOpenWeatherRequest()
        
    }
    
    func sendOpenWeatherRequest(){
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=2cf95422cb657b66ba44c983634b53a2")!
                    
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                // data is contained in this dictionary
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                
                //self.movies = dataDictionary["results"] as! [[String:Any]] // need to cast as array of dictionaries
                
                
                print(dataDictionary)
                
                
            }
        }
        task.resume()
    }

    
}

