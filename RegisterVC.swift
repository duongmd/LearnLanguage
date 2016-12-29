//
//  RegisterVC.swift
//  LearnLanguage
//
//  Created by PIRATE on 12/12/16.
//  Copyright © 2016 PIRATE. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController {

    @IBOutlet weak var notificationLB: UILabel!
    
    @IBOutlet weak var usernameTF: UITextField!
    
    @IBOutlet weak var paswordTF: UITextField!
    
    @IBOutlet weak var regiterAct: UIButton!
    
    @IBAction func backSignin(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        reLoad.getLoginRequest()
    }
    let reLoad = LoginVIew()
    @IBAction func registerAction(_ sender: Any) {
        if let name = usernameTF.text , let pass = paswordTF.text {
            if name != "" && pass != "" {
            createNewUser(name, pass: pass)
            dismiss(animated: true, completion: nil)
            reLoad.getLoginRequest()
            }
            else {
                notificationLB.text = "Dien day du thong tin"
                print("Ko du thong tin")
            }
        }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTF.borderStyle = .none
        usernameTF.layer.cornerRadius = 15
        
        paswordTF.borderStyle = .none
        paswordTF.layer.cornerRadius = 15
        
        regiterAct.layer.cornerRadius = 15
    }

    
    
    func createNewUser(_ name : String , pass : String) {
        let param :[String: AnyObject] = ["User": name as AnyObject , "Pass" : pass as AnyObject]
        
        let urlRequest = NSMutableURLRequest(url: Foundation.URL (string: URLSV )!)
        urlRequest.httpMethod = "POST"
        
        let configureSession = URLSessionConfiguration.default
        
        configureSession.httpAdditionalHeaders = ["Content-Type":"application/json"]
        
        let createNewUser = URLSession(configuration: configureSession)
        
        //Chuyen tu dictionary sang data de truyen
        let dataPassing = try!
        JSONSerialization.data(withJSONObject: param, options: JSONSerialization.WritingOptions.prettyPrinted)
        
        createNewUser.uploadTask(with: urlRequest as URLRequest, from: dataPassing, completionHandler: {(data, response ,error) in
            
            if let error = error {
                print(error.localizedDescription)
            }else {
                if let httpRespone = response as? HTTPURLResponse{
                    if httpRespone.statusCode == 200 {
              //          print("Data : \(data)")
                        
                        DispatchQueue.main.async(execute: {
                            self.reLoad.getLoginRequest()
                        })
                    } else {
                        print(httpRespone.statusCode)
                    }
                }
            }
            
        }).resume()
    }
   
}
