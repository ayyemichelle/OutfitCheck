//
//  GoogleVisionAPICaller.swift
//  OutfitCheck
//
//  Created by Michelle Vasquez-Aleman on 3/19/20.
//  Copyright © 2020 Karla. All rights reserved.
//

import Foundation
import Alamofire

var imageResults = [[String : Any]]()

class GoogleVisionAPI {
        
    static func annotateImageRequest(encodedImage: String) {
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
        let k = Keys.google.rawValue
        let url = "https://vision.googleapis.com/v1/images:annotate?key=\(k)"
        
        let group = DispatchGroup()
        
        Alamofire.request(url, method: .post, parameters: requests, encoding: JSONEncoding.default, headers: [:]).responseJSON {
            (response) in
            switch response.result {
                case .success(_):
                    group.enter()
                    if let data = response.result.value as? [String : Any],
                        let labels = data["responses"] as? [[String : Any]] {
                        imageResults = labels[0]["labelAnnotations"] as! [[String : Any]]
                }
                      
                case .failure(let error):
                    print(error)
            }
            
            group.leave()
        }
        
        group.notify(queue: .main) {
            print("request finished")
        }
    }
}
