//
//  ViewController.swift
//  Conversation Station
//
//  Created by Bobby Bayer on 1/22/17.
//  Copyright © 2017 Robert Bayer. All rights reserved.
//

import UIKit
import AVFoundation
//import SpeechKit

class ViewController: UIViewController
{

    @IBOutlet weak var mainTextField: UITextField!
    @IBOutlet weak var button0: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    
    // list of presets
    var currentPresets: [Preset] = [Preset(image: UIImage(named: "sad.jpg")!, expression: "sad"), Preset(image: UIImage(named: "happy.jpg")!, expression: "happy"), Preset(image: UIImage(named: "angry.jpg")!, expression: "angry"), Preset(image: UIImage(named: "excited.jpg")!, expression: "excited"), Preset(image: UIImage(named: "proud.jpg")!, expression: "proud"), Preset(image: UIImage(named: "surprised.jpg")!, expression: "surprised")]
    
    
    let speechSynthesizer = AVSpeechSynthesizer()
    
    var dataReceived: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // show the keyboard on launch
        mainTextField.becomeFirstResponder()
        super.viewDidLoad()
        
        // set up preset buttons
        setUpPresets()
        
//        loadEarcons()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        
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
        mainTextField.resignFirstResponder()

        performSegue(withIdentifier: "listenSegue", sender: nil)
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
        for (index, element) in currentPresets.enumerated()
        {
            switch(index)
            {
            case 0:
                button0.setImage(element.image, for: .normal)
                button0.layer.borderWidth = 1
                button0.layer.borderColor = UIColor.black.cgColor
            case 1:
                button1.setImage(element.image, for: .normal)
                button1.layer.borderWidth = 1
                button1.layer.borderColor = UIColor.black.cgColor
            case 2:
                button2.setImage(element.image, for: .normal)
                button2.layer.borderWidth = 1
                button2.layer.borderColor = UIColor.black.cgColor
            case 3:
                button3.setImage(element.image, for: .normal)
                button3.layer.borderWidth = 1
                button3.layer.borderColor = UIColor.black.cgColor
            case 4:
                button4.setImage(element.image, for: .normal)
                button4.layer.borderWidth = 1
                button4.layer.borderColor = UIColor.black.cgColor
            case 5:
                button5.setImage(element.image, for: .normal)
                button5.layer.borderWidth = 1
                button5.layer.borderColor = UIColor.black.cgColor
            default: break
            }
        }
        
    }
    
    @IBAction func unwindToMenu(segue: UIStoryboardSegue)
    {
        if let sourceViewController = segue.source as? RecordingViewController
        {
            dataReceived = sourceViewController.dataPassed
        }
        
        mainTextField.becomeFirstResponder()
    }
}

