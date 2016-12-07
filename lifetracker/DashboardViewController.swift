//
//  DashboardViewController.swift
//  lifetracker
//
//  Created by Doug Gandle on 11/10/16.
//  Copyright © 2016 Doug Gandle. All rights reserved.
//

import UIKit
import RealmSwift

class DashboardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //check to see if we have moved on to a new day
        newDayReset()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func pressButton(sender: AnyObject) {
        incrementNumActivity("Cups of Water",date: NSDate(),incVal: 5)
        incrementNumActivity("Cups of Water",date: NSDate().dateByAddingTimeInterval(oneDay),incVal: 5)
        incrementNumActivity("Cups of Wat",date: NSDate(),incVal: 5)
    }
}

