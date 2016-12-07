//
//  DashboardViewController.swift
//  lifetracker
//
//  Created by Doug Gandle on 11/29/16.
//  Copyright © 2016 Doug Gandle. All rights reserved.
//

import UIKit

@IBDesignable

class DashboardViewController:UIViewController, UITableViewDelegate, UITableViewDataSource {

    struct MyData {
        var firstRowLabel:String
    }
    
    var tableData: [MyData] = []
    
    
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

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        searchBar.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        
        if (indexPath.row == 0) {
            let cell = tableView.dequeueReusableCellWithIdentifier("todayHeaderCell") as! TodayTableViewCell
            return cell
        } else if (indexPath.row == 1) {
            let cell = tableView.dequeueReusableCellWithIdentifier("counterCell") as! CounterTableViewCell
            cell.counterLabel.text = "Counter Cell"
            return cell
        } else if (indexPath.row == 2){
            let cell = tableView.dequeueReusableCellWithIdentifier("sliderCell") as! SliderTableViewCell
            cell.sliderLabel.text = "Slider Cell"
            return cell
        } else if (indexPath.row == 3){
            let cell = tableView.dequeueReusableCellWithIdentifier("timeCell") as! TimeTableViewCell
            cell.timeLabel.text = "Time Cell"
            return cell
        } else {
            
        // Create a new cell with the reuse identifier of our prototype cell
        // as our custom table cell class
        let cell = tableView.dequeueReusableCellWithIdentifier("booleanCell") as! BooleanTableViewCell
        
        // Set the first row text label to the firstRowLabel data in our current array item
        cell.booleanLabel.text = "Boolean Cell"
        
        // Return our new cell for display
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
