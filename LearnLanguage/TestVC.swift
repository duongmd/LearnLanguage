//
//  TestVC.swift
//  LearnLanguage
//
//  Created by iOS Student on 12/23/16.
//  Copyright © 2016 PIRATE. All rights reserved.
//

import UIKit
import GameKit

class TestVC: UIViewController {

    let db = DataBase.sharedInstance
    var Dic = [NSDictionary]()

    var Arr : [String] = []
    var x: Int!
    var str: String!
    
    var time: Int = 0
    var timer = Timer()
    
    @IBOutlet weak var lbl_Time: UILabel!
    @IBOutlet weak var lbl_Word: UILabel!
    
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var nextbtn: UIButton!
    @IBOutlet weak var imgAnswer: UIImageView!
    @IBOutlet weak var lbl_Answer: UILabel!

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alphaEqualZero()
        getData("")
        randomWord()
        animation()
        start()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        btn1.layer.cornerRadius = 8
        btn2.layer.cornerRadius = 8
        btn3.layer.cornerRadius = 8
        btn4.layer.cornerRadius = 8
        lbl_Time.layer.cornerRadius = 25
        lbl_Time.clipsToBounds = true
        
    }
    
    
    func alphaEqualZero() {
        btn1.alpha = 0
        btn2.alpha = 0
        btn3.alpha = 0
        btn4.alpha = 0
        imgAnswer.alpha = 0
        lbl_Answer.alpha = 0
    }
    
    func start(){
        
        timer.invalidate()
        time = 11
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
        
    }
    
    func countDown(){
        time = time - 1
        lbl_Time.text = String(time)
        if time == 0 {
            timer.invalidate()
            enableButton(false)
            chooseAnswerWrong()
            
        }
    }
    
    func chooseAnswerWrong(){
        for i in 1...4 {
            if i != x {
                switch i {
                case 1: self.btn1.alpha = 0.3
                case 2: self.btn2.alpha = 0.3
                case 3: self.btn3.alpha = 0.3
                default: self.btn4.alpha = 0.3
                
                enableButton(false)
                    
                }
            }
            else
            {
                switch i {
                case 1: self.btn1.backgroundColor = UIColor.red
                case 2: self.btn2.backgroundColor = UIColor.red
                case 3: self.btn3.backgroundColor = UIColor.red
                default: self.btn4.backgroundColor = UIColor.red
                
                enableButton(false)
                    
                }
            }
        }
    }
    
    func animation(){
        UIView.animate(withDuration: 2, delay: 0.0, options: .curveEaseInOut, animations: {
            self.btn1.alpha = 1
            
            }, completion: nil)
        
        UIView.animate(withDuration: 2, delay: 0.5, options: .curveEaseInOut, animations: {
            self.btn2.alpha = 1
            
            }, completion: nil)
        
        UIView.animate(withDuration: 2, delay: 1, options: .curveEaseInOut, animations: {
            self.btn3.alpha = 1
            
            }, completion: nil)
        
        UIView.animate(withDuration: 2, delay: 1.5, options: .curveEaseInOut, animations: {
            self.btn4.alpha = 1
            
            }, completion: nil)
        
    }
    
    func getData(_ statement: String) {
        Dic.removeAll()

        Dic = db.viewDatabase("WORD", columns: ["NameWord","Mean"], statement: statement)

        print(Dic)
        
    }
    
    
    
    @IBAction func btn1_action(_ sender: UIButton) {
        
        if sender.titleLabel?.text == str! {
            sender.backgroundColor = UIColor.red
            
            UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: .curveEaseOut, animations: {
            sender.bounds = CGRect(x: self.btn1.bounds.origin.x - 20, y: self.btn1.bounds.origin.y, width: self.btn2.bounds.size.width + 60, height: self.btn1.bounds.size.height)
           
                self.enableButton(false)
            
                for i in 1...4 {
                    if i != sender.tag-100 {
                        switch i {
                        case 1: self.btn1.alpha = 0.3
                        case 2: self.btn2.alpha = 0.3
                        case 3: self.btn3.alpha = 0.3
                        default: self.btn4.alpha = 0.3

                    //    self.enableButton(false)
                            
                        }
                    }
                }
                                    }, completion: nil)
            
            
            self.exact()
        } else {
            
            chooseAnswerWrong()
        
            self.wrong()
        }
        timer.invalidate()
    }

    func exact(){
        imgAnswer.image = UIImage(named: "smiley-star")
        imgAnswer.alpha = 1
        lbl_Answer.text = "Exact!"
        lbl_Answer.alpha = 1
    }
    func wrong(){
        imgAnswer.image = UIImage(named: "Sad_Emoticon.png")
        imgAnswer.alpha = 1
        lbl_Answer.text = "Wrong!"
        lbl_Answer.alpha = 1
    }
    
    func randomWord(){
        
        let i = Int(arc4random_uniform(UInt32(Dic.count)))
        lbl_Word.text = Dic[i]["NameWord"] as? String
        str = Dic[i]["Mean"] as! String

        Dic.remove(at: i)

        Arr.removeAll()
        
        for a in 0...Dic.count-1 {
            let str = Dic[a].value(forKey: "Mean") as! String
            print(str)
            Arr.append(str)
            
        }
        
        let randomSource = GKLinearCongruentialRandomSource(seed: UInt64(Arr.count+1))
        let shuffledArray = randomSource.arrayByShufflingObjects(in: Arr)
        print(shuffledArray)
        
        let j = Int(arc4random_uniform(4)+1)
        x = j
        
        if (j == 1) {
            btn1.setTitle("\(str!)", for: .normal)
            btn2.setTitle("\(shuffledArray[0])", for: .normal)
            btn3.setTitle("\(shuffledArray[1])", for: .normal)
            btn4.setTitle("\(shuffledArray[2])", for: .normal)
        }
        if (j == 2) {
            btn1.setTitle("\(shuffledArray[0])", for: .normal)
            btn2.setTitle("\(str!)", for: .normal)
            btn3.setTitle("\(shuffledArray[1])", for: .normal)
            btn4.setTitle("\(shuffledArray[2])", for: .normal)
        }
        if (j == 3) {
            btn1.setTitle("\(shuffledArray[0])", for: .normal)
            btn2.setTitle("\(shuffledArray[1])", for: .normal)
            btn3.setTitle("\(str!)", for: .normal)
            btn4.setTitle("\(shuffledArray[2])", for: .normal)
        }
        if (j == 4) {
            btn1.setTitle("\(shuffledArray[0])", for: .normal)
            btn2.setTitle("\(shuffledArray[1])", for: .normal)
            btn3.setTitle("\(shuffledArray[2])", for: .normal)
            btn4.setTitle("\(str!)", for: .normal)
        }
        
    }
    
    func resetButton(){
        
        enableButton(true)
        
        switch x {
        case 1:
        self.btn1.backgroundColor = UIColor.black
        btn1.bounds = CGRect(x: self.btn1.bounds.origin.x + 20, y: self.btn1.bounds.origin.y, width: self.btn2.bounds.size.width , height: self.btn2.bounds.size.height)
            
        case 2:
        self.btn2.backgroundColor = UIColor.black
        btn2.bounds = CGRect(x: self.btn1.bounds.origin.x + 20, y: self.btn1.bounds.origin.y, width: self.btn1.bounds.size.width , height: self.btn2.bounds.size.height)
            
        case 3:
        self.btn3.backgroundColor = UIColor.black
        btn3.bounds = CGRect(x: self.btn1.bounds.origin.x + 20, y: self.btn1.bounds.origin.y, width: self.btn2.bounds.size.width , height: self.btn2.bounds.size.height)
        default:
        self.btn4.backgroundColor = UIColor.black
        btn4.bounds = CGRect(x: self.btn1.bounds.origin.x + 20, y: self.btn1.bounds.origin.y, width: self.btn2.bounds.size.width , height: self.btn2.bounds.size.height)
        }
    }
    
    func enableButton(_ para: Bool) {
        if para == false {
            btn1.isEnabled = para
            btn2.isEnabled = para
            btn3.isEnabled = para
            btn4.isEnabled = para
        }
        else {
            btn1.isEnabled = true
            btn2.isEnabled = true
            btn3.isEnabled = true
            btn4.isEnabled = true
        }
    }
    
    @IBAction func next(_ sender: UIButton) {
        
        resetButton()
        alphaEqualZero()
        getData("")
        randomWord()
        animation()
        start()
    }
    
    
    
    
}
