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
    @IBOutlet weak var button0: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    
    // list of presets
    var currentPresets: [Preset] = [Preset(image: UIImage(named: "sad.jpg")!, expression: "sad"), Preset(image: UIImage(named: "sad.jpg")!, expression: "sad"), Preset(image: UIImage(named: "sad.jpg")!, expression: "sad"), Preset(image: UIImage(named: "sad.jpg")!, expression: "sad"), Preset(image: UIImage(named: "sad.jpg")!, expression: "sad"), Preset(image: UIImage(named: "sad.jpg")!, expression: "sad")]
    
    
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
        
        // set up preset buttons
        setUpPresets()
        
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
    
    func transaction(_ transaction: SKTransaction!, didReceive recognition: SKRecognition!)
    {
        //Take the best result
//        heardTextLabel.text! += recognition.text;
        
//        //Or iterate through the NBest list
//        let nBest = recognition.details;
//        for phrase in (nBest as! [SKRecognizedPhrase]!) {
//            let text = phrase.text;
//            let confidence = phrase.confidence;
//        }
    }
    
    @IBAction func button0Pressed(_ sender: UIButton)
    {
        speakPreset(ind:0)
    }
    
    @IBAction func button1Pressed(_ sender: UIButton)
    {
        speakPreset(ind:1)
    }
    
    @IBAction func button2Pressed(_ sender: UIButton)
    {
        speakPreset(ind:2)
    }
    
    @IBAction func button3Pressed(_ sender: UIButton)
    {
        speakPreset(ind:3)
    }
    
    @IBAction func button4Pressed(_ sender: UIButton)
    {
        speakPreset(ind:4)
    }
    
    @IBAction func button5Pressed(_ sender: UIButton)
    {
        speakPreset(ind:5)
    }
    
    func speakPreset(ind : Int)
    {
        let stringToSpeak = currentPresets[ind].expression
        
        let speechUtterance = AVSpeechUtterance(string: stringToSpeak)
        
        speechSynthesizer.speak(speechUtterance)
    }
    
    func setUpPresets()
    {
//        for p in currentPresets
//        {
           // todo
//        }
        
    }
}

