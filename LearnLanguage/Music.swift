//
//  Music.swift
//  Language
//
//  Created by PIRATE on 11/15/16.
//  Copyright © 2016 PIRATE. All rights reserved.
//

import UIKit

class Music: BaseMediaViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tranparentNavigation = false
        self.title = "MUSIC"
       // print(self.title)
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: "Plus"), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: #selector(addMusic), for: .touchUpInside)
        
        let back = UIButton(type: .custom)
        back.setImage(UIImage(named: "Back-48"),for: .normal)
        back.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        back.addTarget(self, action: #selector(finished), for: .touchUpInside)
        
        
        let item1 = UIBarButtonItem(customView: btn1)
        let item2 = UIBarButtonItem(customView: back)
        self.navigationItem.setRightBarButtonItems([item1], animated: true)
        self.navigationItem.setLeftBarButtonItems([item2], animated: true)
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func finished()
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    func addMusic() {
        let addRecorder = ViewAddMusic(nibName: "ViewAddMusic", bundle: nil)
        self.navigationController?.pushViewController(addRecorder, animated: true)
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
