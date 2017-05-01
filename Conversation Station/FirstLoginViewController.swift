//
//  FirstLoginViewController.swift
//  Conversation Station
//
//  Created by Bobby Bayer on 4/29/17.
//  Copyright © 2017 Robert Bayer. All rights reserved.
//

import UIKit

class FirstLoginViewController: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // set defaults
        UserDefaults.standard.set("Alice", forKey: defaultsKeys.keyOne) // voice
        UserDefaults.standard.set("", forKey: defaultsKeys.keyThree) // name
        UserDefaults.standard.set(6, forKey: defaultsKeys.keyThree) // number of options
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem)
    {
        UserDefaults.standard.set(true, forKey: defaultsKeys.keyZero)
        self.performSegue(withIdentifier: "loginSuccess", sender: self)
    }
    
}
