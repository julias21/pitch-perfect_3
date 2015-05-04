//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Julia Stefani on 4/20/15.
//  Copyright (c) 2015 Julia Stefani. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!

  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func PlaySoundsSnail(sender: UIButton) {
        playAudioWithVariableRate(0.5)
        
    }
    
    
    @IBAction func PlaySoundsFast(sender: UIButton) {
        playAudioWithVariableRate(2.0)
    }
    
    
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playDarthVadorAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }

    func playAudioWithVariableRate(rate: Float){
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.play()
        audioPlayer.rate = rate
        audioPlayer.currentTime = 0.0
        
    }
    
    
    //Function to change pitch
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    @IBAction func StopPlayingSounds(sender: UIButton) {
       audioPlayer.stop()
       audioEngine.stop()
    }
    

}
