//
//  BaseNavigationController.swift
//  LearnLanguage
//
//  Created by iOS Student on 11/16/16.
//  Copyright © 2016 PIRATE. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
    }

 
}
