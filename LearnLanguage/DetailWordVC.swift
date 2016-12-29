//
//  DetailWordVC.swift
//  LearnLanguage
//
//  Created by iOS Student on 11/29/16.
//  Copyright © 2016 PIRATE. All rights reserved.
//

import UIKit
import AVFoundation
class DetailWordVC: UIViewController {
    @IBOutlet weak var nameWord: UILabel!
    @IBOutlet weak var wordForm: UILabel!
    @IBOutlet weak var meanWord: UILabel!
    @IBOutlet weak var imgWord: UIImageView!

    var str1: String?
    var str2: String?
    var str3: String?
    var image: UIImage?
    var sound: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        self.nameWord.text = str1
        self.wordForm.text = str2
        self.meanWord.text = str3
        self.imgWord.image = image
        
    }

    @IBAction func btn_record(_ sender: AnyObject) {
        let soundURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("\(nameWord.text!).m4a")
        do {
        sound = try AVAudioPlayer(contentsOf: soundURL)
        } catch let err as NSError {
            print(err.localizedDescription)
        }
        sound?.play()
    }
   

}
