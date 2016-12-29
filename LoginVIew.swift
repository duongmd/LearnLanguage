//
//  LoginVIew.swift
//  LearnLanguage
//
//  Created by PIRATE on 12/6/16.
//  Copyright © 2016 PIRATE. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift
 
let URLSV : String! = "http://localhost:2403/learnenglish"


class LoginVIew: UIViewController  {
    
    var defaults = UserDefaults.standard

    var informations = [User]()
    
    var login = false
    var inforUserSV = [ String : AnyObject]()
    @IBOutlet weak var usernameT: UITextField!
    
    @IBOutlet weak var annotaionText: UILabel!
    @IBOutlet weak var passT: UITextField!
    
    @IBAction func registerAct(_ sender: Any) {
        let registerView = RegisterVC(nibName: "RegisterVC", bundle: nil)
        present(registerView, animated: true, completion: nil)
    }
    @IBAction func loginAct(_ sender: Any) {
       
 //       print(informations.count)
        
        for i in 0...(informations.count - 1) {
            let person = informations[i]
            if checkLogin(person) == true {
                break
            }
        }
        if login == true {
        
           createMenuView()
        }
        else {
            annotaionText.text = "Kiem tra lai tai khoan dang nhap"
        }
    }
    
    func createMenuView() {
        
       
        let leftViewController = LeftViewController(nibName: "LeftViewController", bundle: nil)
        
        let navigationBarApperace = UINavigationBar.appearance()
        
        navigationBarApperace.barTintColor = UIColor(red: 119/255, green: 107/255, blue: 93/255, alpha: 1.0)
        navigationBarApperace.tintColor = UIColor.white
        
        navigationBarApperace.isTranslucent = false
        
        let mainview = TableLanguage(nibName: "TableLanguage", bundle: nil)
      //  mainview.iduser = iduser
   //     mainview.user = User(login: ["id":user.id as AnyObject,"User":usernameT.text as AnyObject,"Pass":passT.text as AnyObject])
   //     print(iduser!)
        let navi = BaseNavigationController(rootViewController: mainview)
        let slideMenuController = SlideMenuController(mainViewController: navi, leftMenuViewController: leftViewController)
        
        present(slideMenuController, animated: true, completion: nil)
    }
    
    func checkLogin(_ user : User) -> Bool
    {
        
        if user.userName == usernameT.text && user.pass == passT.text {
                login = true

            defaults.set(user.id, forKey: "idUser")
            
        }
        
        return login
    }
    
    
    
    @IBOutlet weak var loginBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        loginBtn.layer.cornerRadius = 10
        loginBtn.clipsToBounds = true
        
        usernameT.layer.cornerRadius = 15
        usernameT.clipsToBounds = true
        
        passT.layer.cornerRadius = 15
        passT.clipsToBounds = true
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "LEARNING LANGUAGE"
        
        informations.removeAll()
        getLoginRequest()
        
        
    }
    
    //Lay du lieu tren server ve
    func getLoginRequest() {
        
        let urlRequest = URLRequest(url: Foundation.URL(string: URLSV)!)    //Default la phuong thuc GET, ko phai set http method nua
        
        let session = URLSession.shared     //goi singleton
        
        session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in  //tra ve 3 gia tri (data, response, error)
            
            //kiem tra co loi tra ve ko
            if let error = error {
                print(error.localizedDescription)
            }else{
                if let responseHTTP = response as? HTTPURLResponse{
                    if responseHTTP.statusCode == 200{  //Da gui thanh cong request den server
                        guard let infoUser = data else {return}
                        
                        do{
                            //chuyen data tu dang NSdata ve Json
                            let result = try JSONSerialization.jsonObject(with: infoUser, options: JSONSerialization.ReadingOptions.allowFragments)
                            // print(result)
                            
                            if let arrayResult : AnyObject = result as AnyObject? {
                                for infoDict in arrayResult as! [AnyObject]{
                                    if let infoDict = infoDict as? [String : AnyObject]{
                                        // print(infoDict)
                                        self.inforUserSV = infoDict
                                  //      print(self.inforUserSV)
                                        self.informations.append(User.init(login: infoDict))
                                       
//                                        DispatchQueue.main.async(execute: {
//                                           
//                                        })
                                        
                                    }else{
                                        
                                    }
                                }
                            }
                            
                        } catch let error as NSError {
                            print(error.description)
                        }
                    } else {
                        print(responseHTTP.statusCode)
                    }
                }
            }
        }) .resume()
        
        
        
        
        
    }
}
