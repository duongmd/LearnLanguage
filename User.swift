//
//  User.swift
//  LearnLanguage
//
//  Created by PIRATE on 12/8/16.
//  Copyright © 2016 PIRATE. All rights reserved.
//

import Foundation

class User : NSObject {
    
    var id : String?
    var userName : String?
    var pass : String?
    
    
    init(login : [String : AnyObject]) {
        let id = login["id"] as? String
        self.id = id
        let userName = login["User"] as? String
        self.userName = userName
        let pass = login["Pass"] as? String
        self.pass = pass
        
    }
}
