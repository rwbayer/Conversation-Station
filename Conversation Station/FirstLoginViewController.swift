//
//  FirstLoginViewController.swift
//  Conversation Station
//
//  Created by Bobby Bayer on 4/29/17.
//  Copyright © 2017 Robert Bayer. All rights reserved.
//

import UIKit

class FirstLoginViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        switch(indexPath.row)
        {
        case 1:
            print("Row 1")
            break
        case 2:
            break
        case 3:
            break
            
        }
        
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        
        cell.textLabel?.text = self.items[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
         println("You selected cell #\(indexPath.row)!")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 3;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1;
    }
}
