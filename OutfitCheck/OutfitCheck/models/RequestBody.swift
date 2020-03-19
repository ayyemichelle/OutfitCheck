//
//  RequestBody.swift
//  OutfitCheck
//
//  Created by Michelle Vasquez-Aleman on 3/19/20.
//  Copyright © 2020 Karla. All rights reserved.
//

import Foundation

struct RequestBody: Codable {
    
    var requests:[Request]
    
    enum CodingKeys: String, CodingKey {
        case requests = "requests"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.requests, forKey: .requests)
       
    }
    
    
    
}
