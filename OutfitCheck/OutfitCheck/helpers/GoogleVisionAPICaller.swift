//
//  GoogleVisionAPICaller.swift
//  OutfitCheck
//
//  Created by Michelle Vasquez-Aleman on 3/19/20.
//  Copyright © 2020 Karla. All rights reserved.
//

import Foundation

class GoogleVisionAPI {
    
    static func annotateImageRequest(encodedImage: String){
        print("calling request")
        let feature = Feature(type: "IMAGE_PROPERTIES", maxResults: 10)
        let image = Image(content: encodedImage)
        let request = Request(image: image, features: [feature])
        let requestBody = RequestBody(request: [request])
        
        // to json
        let jsonEncoder = JSONEncoder()
        let jsonData = try! jsonEncoder.encode(requestBody)
        

       let str = String(data: jsonData, encoding: .utf8)
        print(str)
        
        
       // let json = String(data: jsonData!, encoding: String.Encoding.utf8)
        //print(json)
    }
}
