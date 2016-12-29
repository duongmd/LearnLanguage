//
//  BaseTabbarController.swift
//  Language
//
//  Created by PIRATE on 11/15/16.
//  Copyright © 2016 PIRATE. All rights reserved.
//

import UIKit

class MediaTabbarController: UITabBarController , UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        tabBar.barStyle = .blackOpaque
        //tabBar.barTintColor = UIColor(red: 0.149, green: 0.2, blue: 0.255, alpha: 1.0)
        tabBar.barTintColor = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1.0)

        
      //  UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.white,NSFontAttributeName : UIFont(name: "SFUIText-Regular", size: 12)!],for: UIControlState())
        tabBar.isTranslucent = false

            }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        let recorderVC  = Recorder(nibName: "Recorder", bundle: nil)
        
        let musicVC = Music(nibName: "Music", bundle: nil)
        let videoVC = Video(nibName: "Video", bundle: nil)
        
        let recorderNav = BaseNavigationController(rootViewController: recorderVC)
        let musicNav = BaseNavigationController(rootViewController: musicVC)
        let videoNav = BaseNavigationController(rootViewController: videoVC)
        
        
        settingNavForEachController(recorderVC, transparent: true, navTitle: "RECORDER", shadow: true, tabbarTitle: "Recorder", image: "Recorder.png", selectedImage: "")
        
        settingNavForEachController(videoVC, transparent: true, navTitle: "VIDEO", shadow: true, tabbarTitle: "Video",image: "Video.png", selectedImage: "")
        
        settingNavForEachController(musicVC, transparent: true, navTitle: "MUSIC", shadow: true, tabbarTitle: "Music", image: "Music.png", selectedImage: "")
        
        viewControllers = [recorderNav,musicNav,videoNav]
    }
    
    func settingNavForEachController(_ viewcontroller : BaseViewController, transparent : Bool, navTitle : String, shadow : Bool, tabbarTitle : String, image : String, selectedImage : String)
    {
        viewcontroller.navigationItem.title = navTitle
        
        viewcontroller.tabBarItem = UITabBarItem(title: tabbarTitle,
                                                 image: UIImage(named: image)?.withRenderingMode(.alwaysOriginal),
                                                 selectedImage: UIImage(named: selectedImage)?.withRenderingMode(.alwaysOriginal))
        
        viewcontroller.tranparentNavigation = transparent
        viewcontroller.shadowNavigationBar = shadow
    }
    

    
    }
