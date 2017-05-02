//
//  SettingsTableViewController.swift
//  Conversation Station
//
//  Created by Bobby Bayer on 4/30/17.
//  Copyright © 2017 Robert Bayer. All rights reserved.
//

import Foundation
import UIKit

class SettingsTableViewController: UITableViewController, UITextFieldDelegate
{
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var voiceDetailLabel: UILabel!
    @IBOutlet weak var numberOfOptionsDetailLabel: UILabel!
    
    var voice:String = UserDefaults.standard.string(forKey: defaultsKeys.keyOne)!
    {
        didSet
        {
            voiceDetailLabel.text? = voice
        }
    }
    
    var numberOfOptions:Int = UserDefaults.standard.integer(forKey: defaultsKeys.keyThree)
    {
        didSet
        {
            numberOfOptionsDetailLabel.text? = String(numberOfOptions)
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        voiceDetailLabel.text? = voice
        numberOfOptionsDetailLabel.text? = String(numberOfOptions)
        print("number of options is" + String(numberOfOptions))
        nameTextField.text = UserDefaults.standard.string(forKey: defaultsKeys.keyTwo)!
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
        tap.cancelsTouchesInView = false
        self.tableView.addGestureRecognizer(tap)
        self.nameTextField.delegate = self
    }
    
    func dismissKeyboard()
    {
        nameTextField.resignFirstResponder()
        UserDefaults.standard.set(nameTextField.text, forKey: defaultsKeys.keyTwo) // name
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        dismissKeyboard()
        return true
    }
  
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if indexPath.section == 0
        {
            nameTextField.becomeFirstResponder()
        }
    }
    
    @IBAction func unwindWithSelectedVoice(segue:UIStoryboardSegue)
    {
        if let voicePickerViewController = segue.source as? VoicePickerTableViewController, let selectedVoice = voicePickerViewController.selectedVoice
        {
            voice = selectedVoice
             UserDefaults.standard.set(voice, forKey: defaultsKeys.keyOne) // voice
        }
    }
    
    @IBAction func unwindWithSelectedNumberOfOptions(segue:UIStoryboardSegue)
    {
        if let numberOfOptionsPickerViewController = segue.source as? NumberOfOptionsPickerTableViewController, let selectedNumberOfOptions = numberOfOptionsPickerViewController.selectedNumberOfOptions
        {
            numberOfOptions = selectedNumberOfOptions
             UserDefaults.standard.set(numberOfOptions, forKey: defaultsKeys.keyThree) // number of options
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        UserDefaults.standard.set(nameTextField.text, forKey: defaultsKeys.keyTwo) // name

//        if segue.identifier == "SavePlayerDetail"
//        {
////            player = Player(name: nameTextField.text, game:game, rating: 1)
//        }
        if segue.identifier == "pickVoice"
        {
            if let voicePickerViewController = segue.destination as? VoicePickerTableViewController
            {
                voicePickerViewController.selectedVoice = voice
            }
        }
        else if segue.identifier == "pickNumberOfOptions"
        {
            if let numberOfOptionsPickerViewController = segue.destination as? NumberOfOptionsPickerTableViewController
            {
                numberOfOptionsPickerViewController.selectedNumberOfOptions = numberOfOptions
            }
        }
    }
}
