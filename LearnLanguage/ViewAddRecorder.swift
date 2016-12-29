//
//  ViewAddRecorder.swift
//  Language
//
//  Created by PIRATE on 11/16/16.
//  Copyright © 2016 PIRATE. All rights reserved.
//

import UIKit
import AVFoundation

class ViewAddRecorder: UIViewController {
    @IBOutlet weak var recordBtn: UIButton!

    var recorder : AVAudioRecorder!
    var player: AVAudioPlayer!
    var meterTimer: Timer!
    var soundFileRUL: URL!
    
    @IBOutlet weak var stopBtn: UIButton!
    
    @IBOutlet weak var titleRecorder: UITextField!
    
    @IBAction func startRecorder(_ sender: Any) {
        
        if player != nil && player.isPlaying {
            player.stop()
        }
        
        if recorder == nil {
            print("recording.recorder nil")
            recordBtn.setTitle("Pause", for: UIControlState())
            stopBtn.isEnabled = true
            
        }
        if recorder != nil && recorder.isRecording
        {
            recorder.pause()
            recordBtn.setTitle("Continue", for: UIControlState())
        }
        else {
            recordBtn.setTitle("Pause", for: UIControlState())
            
        }
    }
      
    @IBOutlet weak var timeRecorder: UILabel!
    @IBAction func stopRecorder(_ sender: Any) {
    }
    @IBOutlet weak var btnDoneRecorder: UIButton!
    
    @IBAction func actDoneRecorder(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnDoneRecorder.layer.cornerRadius = 30
        
        
        // Do any additional setup after loading the view.
    }

    
    func updateTimeCurrent(_ timer: Timer)
    {
        if recorder.isRecording {
            let min = Int(recorder.currentTime / 60)
            let sec = Int(recorder.currentTime.truncatingRemainder(dividingBy: 60))
            let s = String(format: "%02d:%02d", min,sec)
            timeRecorder.text = s
            recorder.updateMeters()
        }
    }
}







    extension ViewAddRecorder : AVAudioRecorderDelegate {
        
        func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder,
                                             successfully flag: Bool) {
            print("finished recording \(flag)")
            stopBtn.isEnabled = false
           // playButton.isEnabled = true
            recordBtn.setTitle("Record", for:UIControlState())
            
            // iOS8 and later
            let alert = UIAlertController(title: "Recorder",
                                          message: "Finished Recording",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Keep", style: .default, handler: {action in
                print("keep was tapped")
                self.recorder = nil
            }))
            alert.addAction(UIAlertAction(title: "Delete", style: .default, handler: {action in
                print("delete was tapped")
                self.recorder.deleteRecording()
            }))
            self.present(alert, animated:true, completion:nil)
        }
        
        func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder,
                                              error: Error?) {
            
            if let e = error {
                print("\(e.localizedDescription)")
            }
        }
        
    }
    
    // MARK: AVAudioPlayerDelegate
    extension ViewAddRecorder : AVAudioPlayerDelegate {
        func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
            print("finished playing \(flag)")
            recordBtn.isEnabled = true
            stopBtn.isEnabled = false
        }
        
        func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
            if let e = error {
                print("\(e.localizedDescription)")
            }
            
        }
    }

