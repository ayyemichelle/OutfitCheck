//
//  GoogleVisionAPICaller.swift
//  OutfitCheck
//
//  Created by Michelle Vasquez-Aleman on 3/19/20.
//  Copyright © 2020 Karla. All rights reserved.
//

import Foundation
import Alamofire

class GoogleVisionAPI {
        
    static func annotateImageRequest(encodedImage: String){
        print("calling request")
       /* let feature = Feature(type: "IMAGE_PROPERTIES", maxResults: 10)
        let image = Image(content: "")
        let request = Request(image: image, features: [feature])
        let requestBody = RequestBody(requests: [request])*/
        
        let feature1 = ["type": "LABEL_DETECTION", "maxResults": 50] as [String : Any]

        let features = [feature1]
        let image = ["content": encodedImage]
        let request = ["image": image, "features": features] as [String : Any]
        let requests = ["requests": [request]]
        let url = "https://vision.googleapis.com/v1/images:annotate?key=AIzaSyCfco-EYtj2rFBxF9VEq9xQu7QXVKtFcTY"
        
        
        Alamofire.request(url, method: .post, parameters: requests, encoding: JSONEncoding.default, headers: [:]).responseJSON { (response) in
            switch response.result {
                case .success(let data):
                    print("data", data)
                    print(response.result)
                  
                case .failure(let error):
                    print(error)
              
                }
        }
        
    }
}
