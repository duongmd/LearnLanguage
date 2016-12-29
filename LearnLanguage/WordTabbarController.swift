//
//  BaseTabbarController.swift
//  LearnLanguage
//
//  Created by iOS Student on 11/16/16.
//  Copyright © 2016 PIRATE. All rights reserved.
//

import UIKit

class WordTabbarController: UITabBarController {

    
    var languageid: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.barTintColor = UIColor(red: 119/255, green: 107/255, blue: 93/255, alpha: 1.0)
        self.tabBar.tintColor = UIColor.white
    }

    override func viewWillAppear(_ animated: Bool) {
        let wordList = WordList(nibName: "WordList", bundle: nil)
        let wordForget = WordListForget(nibName: "WordListForget", bundle: nil)
        
        wordList.languageid = languageid

        let wordListNav = BaseNavigationController(rootViewController: wordList)
        let wordForgetNav = BaseNavigationController(rootViewController: wordForget)
        
        viewControllers = [wordListNav, wordForgetNav]
        
        setNavForEachController(viewController: wordList, navTitle: "WORD LIST", tabbarTitle: "Word-List", image: "text_edit.png")
        setNavForEachController(viewController: wordForget, navTitle: "FORGET LIST", tabbarTitle: "Forget-List", image: "forget-icon")
        
        
        
    }
    
    func setNavForEachController(viewController: UIViewController, navTitle: String, tabbarTitle: String, image: String){
        viewController.navigationItem.title = navTitle
        viewController.tabBarItem = UITabBarItem(title: tabbarTitle, image: UIImage(named: image), selectedImage: nil)
        
    }

}
