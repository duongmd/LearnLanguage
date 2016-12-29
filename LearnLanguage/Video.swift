//
//  Video.swift
//  Language
//
//  Created by PIRATE on 11/15/16.
//  Copyright © 2016 PIRATE. All rights reserved.
//

import UIKit
import MediaPlayer
import AVKit

class Video: BaseMediaViewController , UITableViewDelegate , UITableViewDataSource {
    
    var db = [NSDictionary]()
    
    @IBOutlet weak var tbvVideo: UITableView!
    var languageID: Int!
    
    @IBOutlet weak var searchVideo: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableVideo.dataSource = self
        
        tranparentNavigation = false
        self.navigationController?.navigationBar.isTranslucent = false

        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: "Plus"), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: #selector(addVideo), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)
        self.navigationItem.setRightBarButtonItems([item1], animated: true)
        
        
        let back = UIButton(type: .custom)
        back.setImage(UIImage(named: "Back-48"),for: .normal)
        back.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        back.addTarget(self, action: #selector(finished), for: .touchUpInside)
        
        let item2 = UIBarButtonItem(customView: back)
        self.navigationItem.setLeftBarButtonItems([item2], animated: true)
        // load co so du lieu
        self.tbvVideo.delegate = self
        self.tbvVideo.dataSource = self
        let nib = UINib(nibName: "CellVideo", bundle: nil)
        self.tbvVideo.register(nib, forCellReuseIdentifier: "Cell")
        
        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let database = DataBase.sharedInstance
        print(languageID)
        db = database.viewDatabase("Video", columns: ["VideoName" , "Link" , "Sub" , "LanguageID" , "ID"], statement: "WHERE LanguageID = \( languageID! )")
        print(database.viewDatabase("Video", columns: ["VideoName" , "Link" , "Sub" , "LanguageID"], statement: "WHERE LanguageID = \( languageID! )"))
        print(db.count)
        tbvVideo.reloadData()
           }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func finished()
    {
        self.dismiss(animated: true, completion: nil)
    }
    

    
    func addVideo() {
        let addVideo = ViewAddVideo(nibName: "ViewAddVideo", bundle: nil)
        addVideo.languageID = languageID!
        self.navigationController?.pushViewController(addVideo, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var item = db[indexPath.row] as! [String: Any]
        let urlVideo: NSURL = NSURL(string: item["Link"] as! String)!
        //let videoFile = Bundle.main.path(forResource: "trailer_720p", ofType: "mov")
        
        
        // Subtitle file
        let subtitleFile = Bundle.main.path(forResource: "trailer_720p", ofType: "srt")
        //let urlTitleFile: NSURL = NSURL(string: item["Sub"] as! String)!
        item["Sub"] = subtitleFile
        //let subtitleURL: NSURL = NSURL(string: item["Sub"] as! String)!
        let subtitleURL = URL(fileURLWithPath: subtitleFile!)
        // Movie player
        let moviePlayer = AVPlayerViewController()
        //let viewVideo = Bundle.main.loadNibNamed("PlayVideoView", owner: self, options: nil)?.first as! PlayVideoView
        
        moviePlayer.player = AVPlayer(url: urlVideo as URL)
        present(moviePlayer, animated: true, completion: nil)
        
        // Add subtitles
        moviePlayer.addSubtitles().open(file: subtitleURL as URL)
        moviePlayer.addSubtitles().open(file: subtitleURL as URL, encoding: String.Encoding.utf8)
        
        //Change text properties
        moviePlayer.subtitleLabel?.textColor = UIColor.red
        
        // Play
        moviePlayer.player?.play()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return db.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CellVideo
        //let cell = Bundle.main.loadNibNamed("CellVideo", owner: self, options: nil)?.first as! CellVideo
        let item = db[indexPath.row] as! [String: Any]
        cell.nameVideo.text = item["VideoName"] as? String
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let delete = DataBase.sharedInstance
            let item = db[indexPath.row]
            print(db[indexPath.row])
            delete.deleteDatabase("Video", ID: ((item["ID"] as? Int)!))
            db.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}
