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
    
}
    
