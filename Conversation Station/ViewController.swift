//
//  ViewController.swift
//  Conversation Station
//
//  Created by Bobby Bayer on 1/22/17.
//  Copyright © 2017 Robert Bayer. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var mainTextField: UITextField!
    let speechSynthesizer = AVSpeechSynthesizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // show the keyboard on launch
        mainTextField.textInputView.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func speakButtonPressed(sender: UIButton) {
        let speechUtterance = AVSpeechUtterance(string: mainTextField.text!)
        
        // Can control rate, pitch and volume if necessary. maybe a settings page?
//        speechUtterance.rate = rate
//        speechUtterance.pitchMultiplier = pitch
//        speechUtterance.volume = volume
        
        speechSynthesizer.speakUtterance(speechUtterance)
    }

}

