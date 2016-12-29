//
//  WordListForget.swift
//  LearnLanguage
//
//  Created by iOS Student on 11/16/16.
//  Copyright © 2016 PIRATE. All rights reserved.
//

import UIKit

class WordListForget: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var mySearch2: UISearchBar!

    @IBOutlet weak var tbvWordListForget: UITableView!
    var tap: UIGestureRecognizer!
    let DetailVC = UIView(frame: CGRect(x: 60 , y: 150, width: 250, height: 250))
    let lbl = UILabel(frame: CGRect(x: 60, y: 150, width: 100, height: 30))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = false
        
        let btn3 = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        btn3.setImage(UIImage(named: "Back-48"), for: .normal)
        btn3.addTarget(self, action: #selector(Dismiss), for: .touchUpInside)
        let backbtn = UIBarButtonItem(customView: btn3)
        
        navigationItem.setLeftBarButton(backbtn, animated: true)
        
        let cellWord2 = UINib(nibName: "CellWord", bundle: nil)
        tbvWordListForget.register(cellWord2, forCellReuseIdentifier: "Cell1")
        
        tbvWordListForget.delegate = self
        tbvWordListForget.dataSource = self
        
        tap = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
        mySearch2.setShowsCancelButton(false, animated: true)
        
        DetailVC.backgroundColor = UIColor.black
        lbl.backgroundColor = UIColor.white
        DetailVC.addSubview(lbl)
    }
    
    func Dismiss(){
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath) as! CellWord
        cell2.textLabel?.text = "Bye\(indexPath.row)"
        return cell2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailVC = DetailWordVC(nibName: "DetailWordVC", bundle: nil)
        displayPopupDetail(detailVC)
        
    }
    
    
    func DismissKeyboard(){
        mySearch2.delegate = self
        mySearch2.setShowsCancelButton(false, animated: true)
        mySearch2.endEditing(true)
        tbvWordListForget.removeGestureRecognizer(tap)
        mySearch2.text = ""
    }
    
    //MARK: Create POPUP
    
    var popupVC: DetailWordVC?
    var blurView: UIView?
    
    func makeBlurMainView() -> UIView {
        let blurView = UIView(frame: tbvWordListForget.bounds)
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
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.transitionFlipFromTop, animations: {
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
    //
    
}

extension WordListForget : UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        DismissKeyboard()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        mySearch2.setShowsCancelButton(true, animated: true)
        tbvWordListForget.addGestureRecognizer(tap)
        let button = mySearch2.value(forKey: "cancelButton") as! UIButton
        button.setTitleColor(UIColor.blue, for: .normal)
    }
    
}
