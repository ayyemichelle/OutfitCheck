//
//  Feature.swift
//  OutfitCheck
//
//  Created by Michelle Vasquez-Aleman on 3/19/20.
//  Copyright © 2020 Karla. All rights reserved.
//

import Foundation

struct Feature : Codable {
    let type:String
    let maxResults:Int
    enum CodingKeys: String, CodingKey {
      case type = "type"
      case maxResults = "maxResults"
    }
    
    func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: CodingKeys.self)
      try container.encode(self.type, forKey: .type)
      try container.encode(self.maxResults, forKey: .maxResults)
    }
}
