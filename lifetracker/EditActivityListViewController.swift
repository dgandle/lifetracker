//
//  EditActivityListViewController.swift
//  lifetracker
//
//  Created by Doug Gandle on 12/11/16.
//  Copyright © 2016 Doug Gandle. All rights reserved.
//

import UIKit
import RealmSwift

class EditActivityListViewController: UIViewController {

    let realm = try! Realm()
    
    var numActivities:Results<NumberActivity>!
    var dateActivities:Results<DateActivity>!
    var moodActivities:Results<MoodActivity>!
    var boolActivities:Results<BooleanActivity>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numActivities.count+dateActivities.count+moodActivities.count+boolActivities.count+1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("basicTableViewCell")! as UITableViewCell
            
        print("did work")
            
        if (indexPath.row < numActivities.count) {
            cell.textLabel!.text = numActivities[indexPath.row].name
            cell.textLabel!.text = "Hello world"
        }
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "activities"
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
