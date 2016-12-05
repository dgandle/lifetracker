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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func pressTest2(sender: AnyObject) {
        let today = NSDate()
        print("Pt2: The Date is " + today.description)
        setActivityValue("Cups of Water", date: today, boolInput: nil, numInput: 5, moodInput: nil, dateInput: nil)
        print("The number of cups of water tomorrow is "+String(getActivityValue("Cups of Water", date: today).numVal!))
        addNewActivity("Pushups", type: "Number")
        setActivityValue("Pushups", date: today, boolInput: nil, numInput: 100, moodInput: nil, dateInput: nil)
        //print("The number of pushups tomorrow is "+String(getActivityValue("Cups of Water", date: today).numVal!))
        setActivityValue("Pushups", date: today.dateByAddingTimeInterval(-oneDay), boolInput: nil, numInput: 50, moodInput: nil, dateInput: nil)
    }
    @IBAction func pressButton(sender: AnyObject) {
        let today = NSDate()
        print("The Date is " + today.description)
//        initDB()
//        addNewActivity("Cups of Water", type: "Number")
//        addNewActivity("Cups of Water", type: "Number")
//        removeActivity("Cups of Water")
//        removeActivity("Cups of Water")
//        addNewActivity("Cups of Water", type: "Number")
//        addNewActivity("Worked out today?", type: "Boolean")
//        addNewActivity("Happiness", type: "Mood")
//        addNewActivity("Sleep Last Night", type: "Date")
//        setActivityValue("Cups of Water", date: today.dateByAddingTimeInterval(-oneDay), boolInput: nil, numInput: 3, moodInput: nil, dateInput: nil)
//        setActivityValue("Cups of Water", date: today, boolInput: nil, numInput: 4, moodInput: nil, dateInput: nil)
//        setActivityValue("Cups of Water", date: today.dateByAddingTimeInterval(oneDay), boolInput: nil, numInput: 5, moodInput: nil, dateInput: nil)
//        print("The number of cups of water today is "+String(getActivityValue("Cups of Water", date: today).numVal!))
        
        
        
        
        
        
//        let log1 = BooleanActivity()
//        log1.name = "Worked Out Today"
//        //log1.values.append(MyBoolean(value: false))
//        let newBool1 = MyBoolean()
//        newBool1.value = true;
//        log1.values.append(newBool1)
//        
//        //let log2 = MoodLog()
//        //log2.name = "Quality Of Workout"
//        //log2.values.append(0);
//        //log2.values.append(4);
//        
//        let realm = try! Realm()
//        
//        try! realm.write {
//            realm.add(log1)
//            //realm.add(log2)
//        }
//        
//        let booleans = realm.objects(BooleanActivity.self)
//        print(booleans.count)
//        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        
        //let moods = realm.objects(MoodLog.self)
        //print(moods.count)
    }

}

