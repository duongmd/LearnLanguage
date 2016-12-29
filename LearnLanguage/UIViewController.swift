//
//  UIViewControllerExtension.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 1/19/15.
//  Copyright (c) 2015 Yuji Hato. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

extension UIViewController {
    
//    func createMenuView() {
//
//        
//        
//        let leftViewController = LeftViewController(nibName: "LeftViewController", bundle: nil)
//        
//        let navigationBarApperace = UINavigationBar.appearance()
//        
//        navigationBarApperace.barTintColor = UIColor(red: 119/255, green: 107/255, blue: 93/255, alpha: 1.0)
//        navigationBarApperace.tintColor = UIColor.white
//        
//        navigationBarApperace.isTranslucent = false
//        
//        let mainview = TableLanguage(nibName: "TableLanguage", bundle: nil)
//        mainview.iduser = loginView.iduser
//        
//        let navi = BaseNavigationController(rootViewController: mainview)
//        let slideMenuController = SlideMenuController(mainViewController: navi, leftMenuViewController: leftViewController)
//        present(slideMenuController, animated: true, completion: nil)
//    }
    
    
    func setNavigationBarItem() {
        self.addLeftBarButtonWithImage(UIImage(named: "menu")!)
        // self.addRightBarButtonWithImage(UIImage(named: "ic_notifications_black_24dp")!)
        //        self.slideMenuController()?.removeLeftGestures()
        //        self.slideMenuController()?.removeRightGestures()
        //        self.slideMenuController()?.addLeftGestures()
        //        self.slideMenuController()?.addRightGestures()
    }
    
    func removeNavigationBarItem() {
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.rightBarButtonItem = nil
        //        self.slideMenuController()?.removeLeftGestures()
        //        self.slideMenuController()?.removeRightGestures()
    }
}
