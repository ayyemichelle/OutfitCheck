//
//  Request.swift
//  OutfitCheck
//
//  Created by Michelle Vasquez-Aleman on 3/19/20.
//  Copyright © 2020 Karla. All rights reserved.
//

import Foundation

struct Request: Codable {
    let image: Image
    let features: [Feature]
    
    enum CodingKeys: String, CodingKey {
        
        case features = "features"
        case image = "image"
    }
    
    
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.image, forKey: .image)
        try container.encode(self.features, forKey: .features)
    
    }
}
