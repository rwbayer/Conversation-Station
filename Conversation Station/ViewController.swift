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
    
    var initialPresets: [Preset] = [Preset(image: "yes.png", expression: "yes"), Preset(image: "no.png", expression: "no"), Preset(image: "hello.png", expression: "hello"), Preset(image: "goodbye.png", expression: "goodbye"), Preset(image: "Idonotknow.png", expression: "I do not know"), Preset(image: "celebrate.png", expression: "celebrate")]
    
    var organizationPresets: [Preset] = [Preset(image: "airport.png", expression: "airport"), Preset(image: "business.png", expression: "business"), Preset(image: "church.png", expression: "church"), Preset(image: "circus.png", expression: "circus"), Preset(image: "hospital.png", expression: "hospital"), Preset(image: "government.png", expression: "government")]

    var locationPresets: [Preset] = [Preset(image: "park.png", expression: "park"), Preset(image: "office.png", expression: "office"), Preset(image: "school.png", expression: "school"), Preset(image: "theater.png", expression: "theater"), Preset(image: "home.png", expression: "home"), Preset(image: "beach.png", expression: "beach")]
    
    var personPresets: [Preset] = [Preset(image: "mother.png", expression: "mother"), Preset(image: "father.png", expression: "father"), Preset(image: "brother.png", expression: "brother"), Preset(image: "sister.png", expression: "sister"), Preset(image: "musician.png", expression: "musician"), Preset(image: "acrobat.png", expression: "acrobat")]
    
    var artPresets: [Preset] = [Preset(image: "art.png", expression: "art"), Preset(image: "musician.png", expression: "musician"), Preset(image: "singer.png", expression: "singer"), Preset(image: "book.png", expression: "book"), Preset(image: "movie.png", expression: "movie"), Preset(image: "painting.png", expression: "painting")]
    
    var consumerPresets: [Preset] = [Preset(image: "ball.png", expression: "ball"), Preset(image: "phone.png", expression: "phone"), Preset(image: "car.png", expression: "car"), Preset(image: "tabletComputer.png", expression: "tablet computer"), Preset(image: "toy.png", expression: "toy"), Preset(image: "videoGame.png", expression: "video game")]
    
    var eventPresets: [Preset] = [Preset(image: "tvShow.png", expression: "television show"), Preset(image: "accident.png", expression: "accident"), Preset(image: "holiday.png", expression: "holiday"), Preset(image: "nye.png", expression: "new year's eve"), Preset(image: "sportingEvent.png", expression: "sporting event"), Preset(image: "play.png", expression: "play")]
    
    var feelingPresets: [Preset] = [Preset(image: "happy.png", expression: "happy"), Preset(image: "confused.png", expression: "confused"), Preset(image: "angry.png", expression: "angry"), Preset(image: "sad.png", expression: "sad"), Preset(image: "surprised.png", expression: "surprised"), Preset(image: "tired.png", expression: "tired")]

    
    var selectedGroup = "DEFAULT"
    
    
    let speechSynthesizer = AVSpeechSynthesizer()
    
    var dataReceived: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // show the keyboard on launch
        mainTextField.becomeFirstResponder()
        super.viewDidLoad()
        
        // set up preset buttons
        showDefaults()
        
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
        var stringToSpeak:String
        
        switch(selectedGroup)
        {
        case "DEFAULT":
             stringToSpeak = initialPresets[ind].expression
            break
        case "ORGANIZATION":
            stringToSpeak = organizationPresets[ind].expression
            break
        case "LOCATION":
            stringToSpeak = locationPresets[ind].expression
            break
        case "WORK_OF_ART":
            stringToSpeak = artPresets[ind].expression
            break
        case "PERSON":
            stringToSpeak = personPresets[ind].expression
            break
        case "EVENT":
            stringToSpeak = eventPresets[ind].expression
            break
        case "CONSUMER_GOOD":
            stringToSpeak = consumerPresets[ind].expression
            break
        case "FEELING":
            stringToSpeak = feelingPresets[ind].expression
            break
        default:
            stringToSpeak = initialPresets[ind].expression
            break
        }
        
        let speechUtterance = AVSpeechUtterance(string: stringToSpeak)
        
        speechSynthesizer.speak(speechUtterance)
    }
    
    func changePredictedElements(elements: [Preset])
    {
        // gotta do ui on main thread
        DispatchQueue.main.async(){
            for (index, element) in elements.enumerated()
            {
                switch(index)
                {
                case 0:
                    let imageToSet:UIImage? = UIImage(named: element.image)
                    
                    if (imageToSet != nil)
                    {
                        self.button0.setImage(imageToSet, for: UIControlState.normal)
                    }
                    else
                    {
                        print("Why is my image nil?")
                    }
                    self.button0.layer.borderWidth = 1
                    self.button0.layer.borderColor = UIColor.black.cgColor
                    self.button0.setNeedsDisplay()
                    self.button0.setNeedsLayout()
                    break
                case 1:
                    let imageToSet:UIImage? = UIImage(named: element.image)
                    
                    if (imageToSet != nil)
                    {
                        self.button1.setImage(imageToSet, for: UIControlState.normal)
                    }
                    else
                    {
                        print("Why is my image nil?")
                    }
                    self.button1.layer.borderWidth = 1
                    self.button1.layer.borderColor = UIColor.black.cgColor
                    self.button1.setNeedsDisplay()
                    self.button1.setNeedsLayout()
                    break
                case 2:
                    let imageToSet:UIImage? = UIImage(named: element.image)
                    
                    if (imageToSet != nil)
                    {
                        self.button2.setImage(imageToSet, for: UIControlState.normal)
                    }
                    else
                    {
                        print("Why is my image nil?")
                    }
                    self.button2.layer.borderWidth = 1
                    self.button2.layer.borderColor = UIColor.black.cgColor
                    self.button2.setNeedsDisplay()
                    self.button2.setNeedsLayout()
                    break
                case 3:
                    let imageToSet:UIImage? = UIImage(named: element.image)
                    
                    if (imageToSet != nil)
                    {
                        self.button3.setImage(imageToSet, for: UIControlState.normal)
                    }
                    else
                    {
                        print("Why is my image nil?")
                    }
                    self.button3.layer.borderWidth = 1
                    self.button3.layer.borderColor = UIColor.black.cgColor
                    self.button3.setNeedsDisplay()
                    self.button3.setNeedsLayout()
                    break
                case 4:
                    let imageToSet:UIImage? = UIImage(named: element.image)
                    
                    if (imageToSet != nil)
                    {
                        self.button4.setImage(imageToSet, for: UIControlState.normal)
                    }
                    else
                    {
                        print("Why is my image nil?")
                    }
                    self.button4.layer.borderWidth = 1
                    self.button4.layer.borderColor = UIColor.black.cgColor
                    self.button4.setNeedsDisplay()
                    self.button4.setNeedsLayout()
                    break
                case 5:
                    let imageToSet:UIImage? = UIImage(named: element.image)
                    
                    if (imageToSet != nil)
                    {
                        self.button5.setImage(imageToSet, for: UIControlState.normal)
                    }
                    else
                    {
                        print("Why is my image nil?")
                    }
                    self.button5.layer.borderWidth = 1
                    self.button5.layer.borderColor = UIColor.black.cgColor
                    self.button5.setNeedsDisplay()
                    self.button5.setNeedsLayout()
                    break
                default: break
                }
            }
            self.view.setNeedsDisplay()
            self.view.setNeedsLayout()
        }
    }
    
    func showLocation()
    {
        changePredictedElements(elements: locationPresets)
        selectedGroup = "LOCATION"
    }
    
    func showOrganization()
    {
        changePredictedElements(elements: organizationPresets)
        selectedGroup = "ORGANIZATION"
    }
    
    func showWorkOfArt()
    {
        changePredictedElements(elements: artPresets)
        selectedGroup = "WORK_OF_ART"
    }
    
    func showEvent()
    {
        changePredictedElements(elements: eventPresets)
        selectedGroup = "EVENT"
    }
    
    func showConsumerGood()
    {
        changePredictedElements(elements: consumerPresets)
        selectedGroup = "CONSUMER_GOOD"
    }
    
    func showPerson()
    {
        changePredictedElements(elements: personPresets)
        selectedGroup = "PERSON"
    }
    
    func showFeeling()
    {
        changePredictedElements(elements: feelingPresets)
        selectedGroup = "FEELING"
    }
    
    func showDefaults()
    {
        changePredictedElements(elements: initialPresets)
        selectedGroup = "DEFAULT"
    }

    
    func sendToServer(data: String)
    {
        // prepare json data
//        let json: [String: Any] = ["document": ["type": "PLAIN_TEXT",
//                                   "content": data]]
        
        let json = [
            "document": [
                "type": "PLAIN_TEXT",
                "content":data
            ]
        ]
        
        if JSONSerialization.isValidJSONObject(json)
        {

            let jsonData = try? JSONSerialization.data(withJSONObject: json)
            
            let url = URL(string: "https://communicationstation-158117.appspot.com/upload_json")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            // insert json data to the request
            request.httpBody = jsonData
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let task = URLSession.shared.dataTask(with: request)
            { data, response, error in
                guard let data = data, error == nil else
                {
                    print(error?.localizedDescription ?? "No data")
                    return
                }
                
                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                
                if let responseJSON = responseJSON as? [String: Any]
                {
//                    print("response: ",  responseJSON)
                    self.processResponse(responseJSON: responseJSON)
                }
            }
            
            task.resume()
        }
    }
    
    func processResponse(responseJSON: [String: Any])
    {
        print(responseJSON)
        
//        var feeling = 0
        var work_of_art = 0
        var person = 0
        var organization = 0
        var location = 0
        var event = 0
        var consumer_good = 0
        
        let originalStatement = responseJSON["original_statement"] as? String
        
        // general rules
        if (originalStatement!.lowercased().range(of:"feel") != nil)
        {
            showFeeling()
        }
        else if (originalStatement!.lowercased().range(of:"where") != nil)
        {
            showLocation()
        }
        else if (originalStatement!.lowercased().range(of:"who") != nil)
        {
            showPerson()
        }
        else
        {
            let entities = responseJSON["entities"] as? [[String: Any]]
            for entity in entities!
            {
                print("___________________________________");
                let type = entity["type"] as! String
                
                switch (type)
                {
                case "LOCATION":
                    location += 1
                    break
                case "WORK_OF_ART":
                    work_of_art += 1
                    break
                case "PERSON":
                    person += 1
                    break
                case "ORGANIZATION":
                    organization += 1
                    break
                case "EVENT":
                    event += 1
                    break
                case "CONSUMER_GOOD":
                    consumer_good += 1
                    break
                default:
                    break
                }
                print(type)
                print("___________________________________");

            }

            let maximum = max(consumer_good, event, organization, person, work_of_art, location)
            
            if (maximum != 0)
            {
                switch(maximum)
                {
                case consumer_good:
                    showConsumerGood()
                    break
                case event:
                    showEvent()
                    break
                case organization:
                    showOrganization()
                    break
                case person:
                    showPerson()
                    break
                case work_of_art:
                    showWorkOfArt()
                    break
                case location:
                    showLocation()
                    break
                default:
                    break
                }
            }
            else
            {
                // show defaults
                showDefaults()
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
        
        print(dataReceived);
        
        sendToServer(data: dataReceived!);
    }
}

