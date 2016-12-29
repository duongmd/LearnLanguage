//
//  ViewAddVideo.swift
//  Language
//
//  Created by PIRATE on 11/16/16.
//  Copyright © 2016 PIRATE. All rights reserved.
//

import UIKit

//protocol getLanguageID {
//    var languageid : Int {get set}
//    
//}

class ViewAddVideo: UIViewController {
    
    var backTableVideo : Video!
    var database = DataBase.sharedInstance
     var languageID: Int!
    @IBOutlet weak var titleAddVideo: UITextField!
    
    
    @IBOutlet weak var lyricAddVideo: UITextField!
    
    @IBOutlet weak var linkAddVideo: UITextField!
    
    @IBOutlet weak var butAddVideo: UIButton!
    
    @IBAction func actAddVIdeo(_ sender: Any) {
        backTableVideo = Video(nibName: "Video", bundle: nil)
       print(languageID)
        database.insertDataBase("Video", dict: ["LanguageID": "\(languageID!)" , "VideoName": titleAddVideo.text! , "Sub" : lyricAddVideo.text! , "Link" : linkAddVideo.text!])
    
        _ = self.navigationController?.popViewController(animated: true)
        
    }
    
       override func viewDidLoad() {
        super.viewDidLoad()
       // print(languageID!)
        //print(UserDefaults.standard.string(forKey: "Key")!)


        butAddVideo.layer.cornerRadius = 30
        
        
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
