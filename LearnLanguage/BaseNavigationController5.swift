//
//  BaseNavigationControllerViewController.swift
//  Language
//
//  Created by PIRATE on 11/15/16.
//  Copyright © 2016 PIRATE. All rights reserved.
//

import UIKit

class BaseMediaNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.black , NSFontAttributeName:UIFont.boldSystemFont(ofSize: 20)]
        
        
        navigationBar.tintColor = UIColor.black
    }
}
