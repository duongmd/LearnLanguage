//
//  DataLanguage.swift
//  Learning-Language
//
//  Created by PIRATE on 11/11/16.
//  Copyright © 2016 Duong. All rights reserved.
//

import UIKit

class DataLanguage {
    var nameLanguage : String!
    var annotation : String!
    var flag: String!
    
    init ( nameLanguage : String ,  annotation: String, flag: String) {
        self.annotation = annotation
        self.nameLanguage = nameLanguage
        self.flag = flag
    }
    
}
