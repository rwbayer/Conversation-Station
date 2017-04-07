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
    var currentPresets: [Preset] = [Preset(image: UIImage(named: "yes.png")!, expression: "yes"), Preset(image: UIImage(named: "no.png")!, expression: "no"), Preset(image: UIImage(named: "hello.png")!, expression: "hello"), Preset(image: UIImage(named: "goodbye.png")!, expression: "goodbye"), Preset(image: UIImage(named: "Idonotknow.png")!, expression: "I do not know"), Preset(image: UIImage(named: "celebrate.png")!, expression: "celebrate")]
    
     var organizationPresets: [Preset] = [Preset(image: UIImage(named: "airport.png")!, expression: "airport"), Preset(image: UIImage(named: "business.png")!, expression: "business"), Preset(image: UIImage(named: "church.png")!, expression: "church"), Preset(image: UIImage(named: "circus.png")!, expression: "circus"), Preset(image: UIImage(named: "hospital.png")!, expression: "hospital"), Preset(image: UIImage(named: "government.png")!, expression: "government")]
    
     var locationPresets: [Preset] = [Preset(image: UIImage(named: "park.png")!, expression: "park"), Preset(image: UIImage(named: "office.png")!, expression: "office"), Preset(image: UIImage(named: "school.png")!, expression: "school"), Preset(image: UIImage(named: "theater.png")!, expression: "theater"), Preset(image: UIImage(named: "home.png")!, expression: "home"), Preset(image: UIImage(named: "beach.png")!, expression: "beach")]
    
    var personPresets: [Preset] = [Preset(image: UIImage(named: "mother.png")!, expression: "mother"), Preset(image: UIImage(named: "father.png")!, expression: "father"), Preset(image: UIImage(named: "brother.png")!, expression: "brother"), Preset(image: UIImage(named: "sister.png")!, expression: "sister"), Preset(image: UIImage(named: "musician.png")!, expression: "musician"), Preset(image: UIImage(named: "acrobat.png")!, expression: "acrobat")]
    
    var artPresets: [Preset] = [Preset(image: UIImage(named: "art.png")!, expression: "art"), Preset(image: UIImage(named: "musician.png")!, expression: "musician"), Preset(image: UIImage(named: "singer.png")!, expression: "singer"), Preset(image: UIImage(named: "book.png")!, expression: "book"), Preset(image: UIImage(named: "movie.png")!, expression: "movie"), Preset(image: UIImage(named: "painting.png")!, expression: "painting")]
    
    var consumerPresets: [Preset] = [Preset(image: UIImage(named: "ball.png")!, expression: "ball"), Preset(image: UIImage(named: "phone.png")!, expression: "phone"), Preset(image: UIImage(named: "car.png")!, expression: "car"), Preset(image: UIImage(named: "tabletComputer.png")!, expression: "tablet computer"), Preset(image: UIImage(named: "toy.png")!, expression: "toy"), Preset(image: UIImage(named: "videoGame.png")!, expression: "video game")]
    
    var eventPresets: [Preset] = [Preset(image: UIImage(named: "tvShow.png")!, expression: "television show"), Preset(image: UIImage(named: "accident.png")!, expression: "accident"), Preset(image: UIImage(named: "holiday.png")!, expression: "holiday"), Preset(image: UIImage(named: "nye.png")!, expression: "new year's eve"), Preset(image: UIImage(named: "sportingEvent.png")!, expression: "sporting event"), Preset(image: UIImage(named: "play.png")!, expression: "play")]
    
    
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
        let stringToSpeak = eventPresets[ind].expression
        
        let speechUtterance = AVSpeechUtterance(string: stringToSpeak)
        
        speechSynthesizer.speak(speechUtterance)
    }
    
    func setUpPresets()
    {
        for (index, element) in eventPresets.enumerated()
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
    
    func sendToServer(data: String)
    {
        // prepare json data
        let json: [String: Any] = ["type": "PLAIN_TEXT",
                                   "content": data]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        // create post request
        let url = URL(string: "https://communicationstation-158117.appspot.com/upload_json")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // insert json data to the request
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            
            if let responseJSON = responseJSON as? [String: Any]
            {
                print("response: ",  responseJSON)
            }
        }
        
        task.resume()
    }
    
    @IBAction func unwindToMenu(segue: UIStoryboardSegue)
    {
        if let sourceViewController = segue.source as? RecordingViewController
        {
            dataReceived = sourceViewController.dataPassed
        }
        
        mainTextField.becomeFirstResponder()
        
        print(dataReceived);
        
        sendToServer(data: dataReceived!);
    }
}

