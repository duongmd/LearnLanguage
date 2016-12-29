//
//  WordList.swift
//  LearnLanguage
//
//  Created by iOS Student on 11/16/16.
//  Copyright © 2016 PIRATE. All rights reserved.
//

import UIKit

class WordList: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tbvWordList: UITableView!

    
    @IBOutlet var mySearchBar: UISearchBar!

    var tap: UITapGestureRecognizer?
    var searchController : UISearchController!
    var languageid: Int!
    let database = DataBase.sharedInstance
    
    var dbWord = [NSDictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mySearchBar.backgroundColor = UIColor.lightGray
        
        self.navigationController?.navigationBar.isTranslucent = false
        
        
        let cellWord = UINib(nibName: "CellWord", bundle: nil)
        self.tbvWordList.register(cellWord, forCellReuseIdentifier: "Cell1")
        
        let btn2 = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        btn2.setImage(UIImage(named: "Back-48"), for: .normal)
        btn2.addTarget(self, action: #selector(Dismiss), for: .touchUpInside)
        
        let backbtn = UIBarButtonItem(customView: btn2)
        
        navigationItem.setLeftBarButton(backbtn, animated: true)
        
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addWord))
        navigationItem.setRightBarButton(add, animated: true)
        
        tap  = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        mySearchBar.setShowsCancelButton(false, animated: true)
        
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
     getDataWord("WHERE LanguageID = \( languageid! )")
     
       
        DispatchQueue.main.async { 
         //   self.animateTable()
        }
        
    }
    func getDataWord(_ statement: String) {
        dbWord.removeAll()
        dbWord = database.viewDatabase("WORD", columns: ["*"], statement: statement)
        self.tbvWordList.reloadData()
    }
    
    func animateTable() {
        tbvWordList.reloadData()
        
        let cells = tbvWordList.visibleCells
        let tableHeight: CGFloat = tbvWordList.bounds.size.height
        
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
            
        }
        
        var index = 0
        
        for a in cells {
            let cell: UITableViewCell = a as UITableViewCell
            UIView.animate(withDuration: 1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
                }, completion: nil)
            index = index + 1
        }
    }
    
    func Dismiss(){
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func addWord(){
        
        let addWordVC = AddWordVC(nibName: "AddWordVC", bundle: nil)
        addWordVC.languageid = languageid
        navigationController?.pushViewController(addWordVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dbWord.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath) as! CellWord
        let item = dbWord[(indexPath as NSIndexPath).row] as! [String:Any]
        cell.textLabel?.text = "\(item["NameWord"] as! String)"
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = dbWord[(indexPath as NSIndexPath).row] as! [String:Any]
        let detailVC = DetailWordVC(nibName: "DetailWordVC", bundle: nil)
        detailVC.str1 = item["NameWord"] as? String
        detailVC.str2 = item["WordForm"] as? String
        detailVC.str3 = item["Mean"] as? String

        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        if let dirPath = paths.first
        {
            let image = item["NameWord"] as! String
            let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent("\(image).png")
            detailVC.image = UIImage(contentsOfFile: imageURL.path)
            
        }

       
        displayPopupDetail(detailVC)
 
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let delete = DataBase.sharedInstance
            let item = dbWord[(indexPath.row)]
            delete.deleteDatabase("WORD", ID: ((item["ID"] as? Int)!))
            dbWord.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            let soundURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("\(item["NameWord"]!).m4a")
            let imageURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("\(item["NameWord"]!)")
        
            do {
            try FileManager.default.removeItem(at: soundURL)
            try FileManager.default.removeItem(at: imageURL)
            } catch let err as NSError {
                print(err.localizedDescription)
            }
        }
    }
 

    
    //MARK: Create POPUP
    
    var popupVC: DetailWordVC?
    var blurView: UIView?
    
    func makeBlurMainView() -> UIView {
        let blurView = UIView(frame: tbvWordList.bounds)
        blurView.alpha = 0.3
        blurView.backgroundColor = UIColor.black
        
        return blurView
    }
    
    func displayPopupDetail(_ content: DetailWordVC){
        popupVC = content
        blurView = makeBlurMainView()
        
        let dismissTapGesture = UITapGestureRecognizer(target: self, action: #selector(tapDismissGesture(_:)))
        blurView?.addGestureRecognizer(dismissTapGesture)
        
        view.addSubview(blurView!)
        addChildViewController(content)
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.beginFromCurrentState, animations: {
            content.view.alpha = 1.0
            content.view.center = CGPoint(x: self.view.bounds.width/2.0, y: self.view.bounds.height/2.0)
            self.view.addSubview(content.view)
            content.didMove(toParentViewController: self)
            
            }, completion: nil)
    }
    
    func animateDismissPopupView(_ addNewVC : DetailWordVC) {
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions(), animations: {
            
            addNewVC.view.alpha = 0.5
            addNewVC.view.center = CGPoint(x: self.view.bounds.width / 2.0, y: -self.view.bounds.height)
            self.blurView?.alpha = 0.0
            
        }){(Bool) in
            addNewVC.view.removeFromSuperview()
            addNewVC.removeFromParentViewController()
            self.blurView?.removeFromSuperview()
        }
        
    }
    func tapDismissGesture(_ tapGesture : UITapGestureRecognizer) {
        animateDismissPopupView(popupVC!)
    }
    
    
}

extension WordList : UISearchBarDelegate{
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        mySearchBar.setShowsCancelButton(true, animated: true)
        tbvWordList.addGestureRecognizer(tap!)
        let uibuton = searchBar.value(forKey: "cancelButton") as! UIButton
        uibuton.setTitleColor(UIColor.blue, for: .normal)
    }
    
    func dismissKeyboard() {
        mySearchBar.setShowsCancelButton(false, animated: true)
        tbvWordList.removeGestureRecognizer(tap!)
        mySearchBar.endEditing(true)
        mySearchBar.text = ""
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        var statement = ""
        //print(text)
        
        //Truong hop dang xoa, text = ""
        if (text == ""){
            //Cat chuoi
            if ((mySearchBar.text?.characters.count)! > 0){
                statement = (mySearchBar.text! as NSString).substring(to: mySearchBar.text!.characters.count - 1)
            } else {
                statement = ""
            }
        } else {
            //Ky tu bat dau tang
            statement = "\(mySearchBar.text!)\(text)"
        }
      
        self.getDataWord("WHERE LanguageID = \( languageid! ) AND NameWord Like '\(statement)%'")
        
        return true
    }
    
    
    
    
    
    
}
