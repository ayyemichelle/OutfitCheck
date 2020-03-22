//
//  Attire.swift
//  OutfitCheck
//
//  Created by Alexis Vu on 3/21/20.
//  Copyright © 2020 Karla. All rights reserved.
//

import UIKit

class Attire {
    var warm: [String : [String]]
    var cool: [String : [String]]
    
    init(warm: [String : [String]], cool: [String : [String]]) {
        self.warm = warm
        self.cool = cool
    }
}
