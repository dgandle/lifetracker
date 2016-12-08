//
//  DashboardViewController.swift
//  lifetracker
//
//  Created by Doug Gandle on 11/29/16.
//  Copyright © 2016 Doug Gandle. All rights reserved.
//

import UIKit
import RealmSwift

@IBDesignable

class DashboardViewController:UIViewController, UITableViewDelegate, UITableViewDataSource {

    let realm = try! Realm()
    
    //Generate activity list: List of all activities
    //Each activity in list has title, type, and value
    var numActivities:Results<NumberActivity>!
    var dateActivities:Results<DateActivity>!
    var moodActivities:Results<MoodActivity>!
    var boolActivities:Results<BooleanActivity>!
    
    //Dashboard Main Page Items
    @IBOutlet weak var addNewActivityButton: AddNewActivityButton!
    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var backgroundCircle: DashboardBackgroundCircle!
    
    //Dashboard Add New Activity Page Items
    @IBOutlet weak var newActivityName: UITextField!
    @IBOutlet weak var createNewActivityButton: UIButton!
    
    
    @IBAction func circleTapped(sender:UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newDayReset()
        
        //test code: REMOVE LATER
        //addNewActivity("Cups of Coffee Drank", type: "Number")
        //addNewActivity("Time of Meal", type: "Date")
        //addNewActivity("Satisfaction Level", type: "Mood")
        //addNewActivity("Would I do it again", type: "Boolean")
        addNewActivity("Naps Taken", type: "Number")
        //setActivityValue("Cups of Coffee Drank", date: NSDate(), boolInput: nil, numInput: 5000, moodInput: nil, dateInput: nil)
        setActivityValue("Naps Taken", date: NSDate(), boolInput: nil, numInput: 99, moodInput: nil, dateInput: nil)
        //setActivityValue("Time of Meal", date: NSDate(), boolInput: nil, numInput: nil, moodInput: nil, dateInput: NSDate())
        //setActivityValue("Satisfaction Level", date: NSDate(), boolInput: nil, numInput: nil, moodInput: 5, dateInput: nil)
        //setActivityValue("Would I do it again", date: NSDate(), boolInput: true, numInput: nil, moodInput: nil, dateInput: nil)
        //test code: REMOVE LATER
        
        numActivities = realm.objects(NumberActivity.self)
        dateActivities = realm.objects(DateActivity.self)
        moodActivities = realm.objects(MoodActivity.self)
        boolActivities = realm.objects(BooleanActivity.self)
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //temporary value
        return numActivities.count+dateActivities.count+moodActivities.count+boolActivities.count+1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        searchBar.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        
        if (indexPath.row == 0) {
            let cell = tableView.dequeueReusableCellWithIdentifier("todayHeaderCell") as! TodayTableViewCell
            return cell
        } else if (indexPath.row - 1 < numActivities.count) {
            let cell = tableView.dequeueReusableCellWithIdentifier("counterCell") as! CounterTableViewCell
            cell.counterLabel.text = numActivities[indexPath.row-1].name
            cell.counterValue.text = String(numActivities[indexPath.row-1].values.last!.value)
            return cell
//        }
        
        
        
        //Old Test Code
//        if (indexPath.row == 0) {
//            let cell = tableView.dequeueReusableCellWithIdentifier("todayHeaderCell") as! TodayTableViewCell
//            return cell
//        } else if (indexPath.row == 1) {
//            let cell = tableView.dequeueReusableCellWithIdentifier("counterCell") as! CounterTableViewCell
//            cell.counterLabel.text = "Counter Cell"
//            return cell
        }else if(indexPath.row - 1 < numActivities.count+moodActivities.count){
            let cell = tableView.dequeueReusableCellWithIdentifier("sliderCell") as! SliderTableViewCell
            cell.sliderLabel.text = moodActivities[indexPath.row-1-numActivities.count].name
            return cell
        }
        else if(indexPath.row - 1 < numActivities.count+moodActivities.count+boolActivities.count){
            let cell = tableView.dequeueReusableCellWithIdentifier("booleanCell") as! BooleanTableViewCell
            cell.booleanLabel.text = boolActivities[indexPath.row-1-(numActivities.count+moodActivities.count)].name
            return cell
        }
        else{//case that it is a date cell
            let cell = tableView.dequeueReusableCellWithIdentifier("timeCell") as! TimeTableViewCell
            cell.timeLabel.text = dateActivities[indexPath.row-1-(numActivities.count+moodActivities.count+boolActivities.count)].name
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        if (indexPath.row == 0) {
            return 160.0
        } else {
            return 90.0;
        }
    }

    @IBAction func textFieldDoneEditing(sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func onTapGestureRecognized(sender: AnyObject) {
        searchBar.resignFirstResponder()
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
