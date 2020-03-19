//
//  Image.swift
//  OutfitCheck
//
//  Created by Michelle Vasquez-Aleman on 3/19/20.
//  Copyright © 2020 Karla. All rights reserved.
//

import Foundation

struct Image: Codable {
    
    var content:String
    
    enum Codingkeys: String, CodingKey {
        case content = "content"
    }
    func encode(to encoder: Encoder) throws {
         var container = encoder.container(keyedBy: CodingKeys.self)
         try container.encode(self.content, forKey: .content)
         
       }
}
