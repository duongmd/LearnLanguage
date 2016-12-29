//
//  ViewAddMusic.swift
//  Language
//
//  Created by PIRATE on 11/16/16.
//  Copyright © 2016 PIRATE. All rights reserved.
//

import UIKit

class ViewAddMusic: BaseMediaViewController {

    @IBOutlet weak var titleAddMusic: UITextField!
    
    @IBOutlet weak var LyricAddMusic: UITextField!
    
    @IBOutlet weak var linkAddMusic: UITextField!
    
    
    @IBAction func AddMusic(_ sender: Any) {
        
    }
    
    @IBOutlet weak var butAdd: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        butAdd.layer.cornerRadius = 30
        self.title = "ADD RECORDER"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
