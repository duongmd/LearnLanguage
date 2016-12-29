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
    var languageID: Int!
    @IBOutlet weak var btn_word: UIButton!
    @IBOutlet weak var btn_media: UIButton!
    @IBOutlet weak var btn_test: UIButton!
    
//    var aLetter = UIImageView()
    var animator = UIDynamicAnimator()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btn_word.alpha = 0
        self.btn_media.alpha = 0
        self.btn_test.alpha = 0
        
//        self.aLetter = UIImageView(frame: CGRect(x: 200, y: -20, width: 40, height: 40))
//        self.aLetter.image = UIImage(named: "Letter-A-icon")
//        self.view.addSubview(aLetter)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.btn_word.layer.cornerRadius = btn_word.bounds.size.width/2
        self.btn_word.clipsToBounds = true
        
        self.btn_media.layer.cornerRadius = btn_media.bounds.size.width/2
        self.btn_media.clipsToBounds = true
        
        self.btn_test.layer.cornerRadius = btn_test.bounds.size.width/2
        self.btn_test.clipsToBounds = true

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = stringtitle

        UIView.animate(withDuration: 0.5, delay: 0.3, options: .curveEaseInOut, animations: {
            self.btn_word.alpha = 1
     //       self.view.layoutIfNeeded()
            }, completion: nil)
        UIView.animate(withDuration: 0.5, delay: 0.3, options: .curveEaseInOut, animations: {
            self.btn_media.alpha = 1
    //        self.view.layoutIfNeeded()
            }, completion: nil)
        UIView.animate(withDuration: 0.5, delay: 0.3, options: .curveEaseInOut, animations: {
            self.btn_test.alpha = 1
      //      self.view.layoutIfNeeded()
            }, completion: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        animator = UIDynamicAnimator(referenceView: self.view)
//        let gravityBehavior = UIGravityBehavior(items: [self.aLetter])
//        animator.addBehavior(gravityBehavior)
//        
//        gravityBehavior.angle = 0.1       //Goc bay
//        gravityBehavior.magnitude = 1   //toc do bay
//        gravityBehavior.gravityDirection = CGVector(dx: -0.5, dy: 1)
    }

    
    @IBAction func action_word(_ sender: AnyObject) {

        let tabbar = WordTabbarController()
        tabbar.languageid = languageID
        
        tabbar.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
        navigationController?.present(tabbar, animated: true, completion: nil)
    }
    
    @IBAction func action_media(_ sender: AnyObject) {
        let tabbarMedia = MediaTabbarController()
        tabbarMedia.languageID = self.languageID
        
        tabbarMedia.modalTransitionStyle = UIModalTransitionStyle.partialCurl

        present(tabbarMedia, animated: true, completion: nil)
        
    }
 
    @IBAction func action_test(_ sender: AnyObject) {
        let testVC = TestVC(nibName: "TestVC", bundle: nil)
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionMoveIn

        self.navigationController!.view.layer.add(transition, forKey: nil)
        
        navigationController?.pushViewController(testVC, animated: false)
        
    }
    
}
