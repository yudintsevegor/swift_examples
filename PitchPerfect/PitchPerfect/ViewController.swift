//
//  ViewController.swift
//  PitchPerfect
//
//  Created by TARS on 29.03.2020.
//  Copyright © 2020 TARS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var recordingLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func recordAudio(_ sender: Any) {
        print("record button was pressed")
        recordingLabel.text = "Recording in progress"
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        print("stop recording button was pressed")
    }
    
}

