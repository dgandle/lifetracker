//
//  DataViewController.swift
//  lifetracker
//
//  Created by Doug Gandle on 11/10/16.
//  Copyright © 2016 Doug Gandle. All rights reserved.
//

import UIKit
import RealmSwift

class DataViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let realm = try! Realm()
    
    //Generate activity list: List of all activities
    //Each activity in list has title, type, and value
    var numActivities:Results<NumberActivity>!
    var dateActivities:Results<DateActivity>!
    var moodActivities:Results<MoodActivity>!
    var boolActivities:Results<BooleanActivity>!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        numActivities = realm.objects(NumberActivity.self)
        dateActivities = realm.objects(DateActivity.self)
        moodActivities = realm.objects(MoodActivity.self)
        boolActivities = realm.objects(BooleanActivity.self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //temporary value
        return numActivities.count+dateActivities.count+moodActivities.count+boolActivities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell") as! DataTableViewCell
        if (indexPath.row < numActivities.count) {
            //let cell = tableView.dequeueReusableCellWithIdentifier("counterCell") as! CounterTableViewCell
            cell.activityName.text = numActivities[indexPath.row].name
            cell.activityType.text = "Counter"
            return cell
        }else if(indexPath.row < numActivities.count+moodActivities.count){
            cell.activityName.text = moodActivities[indexPath.row-numActivities.count].name
            cell.activityType.text = "Mood"
            return cell
        }
        else if(indexPath.row < numActivities.count+moodActivities.count+boolActivities.count){
            cell.activityName.text = boolActivities[indexPath.row-(numActivities.count+moodActivities.count)].name
            cell.activityType.text = "Yes/No"
            return cell
        }
        else{//case that it is a date cell
            cell.activityName.text = dateActivities[indexPath.row-(numActivities.count+moodActivities.count+boolActivities.count)].name
            cell.activityType.text = "Time"
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

