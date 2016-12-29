//
//  BaseViewController.swift
//  Language
//
//  Created by PIRATE on 11/15/16.
//  Copyright © 2016 PIRATE. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    let tabbar = BaseTabbarController()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       // print(tabBarController?.selectedIndex)
    }
    
    // MARK: Setting Navigation Controller
    
    var shadowNavigationBar : Bool?{
        didSet{
            showShadown(shadowNavigationBar!)
        }
    }
    
       
    var tranparentNavigation : Bool?{
        didSet{
            if tranparentNavigation == true {
                setTransparentForNavigation()
            }else{
                defaulTranparentNavigation()
            }
            
        }
    }
    
    var navigationTitle :String?{
        didSet{
            guard let navTitle = navigationTitle else {return}
            
            changeTitleOfNavigationBar(navTitle)
        }
    }
    
    var backButtonTitle :String?{
        didSet{
            guard let title = backButtonTitle else {return}
            
            backButtonConfigure(title)
        }
    }
    
    fileprivate func setTransparentForNavigation(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    fileprivate func defaulTranparentNavigation (){
        
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = self.navigationController?.navigationBar.shadowImage
    }
    
    fileprivate func changeTitleOfNavigationBar(_ title: String){
        self.title = title
    }
    
    fileprivate func showShadown(_ show : Bool){
        if show {
            self.navigationController?.navigationBar.shadowImage = nil
        }else{
            self.navigationController?.navigationBar.shadowImage = UIImage()
        }
        
    }
    
    fileprivate func backButtonConfigure(_ title : String){
        
        let backButton = UIBarButtonItem()
        
        backButton.title = title
        
        navigationItem.backBarButtonItem = backButton
        
        //        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "Home")
        //        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "Home")
        
    }
    
    
    // MARK: Update Contraints
    
    func updateContraint(_ contraint : NSLayoutConstraint!){
        print(contraint.constant)
        
        let scale = UIScreen.main.bounds.size.height / 667
        
        contraint.constant = contraint.constant * scale
        
        print(contraint.constant)
    }
    
}
