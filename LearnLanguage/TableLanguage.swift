//
//  TableLanguage.swift
//  Learning-Language
//
//  Created by PIRATE on 11/11/16.
//  Copyright © 2016 Duong. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift


class TableLanguage: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var defaults = UserDefaults.standard
    
  //  var iduser: String!
    var db = [NSDictionary]()
    @IBOutlet weak var tbvLanguage: UITableView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "LANGUAGE"
     //   print(iduser!)
        let nib = UINib(nibName: "Cell", bundle: nil)
        self.tbvLanguage.register(nib, forCellReuseIdentifier: "Cell")
        
        let menu = UIButton(type: .custom)
        menu.setImage(UIImage(named: "menu"), for: .normal)
        menu.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        menu.addTarget(self, action: #selector(addLanguage1), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: menu)
        self.navigationItem.setLeftBarButton(item1, animated: true)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addLanguage1))
        
    
        // xoa dong ke trong tableview
        self.tbvLanguage.separatorStyle = .none
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setNavigationBarItem()
        
        let iduser = defaults.object(forKey: "idUser")
        
        let database = DataBase.sharedInstance
     //   print(iduser)
        db = database.viewDatabase("LANGUAGE", columns: ["*"], statement: "where IdUser = '\(iduser!)'")

        print(db)
 
        
        tbvLanguage.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
      
    }
    
    
    func addLanguage1() {
        var AddLanguage : addLanguage!
        AddLanguage = addLanguage(nibName: "addLanguage", bundle: nil)
        
        self.navigationController?.pushViewController(AddLanguage, animated: true)
     
    }
    

    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return db.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
        UIView.animate(withDuration: 0.5, animations: {
            cell.layer.transform = CATransform3DMakeScale(1.05,1.05,1)
            },completion: { finished in
                UIView.animate(withDuration: 0.3, animations: {
                    cell.layer.transform = CATransform3DMakeScale(1,1,1.5)
                })
        })
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     //   let cell = Bundle.main.loadNibNamed("Cell", owner: self, options: nil)?.first as! Cell
       let cell = tbvLanguage.dequeueReusableCell(withIdentifier: "Cell") as! Cell
        let item = db[indexPath.row] as! [String:Any]
        cell.name.text = item["LanguageName"] as? String
        
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        if let dirPath = paths.first
        {
            let image = item["LanguageName"] as! String
            let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent("\(image).png")
            cell.languageimage.image = UIImage(contentsOfFile: imageURL.path)
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let view = StudyVC(nibName: "StudyVC", bundle: nil)
        
        //view.stringtitle = arrayLanguage[indexPath.row].databasePath as String
        let item = db[indexPath.row] as! [String:Any]
        
        view.stringtitle = item["LanguageName"] as? String
        view.languageID =  item["ID"] as! Int
        
        self.navigationController?.pushViewController(view, animated: true)
        
    }
    
    // Override to support conditional editing of the table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let alertController = UIAlertController(title: "Are you sure DELETE?", message: "Remove Language", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                
            })
            alertController.addAction(cancelAction)
            
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                
                // Delete the row from the data source
                let delete = DataBase.sharedInstance
                let item = self.db[indexPath.row]
                delete.deleteWordDatabase("WORD", ID: ((item["ID"] as? Int)! ))
                delete.deleteDatabase("Language", ID: ((item["ID"] as? Int)! ))
                self.db.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                
                
            })
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
         
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}


extension TableLanguage : SlideMenuControllerDelegate {
    
    func leftWillOpen() {
        print("SlideMenuControllerDelegate: leftWillOpen")
    }
    
    func leftDidOpen() {
        print("SlideMenuControllerDelegate: leftDidOpen")
    }
    
    func leftWillClose() {
        print("SlideMenuControllerDelegate: leftWillClose")
    }
    
    func leftDidClose() {
        print("SlideMenuControllerDelegate: leftDidClose")
    }
    
    func rightWillOpen() {
        print("SlideMenuControllerDelegate: rightWillOpen")
    }
    
    func rightDidOpen() {
        print("SlideMenuControllerDelegate: rightDidOpen")
    }
    
    func rightWillClose() {
        print("SlideMenuControllerDelegate: rightWillClose")
    }
    
    func rightDidClose() {
        print("SlideMenuControllerDelegate: rightDidClose")
    }
}




