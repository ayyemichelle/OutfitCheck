//
//  OutfitCheckViewController.swift
//  OutfitCheck
//
//  Created by Karla on 3/12/20.
//  Copyright © 2020 Karla. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import AlamofireImage

class OutfitCheckViewController: UIViewController, CLLocationManagerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var longitude: CLLocationDegrees = 0.0
    var latitude: CLLocationDegrees = 0.0
    
    // pickers
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var startTimePicker: UIDatePicker!
    @IBOutlet weak var endTimePicker: UIDatePicker!
    
    // picker data
    var pickerData : [String] = [String]()
    var occasion : String = ""
    
    // image picker
    var imagePicker = UIImagePickerController()
    var img: UIImage!
    
    // weather data
    let conditions: [String] = ["Clear", "Drizzle", "Snow", "Rain", "Clouds", "Thunderstorm"]
    
    // might make seperate temperature object for info, if keeping both start time/end time forecasts
    // TBD
    var currentCondition : String = ""
    var currentTemp : Double = 0.0
    
    // Attire objects (info can be found in Attire.swift)
    let casual = Attire.init(
        warm: ["top" : ["t-shirt", "camisoles", "blouse", "sleeveless"],
               "bottom" : ["shorts", "skirt", "jeans", "miniskirt", "skort", "dress", "denim", "trousers"],
               "shoes" : ["sneakers", "sandal", "ballet flat", "high heels", "mary jane"],
               "outerwear" : ["outerwear", "cardigan", "jacket"]],
        cool: ["top" : ["sweater", "sleeve", "outerwear"],
               "bottom" : ["jeans", "trousers", "pants", "leggings", "denim"],
               "shoes" : ["boot", "sneakers", "oxford shoe", "mary jane"],
               "outerwear" : ["jacket", "coat", "outerwear", "blazer", "trench coat", "overcoat"]])
    
    let business = Attire.init(
        warm: ["top" : ["polo shirt", "t-shirt", "dress shirt", "blouse"],
               "bottom" : ["skirt", "pants", "pencil skirt", "skort", "dress", "trousers"],
               "shoes" : ["sandal", "ballet flat", "high heels", "mary jane", "oxford shoe"],
               "outerwear" : ["outerwear", "cardigan", "blazer"]],
        cool: ["top" : ["sweater", "sleeve", "suit", "blouse", "dress shirt"],
               "bottom" : ["trousers", "pants"],
               "shoes" : ["ballet flat", "high heels", "mary jane", "oxford shoe"],
               "outerwear" : ["outerwear", "blazer", "coat", "overcoat", "trench coat"]])
    
    let athletic = Attire.init(
        warm: ["top" : ["crop top", "t-shirt", "undergarment", "camisoles", "sleeveless", "active top", "jersey"],
               "bottom" : ["yoga pant", "shorts", "leggings", "active pants"],
               "shoes" : ["sneakers", "footwear", "sock"],
               "outerwear" : ["outerwear", "jacket"]],
        cool: ["top" : ["hood", "sleeve", "sweater", "outerwear", "t-shirt"],
               "bottom" : ["sweatpant", "leggings", "yoga pant", "active pants"],
               "shoes" : ["sneakers", "footwear", "sock"],
               "outerwear" : ["outerwear", "jacket"]])
    
    // outfit suggestion result
    var resultOutfit : [String :  String] = [:]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "DancingScript-Regular", size: 19) as Any]
        sendOpenWeatherRequest()
        
        self.picker.delegate = self
        self.picker.dataSource = self
        
        pickerData = ["Casual", "Business", "Athletic"]
    }
      
      func sendOpenWeatherRequest(){
          let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=2cf95422cb657b66ba44c983634b53a2")!
        print(url)
                      
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
       }
    
    @IBAction func onTakePictureButton(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            present(imagePicker, animated:true)
        }
    }
    
    @IBAction func onUploadPictureButton(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false

            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    // why don't we use the func above?
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageScaled(to: size)
        
        // convert image to base 64
        let imageData: NSData =  scaledImage.pngData()! as NSData
        let encodedImageString = imageData.base64EncodedString(options: .lineLength64Characters)
        
        // send api request
        GoogleVisionAPI.annotateImageRequest(encodedImage: encodedImageString)
        
        dismiss(animated: true, completion: nil)
    }
    
    func computeOutfit() {
        /**
         1.Get occasion from picker (done)
         2. Get current weather
         3. Get image from user, process with API, send results back for processing
         */
        
        let temp = (currentTemp < 72.0) ? "cool" : "warm"
        
        // dictionary mapping if apparel type was accounted for, will tell us
        // which categories we need to generate a suggestion
        // keys mapped as True can be displayed as good to go in result controller
        var results : [String : Bool]
        
        // reset resultOutfit to empty
        resultOutfit = ["top" : "",
        "bottom" : "",
        "shoes" : "",
        "outerwear" : ""]

        switch(occasion) {
            case "Casual":
                results = processImage(attire : casual, temp : temp)
                
                for (key, value) in results {
                    if (value == true) {
                        resultOutfit[key] = nil
                    }
                    else {
                        print("pick a suggestion and load it into resultOutfit[key]")
                        // i repeated this loop in each branch cause we'll already
                        // know which attire object to suggest from since we're alr in branch
                    }
                }
            case "Business":
                results = processImage(attire : business, temp : temp)
                
                for (key, value) in results {
                    if (value == true) {
                        resultOutfit[key] = nil
                    }
                    else {
                        print("pick a suggestion and load it into resultOutfit[key]")
                        
                    }
                }
            case "Athletic":
                results = processImage(attire : athletic, temp : temp)
                
                for (key, value) in results {
                    if (value == true) {
                        resultOutfit[key] = nil
                    }
                    else {
                        print("pick a suggestion and load it into resultOutfit[key]")
                        
                    }
                }
            default:
                print("this shouldn't be printed")
            }
    }
    
    func processImage(attire : Attire, temp : String) -> [String : Bool]{
        /**
         1. Get tags from API
         2. For each key, see if at least one value appears in image, if so set True at key
         3. For any key that had 0 matches, flag as False (missing)
         4. Otherwise, if match found flag as True, continue to next key iteration
         */
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
