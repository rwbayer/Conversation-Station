//
//  ViewController.swift
//  Conversation Station
//
//  Created by Bobby Bayer on 1/22/17.
//  Copyright © 2017 Robert Bayer. All rights reserved.
//

import UIKit
import AVFoundation
import SpeechKit

class ViewController: UIViewController, SKTransactionDelegate
{

    @IBOutlet weak var mainTextField: UITextField!
    let speechSynthesizer = AVSpeechSynthesizer()
    
    
    // State Logic: IDLE -> LISTENING -> PROCESSING -> repeat
    enum SKSState
    {
        case idle
        case listening
        case processing
    }
    
    // Settings
    var language: String!
    var recognitionType: String!
    var progressiveResults: Bool!
    var endpointer: SKTransactionEndOfSpeechDetection!
    
    var state = SKSState.idle
    
    var skSession:SKSession?
    var skTransaction:SKTransaction?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // show the keyboard on launch
        
        mainTextField.textInputView.becomeFirstResponder()
        super.viewDidLoad()
        
        recognitionType = SKTransactionSpeechTypeDictation
        endpointer = .short
        language = LANGUAGE
        state = .idle
        skTransaction = nil
        
        // Create a session
        skSession = SKSession(url: URL(string: SKServerUrl), appToken: SKAppKey)
        
        if (skSession == nil) {
            let alertView = UIAlertController(title: "SpeechKit", message: "Failed to initialize SpeechKit session.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default) { (action) in }
            alertView.addAction(defaultAction)
            present(alertView, animated: true, completion: nil)
            return
        }
        
//        loadEarcons()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func speakButtonPressed(_ sender: UIButton) {
        let speechUtterance = AVSpeechUtterance(string: mainTextField.text!)
        
        // Can control rate, pitch and volume if necessary. maybe a settings page?
//        speechUtterance.rate = rate
//        speechUtterance.pitchMultiplier = pitch
//        speechUtterance.volume = volume
        
        speechSynthesizer.speak(speechUtterance)
    }
    
    @IBAction func listenButtonPressed(_ sender: UIButton)
    {
        skTransaction = skSession!.recognize(withType: recognitionType,
                                             detection: endpointer,
                                             language: language,
                                             options: nil,
                                             delegate: self)
    }
    

}

