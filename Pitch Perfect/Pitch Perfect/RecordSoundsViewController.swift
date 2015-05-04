//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Julia Stefani on 4/10/15.
//  Copyright (c) 2015 Julia Stefani. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    @IBOutlet weak var stopbutton: UIButton!
    @IBOutlet weak var RecordinginProgress: UILabel!
    @IBOutlet weak var recordbutton: UIButton!
    @IBOutlet weak var TaptoRecord: UILabel!
    
    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!

    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    
    override func viewWillAppear(animated: Bool) {
        stopbutton.hidden = true
        TaptoRecord.hidden = false
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     
    }

    @IBAction func recordAudio(sender: UIButton) {
        TaptoRecord.hidden = true
        RecordinginProgress.hidden = false
        stopbutton.hidden = false
        println("In Audiorecord")
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
       
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool){
        if (flag){
            recordedAudio = RecordedAudio(filePath:recorder.url, title: recorder.url.lastPathComponent!)
            self.performSegueWithIdentifier("stoprecording", sender: recordedAudio)
        }
        else {
            println("Recording was not succesful")
            recordbutton.enabled = true
            stopbutton.hidden = true
        }
    
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stoprecording") {
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            let data = sender as! RecordedAudio
            playSoundsVC.receivedAudio = data
        }
    }

    @IBAction func stoprecording(sender: UIButton) {
         RecordinginProgress.hidden = true
        
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }
}

