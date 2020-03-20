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
    
    var pickerData : [String] = [String]()
    
    // image picker
    var imagePicker = UIImagePickerController()
    var img: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "DancingScript-Regular", size: 19) as Any]
        sendOpenWeatherRequest()
        
        self.picker.delegate = self
        self.picker.dataSource = self
        
        pickerData = ["Casual", "Business", "Formal", "Athletic"]
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
           return pickerData[row]
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
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!) {
        picker.dismiss(animated: true)
        img = image
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageScaled(to: size)
        print(img.size)
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
