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
    @IBOutlet weak var booleanSelectActivityButton: SelectActivityTypeButton!
    @IBOutlet weak var sliderSelectActivityButton: SelectActivityTypeButton!
    @IBOutlet weak var counterSelectActivityButton: SelectActivityTypeButton!
    @IBOutlet weak var timeSelectActivityButton: SelectActivityTypeButton!
    
    
    
    @IBAction func circleTapped(_ sender:UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        newDayReset()
        
        numActivities = realm.objects(NumberActivity.self)
        dateActivities = realm.objects(DateActivity.self)
        moodActivities = realm.objects(MoodActivity.self)
        boolActivities = realm.objects(BooleanActivity.self)
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        if (self.title == "Add New Activity") {
            booleanSelectActivityButton.isSelected = true
            sliderSelectActivityButton.isSelected = false
            counterSelectActivityButton.isSelected = false
            timeSelectActivityButton.isSelected = false
            
            booleanSelectActivityButton?.alternateButton = [sliderSelectActivityButton!, counterSelectActivityButton!, timeSelectActivityButton!]
            sliderSelectActivityButton?.alternateButton = [booleanSelectActivityButton!, counterSelectActivityButton!, timeSelectActivityButton!]
            counterSelectActivityButton?.alternateButton = [booleanSelectActivityButton!, sliderSelectActivityButton!, timeSelectActivityButton!]
            timeSelectActivityButton?.alternateButton = [booleanSelectActivityButton!, sliderSelectActivityButton!, counterSelectActivityButton!]
            
            createNewActivityButton.isEnabled = false
            createNewActivityButton.alpha = 0.7
            
            let border = CALayer()
            let width = CGFloat(1.0)
            border.borderColor = UIColor.white.cgColor
            border.frame = CGRect(x: 0, y: newActivityName.frame.size.height - width, width:  newActivityName.frame.size.width, height: newActivityName.frame.size.height)
            border.borderWidth = width
            newActivityName.layer.addSublayer(border)
            newActivityName.layer.masksToBounds = true
            
            addNewActivityButton.backgroundCircleColor = UIColor.white
            addNewActivityButton.plusColor = UIColor(red: 58/255, green: 197/255, blue: 105/255, alpha: 1.0)

        }
        
        //Set inactive tab bar image to be white, not grey
        self.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "dashboardIcon")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "dashboardIcon"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numActivities.count+dateActivities.count+moodActivities.count+boolActivities.count+1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        searchBar.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        
        //Enables instant highlighting of stepper when also turned on in IB
        for case let x as UIScrollView in tableView.subviews {
            x.delaysContentTouches = false
        }
        
        
        if (indexPath.row == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "todayHeaderCell") as! TodayTableViewCell
            return cell
        } else if (indexPath.row - 1 < numActivities.count) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "counterCell") as! CounterTableViewCell
            cell.counterLabel.text = numActivities[indexPath.row-1].name
            cell.counterValue.text = String(numActivities[indexPath.row-1].values.last!.value)
            cell.counterStepper.value = Double(getActivityValue(cell.counterLabel.text!, date: Date()).numVal!)
            return cell
        }else if(indexPath.row - 1 < numActivities.count+moodActivities.count){
            let cell = tableView.dequeueReusableCell(withIdentifier: "sliderCell") as! SliderTableViewCell
            cell.sliderLabel.text = moodActivities[indexPath.row-1-numActivities.count].name
            cell.sliderSlider.value = Float(getActivityValue(cell.sliderLabel.text!, date: Date()).moodVal!)
            return cell
        }
        else if(indexPath.row - 1 < numActivities.count+moodActivities.count+boolActivities.count){
            let cell = tableView.dequeueReusableCell(withIdentifier: "booleanCell") as! BooleanTableViewCell
            cell.booleanLabel.text = boolActivities[indexPath.row-1-(numActivities.count+moodActivities.count)].name
            return cell
        }
        else{//case that it is a date cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "timeCell") as! TimeTableViewCell
            cell.timeLabel.text = dateActivities[indexPath.row-1-(numActivities.count+moodActivities.count+boolActivities.count)].name
            let timeFormatter = DateFormatter()
            timeFormatter.timeStyle = DateFormatter.Style.short
            let time = dateActivities[indexPath.row-1-(numActivities.count+moodActivities.count+boolActivities.count)].values.last!.value
            cell.timeValue.text = timeFormatter.string(from: time)
            cell.datePicker.date = time
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if (indexPath.row == 0) {
            return 160.0
        } else {
            return 90.0;
        }
    }

    @IBAction func textFieldDoneEditing(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func onTapGestureRecognized(_ sender: AnyObject) {
        searchBar.resignFirstResponder()
    }
    
    @IBAction func onTapGestureRecognizedTwo(_ sender: AnyObject) {
        newActivityName.resignFirstResponder()
    }
    
    
    
    @IBAction func createNewActivityButtonPressed(_ sender: AnyObject) {
        let name = newActivityName.text!
        
        if (nameExistsAlready(name).exists) {
            let alertController = UIAlertController(title: "Error", message:
                "An activity with that name already exists.", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        
        if (booleanSelectActivityButton.isSelected) {
            addNewActivity(newActivityName.text!, type: "Boolean")
        } else if (sliderSelectActivityButton.isSelected) {
            addNewActivity(newActivityName.text!, type: "Mood")
        } else if (counterSelectActivityButton.isSelected) {
            addNewActivity(newActivityName.text!, type: "Number")
        } else if (timeSelectActivityButton.isSelected) {
            addNewActivity(newActivityName.text!, type: "Date")
        }
    }

    @IBAction func newActNameEditingChanged(_ sender: AnyObject) {
        if (newActivityName.text!.isEmpty == false) {
            createNewActivityButton.isEnabled = true
            createNewActivityButton.alpha = 1
        } else {
            createNewActivityButton.isEnabled = false
            createNewActivityButton.alpha = 0.7
        }
    }
    
    @IBAction func newActNameEditingDIdEnd(_ sender: AnyObject) {
        if (newActivityName.text!.isEmpty == false) {
            createNewActivityButton.isEnabled = true
            createNewActivityButton.alpha = 1
        } else {
            createNewActivityButton.isEnabled = false
            createNewActivityButton.alpha = 0.7
        }
    }
    
    @IBAction func unwindToDashboard(_ sender: UIStoryboardSegue) {
        
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
