//
//  StudyVC.swift
//  Learning-Language
//
//  Created by iOS Student on 11/11/16.
//  Copyright © 2016 Duong. All rights reserved.
//

import UIKit

class StudyVC: UIViewController {
    
    var stringtitle: String?
    
    @IBOutlet weak var btn_word: UIButton!
    @IBOutlet weak var btn_media: UIButton!
    @IBOutlet weak var btn_test: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btn_word.layer.cornerRadius = 50
        self.btn_word.clipsToBounds = true
        
        self.btn_media.layer.cornerRadius = 50
        self.btn_media.clipsToBounds = true
        
        self.btn_test.layer.cornerRadius = 50
        self.btn_test.clipsToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = stringtitle
    }

    @IBAction func action_word(_ sender: AnyObject) {
        
        let tabbar = WordTabbarController()
        navigationController?.present(tabbar, animated: true, completion: nil)
    }
    
    @IBAction func action_media(_ sender: AnyObject) {
        
        let tabbarMedia = 
    }
 
    @IBAction func action_test(_ sender: AnyObject) {
    }
    
}
