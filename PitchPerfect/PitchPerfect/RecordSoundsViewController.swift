//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by TARS on 29.03.2020.
//  Copyright © 2020 TARS. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    var audioRecorder: AVAudioRecorder!
    
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordingButton.isEnabled = false
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear executed")
    }
 /*
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
 */
    
    @IBAction func recordAudio(_ sender: AnyObject) {
        buttonsConfugurations(
        isRecordButtonEnabled: false, isStopRecordingButton: true, Text:  "Recording in progress")
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
       let recordingName = "recordedVoice.wav"
       let pathArray = [dirPath, recordingName]
       let filePath = URL(string: pathArray.joined(separator: "/"))

        
        let session = AVAudioSession.sharedInstance()
              try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)


           try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
           audioRecorder.delegate = self
           audioRecorder.isMeteringEnabled = true
           audioRecorder.prepareToRecord()
           audioRecorder.record()
    }
    
    func buttonsConfugurations(
        isRecordButtonEnabled: Bool,isStopRecordingButton: Bool, Text: String
    ){
        recordButton.isEnabled = isRecordButtonEnabled
        stopRecordingButton.isEnabled = isStopRecordingButton
        recordingLabel.text = Text
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        buttonsConfugurations(
            isRecordButtonEnabled: true, isStopRecordingButton: false, Text: "Tap to record")
        
        audioRecorder.stop()
           let audioSession = AVAudioSession.sharedInstance()
           try! audioSession.setActive(false)
    }
 
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag{
            print("faild recording")
            return
        }
        performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != "stopRecording"{
            return
        }
        let playSoundsVC = segue.destination as! PlaySoundsViewController
        let recorderAudioURL = sender as! URL
        playSoundsVC.recordedAudioURL = recorderAudioURL
    }
}

