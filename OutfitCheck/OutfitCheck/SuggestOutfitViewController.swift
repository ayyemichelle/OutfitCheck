//
//  SuggestOutfitViewController.swift
//  OutfitCheck
//
//  Created by Karla on 3/12/20.
//  Copyright © 2020 Karla. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

var suggestResult : [String : String] = [:]
var dayResult : [String : Any] = ["startTime": "", "endTime": "", "conditions": "", "temp": Double()]

class SuggestOutfitViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, CLLocationManagerDelegate {

    var locManager = CLLocationManager()
    var longitude: CLLocationDegrees = 0.0
    var latitude: CLLocationDegrees = 0.0
    var city: String = ""
    var currentCondition : String = ""
    var currentTemp : Double = 0.0
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var picker: UIPickerView!
    var pickerData : [String] = [String]()
    var occasion : String = ""
    
    @IBOutlet weak var startTimePicker: UIDatePicker!
    @IBOutlet weak var endTimePicker: UIDatePicker!
    
    
    // weather data
    let conditions: [String] = ["Clear", "Drizzle", "Snow", "Rain", "Clouds", "Thunderstorm"]
    
    // suggestion opions based on each attire type
    let casual = Attire.init(
    warm: ["top" : ["T-shirt"],
           "bottom" : ["Shorts/Skirt", "Jeans"],
           "shoes" : ["Sneakers", "Sandals"],
           "outerwear" : ["Cardigan", "Jacket"]],
    cool: ["top" : ["Sweater", "Long-sleeved Top"],
           "bottom" : ["Jeans", "Trousers"],
           "shoes" : ["Boots", "Sneakers"],
           "outerwear" : ["Jacket", "Coat"]])
    
    let business = Attire.init(
    warm: ["top" : ["Polo", "Dress Shirt", "Blouse"],
           "bottom" : ["Skirt/Trousers"],
           "shoes" : ["Flats/Loafers"],
           "outerwear" : ["Cardigan", "Blazer"]],
    cool: ["top" : ["Sweater", "Blouse", "Dress Shirt"],
           "bottom" : ["Trousers", "Pants"],
           "shoes" : ["Flats/Loafers"],
           "outerwear" : ["Blazer", "Coat"]])
    
    let athletic = Attire.init(
    warm: ["top" : ["T-shirt", "Tanktop"],
           "bottom" : ["Shorts", "Leggings"],
           "shoes" : ["Sneakers"],
           "outerwear" : ["Jacket"]],
    cool: ["top" : ["Sweater", "T-shirt"],
           "bottom" : ["Sweatpants", "Leggings"],
           "shoes" : ["Sneakers"],
           "outerwear" : ["Jacket"]])
    
    var resultOutfit : [String :  String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "DancingScript-Regular", size: 19) as Any]
        
        // Do any additional setup after loading the view.
        
        // get user's latitude and longitude
        locManager.requestWhenInUseAuthorization()
        if CLLocationManager.authorizationStatus() == .authorizedAlways || CLLocationManager.authorizationStatus() == .authorizedAlways {
            longitude = locManager.location?.coordinate.longitude ?? 0.0
            latitude = (locManager.location?.coordinate.latitude) ?? 0.0
        }
        
        sendOpenWeatherRequest()
        
        // connect data to picker
        self.picker.delegate = self
        self.picker.dataSource = self
        
        // input outfite categories
        pickerData = ["Casual", "Business", "Athletic"]
        
        let outputFormatter = DateFormatter()
        outputFormatter.timeZone = TimeZone.autoupdatingCurrent
    }
    
    @IBAction func onSuggestButton(_ sender: Any) {
        self.resultOutfit = ["top" : "",
                        "bottom" : "",
                        "shoes" : "",
                        "outerwear" : ""]
        
        let tempSetting = (currentTemp < 295.372) ? "cool" : "warm"
        
        switch(occasion) {
        case "Casual":
            if (tempSetting == "cool") {
                for (k, _) in self.resultOutfit {
                    self.resultOutfit[k] = self.casual.cool[k]?.randomElement() ?? self.casual.cool[k]?[0]
                }
            }
            else {
                for (k, _) in self.resultOutfit {
                    self.resultOutfit[k] = self.casual.warm[k]?.randomElement() ?? self.casual.warm[k]?[0]
                }
                
                if self.currentCondition == "Clear" {
                    self.resultOutfit["outerwear"] = "Not needed!"
                }
            }
        case "Business":
            if (tempSetting == "cool") {
                for (k, _) in self.resultOutfit {
                    self.resultOutfit[k] = self.business.cool[k]?.randomElement() ?? self.business.cool[k]?[0]
                }
            }
            else {
                for (k, _) in self.resultOutfit {
                    self.resultOutfit[k] = self.business.warm[k]?.randomElement() ?? self.business.warm[k]?[0]
                }
                
                if self.currentCondition == "Clear" {
                    self.resultOutfit["outerwear"] = "Not needed!"
                }
            }
        case "Athletic":
            if (tempSetting == "cool") {
                for (k, _) in self.resultOutfit {
                    self.resultOutfit[k] = self.athletic.cool[k]?.randomElement() ?? self.athletic.cool[k]?[0]
                }
            }
            else {
                for (k, _) in self.resultOutfit {
                    self.resultOutfit[k] = self.athletic.warm[k]?.randomElement() ?? self.athletic.warm[k]?[0]
                }
                
                if self.currentCondition == "Clear" {
                    self.resultOutfit["outerwear"] = "Not needed!"
                }
            }
        default:
            print("this shouldn't be printed")
        }
        
        suggestResult = self.resultOutfit
        print("\(occasion) \(self.resultOutfit)")
        
        let start = startTimePicker.date
        let end = endTimePicker.date
        
        let df = DateFormatter()
        df.dateFormat = "hh:mm a"
        
        dayResult["startTime"] = df.string(from: start)
        dayResult["endTime"] = df.string(from: end)
    }
    
    @IBAction func onBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        occasion = pickerData[row]
        return pickerData[row]
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
                
                if let weather = dataDictionary["weather"] as? [[String : Any]],
                    let cond = weather[0]["main"] {
                    self.currentCondition = cond as! String
                }
                
                if let temp = dataDictionary["main"] as? [String : Double],
                    let tempMax = temp["temp_max"], let tempMin = temp["temp_min"] {
                    self.currentTemp = (tempMax + tempMin) / 2.0
                }
                
                self.locationLabel.text =  dataDictionary["name"] as? String
                print(dataDictionary)
                
                dayResult["temp"] = self.currentTemp
                dayResult["conditions"] = self.currentCondition
            }
        }
        task.resume()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
