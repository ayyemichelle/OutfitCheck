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

class SuggestOutfitViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, CLLocationManagerDelegate {

    var longitude: CLLocationDegrees = 0.0
    var latitude: CLLocationDegrees = 0.0
    var city: String = ""
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var picker: UIPickerView!
    var pickerData : [String] = [String]()
    var occasion : String = ""
    
    @IBOutlet weak var startTimePicker: UIDatePicker!
    @IBOutlet weak var endTimePicker: UIDatePicker!
    
    // weather data
    let conditions: [String] = ["Clear", "Drizzle", "Snow", "Rain", "Clouds", "Thunderstorm"]
    var currentCondition : String = ""
    var currentTemp : Double = 0.0
    
    // suggestion opions based on each attire type
    let casual = Attire.init(
    warm: ["top" : ["t-shirt"],
           "bottom" : ["shorts/skirt", "jeans"],
           "shoes" : ["sneakers", "sandal"],
           "outerwear" : ["cardigan", "jacket"]],
    cool: ["top" : ["sweater"],
           "bottom" : ["jeans", "trousers"],
           "shoes" : ["boot", "sneakers"],
           "outerwear" : ["jacket", "coat"]])
    
    let business = Attire.init(
    warm: ["top" : ["polo shirt", "dress shirt", "blouse"],
           "bottom" : ["skirt/trousers"],
           "shoes" : ["flats/loafers"],
           "outerwear" : ["cardigan", "blazer"]],
    cool: ["top" : ["sweater", "blouse", "dress shirt"],
           "bottom" : ["trousers", "pants"],
           "shoes" : ["flats/loafers"],
           "outerwear" : ["blazer", "coat"]])
    
    let athletic = Attire.init(
    warm: ["top" : ["t-shirt", "tanktop"],
           "bottom" : ["shorts", "leggings"],
           "shoes" : ["sneakers"],
           "outerwear" : ["jacket"]],
    cool: ["top" : ["sweater", "t-shirt"],
           "bottom" : ["sweatpants", "leggings", "yoga pant", "active pants"],
           "shoes" : ["sneakers", "footwear", "sock"],
           "outerwear" : ["jacket"]])
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "DancingScript-Regular", size: 19) as Any]
        // Do any additional setup after loading the view.
            // OccasionPicker.delegate = self
        sendOpenWeatherRequest()
        //print(city)
        
        // connect data to picker
        self.picker.delegate = self
        self.picker.dataSource = self
        
        // input outfite categories
        pickerData = ["Casual", "Business", "Athletic"]
    }
    
    @IBAction func onSuggestButton(_ sender: Any) {
        // use predefined outfit models for each attire type
        switch(occasion)
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
                
                self.locationLabel.text =  dataDictionary["name"] as? String
                print(dataDictionary)
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
