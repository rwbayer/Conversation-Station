//
//  RecordingViewController.swift
//  Conversation Station
//
//  Created by Bobby Bayer on 2/7/17.
//  Copyright © 2017 Robert Bayer. All rights reserved.
//

import UIKit
import Speech

@available(iOS 10.0, *)
class RecordingViewController: UIViewController, SFSpeechRecognizerDelegate
{
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))
    
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    var dataPassed : String?

    @IBAction func closeButtonPressed(_ sender: UIButton)
    {
        self.performSegue(withIdentifier: "backToMainScreen", sender: self)
    }
    
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
        
        
        speechRecognizer?.delegate = self  //3
        
        SFSpeechRecognizer.requestAuthorization { (authStatus) in  //4
            
            var isButtonEnabled = false
            
            switch authStatus {  //5
            case .authorized:
                isButtonEnabled = true
                
            case .denied:
                isButtonEnabled = false
                print("User denied access to speech recognition")
                
            case .restricted:
                isButtonEnabled = false
                print("Speech recognition restricted on this device")
                
            case .notDetermined:
                isButtonEnabled = false
                print("Speech recognition not yet authorized")
            }
            
            OperationQueue.main.addOperation() {
//                self.microphoneButton.isEnabled = isButtonEnabled
            }
        
        }
    }
    
    func startRecording()
    {
        
        if recognitionTask != nil
        {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        
        do
        {
            try audioSession.setCategory(AVAudioSessionCategoryRecord)
            try audioSession.setMode(AVAudioSessionModeMeasurement)
            try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        }
        catch
        {
            print("audioSession properties weren't set because of an error.")
        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        guard let inputNode = audioEngine.inputNode else {
            fatalError("Audio engine has no input node")
        }
        
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        }
        
        recognitionRequest.shouldReportPartialResults = true
        
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
            
            var isFinal = false
            
            if result != nil
            {
                
//                self.textView.text = result?.bestTranscription.formattedString
                isFinal = (result?.isFinal)!
            }
            
            if error != nil || isFinal
            {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
//                self.microphoneButton.isEnabled = true
            }
        })
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        
        do
        {
            try audioEngine.start()
        }
        catch
        {
            print("audioEngine couldn't start because of an error.")
        }
        
        
    }
    
//    func didReceiveMemoryWarning()
//    {
//        super.didReceiveMemoryWarning()
//    }
    
//    func transaction(_ transaction: SKTransaction!, didReceive recognition: SKRecognition!)
//    {
//        // Take the best result
//        NSLog("%@", recognition.text)
//        
//        dataPassed = recognition.text
//        
//        self.performSegue(withIdentifier: "backToMainScreen", sender: self)
//        
//        //        //Or iterate through the NBest list
//        //        let nBest = recognition.details;
//        //        for phrase in (nBest as! [SKRecognizedPhrase]!) {
//        //            let text = phrase.text;
//        //            let confidence = phrase.confidence;
//        //        }
//    }
//    
//    @IBAction func closeButtonPressed(_ sender: UIButton)
//    {
////        skTransaction!.stopRecording()
//        self.performSegue(withIdentifier: "backToMainScreen", sender: self)
//    }
    
}
