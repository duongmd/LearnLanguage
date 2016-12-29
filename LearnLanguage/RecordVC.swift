//
//  RecordVC.swift
//  LearnLanguage
//
//  Created by iOS Student on 12/13/16.
//  Copyright © 2016 PIRATE. All rights reserved.
//

import UIKit
import AVFoundation

class RecordVC: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate {

    @IBOutlet weak var RecordBtn: UIButton!
    @IBOutlet weak var PlayBtn: UIButton!
    
    var soundRecorder : AVAudioRecorder!
    var SoundPlayer : AVAudioPlayer!
    
    var fileName: String?
    var session : AVAudioSession!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupRecorder()
    }
    
    func getCacheDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }

    func setupRecorder() {
        //Request permission
        session = AVAudioSession.sharedInstance()
        
        
        do {
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)
            try session.setActive(true)
        
            session.requestRecordPermission(){
                [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        // Microphone allowed, do what you like!
                        print("Mic OK")
                    } else {
                        // User denied microphone. Tell them off!
                        print("not mic")
                    }
                }                
            }
            
            let recordSettings = [AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                                  AVSampleRateKey: 44100,
                                  AVNumberOfChannelsKey: 2,
                                  AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue] as [String : Any]
            
            let path = getCacheDirectory().appendingPathComponent("\(fileName!).m4a")
            
            
                soundRecorder = try AVAudioRecorder(url: path, settings: recordSettings)
                print(path)
                soundRecorder?.delegate = self
                soundRecorder?.record()
           
                
            
//            soundRecorder = try AVAudioRecorder(url: path, settings: recordSettings)
//            print(path)
//            
//            soundRecorder?.record()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func Record(_ sender: UIButton) {
        if sender.titleLabel?.text == "Record" {
            soundRecorder.record()
            sender.setTitle("Stop", for: .normal)
            PlayBtn.isEnabled = false
        } else {
            soundRecorder.stop()
            sender.setTitle("Record", for: .normal)
            PlayBtn.isEnabled = false
        }
    }
    @IBAction func PlaySound(_ sender: UIButton) {
        let path = getCacheDirectory().appendingPathComponent("\(fileName!).m4a")
        SoundPlayer = try! AVAudioPlayer(contentsOf: path)
        if sender.titleLabel?.text == "Play" {
            RecordBtn.isEnabled = false
            sender.setTitle("Stop", for: .normal)
            
            SoundPlayer.delegate = self
            SoundPlayer.volume = 1.0
            SoundPlayer.play()
        } else {
            SoundPlayer.stop()
            sender.setTitle("Play", for: .normal)
        }
    }

    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        PlayBtn.isEnabled = true
        if !flag {
            soundRecorder.stop()
        }
    }
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        RecordBtn.isEnabled = true
        PlayBtn.setTitle("Play", for: .normal)
    }
    

    


}
