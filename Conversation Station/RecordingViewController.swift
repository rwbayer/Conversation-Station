//
//  RecordingViewController.swift
//  Conversation Station
//
//  Created by Bobby Bayer on 2/7/17.
//  Copyright © 2017 Robert Bayer. All rights reserved.
//

import UIKit
import SpeechKit

class RecordingViewController: UIViewController, SKTransactionDelegate
{
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
    
    var dataPassed : String?

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //only apply the blur if the user hasn't disabled transparency effects
        if !UIAccessibilityIsReduceTransparencyEnabled()
        {
            self.view.backgroundColor = UIColor.clear
            
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            //always fill the view
            blurEffectView.frame = self.view.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            self.view.addSubview(blurEffectView) //if you have more UIViews, use an insertSubview API to place it where needed
            self.view.sendSubview(toBack: blurEffectView)

        }
        else
        {
            self.view.backgroundColor = UIColor.black
        }
        
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
        
        skTransaction = skSession!.recognize(withType: recognitionType,
                                            detection: endpointer,
                                            language: language,
                                            options: nil,
                                            delegate: self)
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    func transaction(_ transaction: SKTransaction!, didReceive recognition: SKRecognition!)
    {
        // Take the best result
        NSLog("%@", recognition.text)
        
        dataPassed = recognition.text
        
        self.performSegue(withIdentifier: "backToMainScreen", sender: self)
        
        //        //Or iterate through the NBest list
        //        let nBest = recognition.details;
        //        for phrase in (nBest as! [SKRecognizedPhrase]!) {
        //            let text = phrase.text;
        //            let confidence = phrase.confidence;
        //        }
    }
    
    @IBAction func closeButtonPressed(_ sender: UIButton)
    {
        skTransaction!.stopRecording()
        self.performSegue(withIdentifier: "backToMainScreen", sender: self)
    }
    
}
