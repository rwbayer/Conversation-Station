//
//  SettingsViewController.swift
//  Conversation Station
//
//  Created by Bobby Bayer on 4/29/17.
//  Copyright © 2017 Robert Bayer. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController
{
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem)
    {
        self.performSegue(withIdentifier: "backToMainScreenFromSettings", sender: self)
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
//        saveSettings()
    }
    
//    func saveSettings()
//    {
////        let defaults = UserDefaults.standard
////        defaults.set("default", forKey: defaultsKeys.keyOne) // voice
////        defaults.set("Davis", forKey: defaultsKeys.keyTwo) // name
////        defaults.set("6", forKey: defaultsKeys.keyThree) // number of options
//    }
}
    
