//
//  SettingsViewController.swift
//  lifetracker
//
//  Created by Doug Gandle on 11/10/16.
//  Copyright © 2016 Doug Gandle. All rights reserved.
//

import UIKit
import RealmSwift

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var editListTableView: UITableView!
    
    let realm = try! Realm()
    
    var numActivities:Results<NumberActivity>!
    var dateActivities:Results<DateActivity>!
    var moodActivities:Results<MoodActivity>!
    var boolActivities:Results<BooleanActivity>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        numActivities = realm.objects(NumberActivity.self)
        dateActivities = realm.objects(DateActivity.self)
        moodActivities = realm.objects(MoodActivity.self)
        boolActivities = realm.objects(BooleanActivity.self)

        if (self.title == "Edit-Activity-List") {
            navigationItem.rightBarButtonItem = editButtonItem
        }

        self.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "settingsIcon")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "settingsIcon"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.title == "Settings") {
            return 1
        } else if (self.title == "Edit-Activity-List") {
            return numActivities.count+dateActivities.count+moodActivities.count+boolActivities.count
        } else {
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (self.title == "Settings") {
            let cell =  tableView.dequeueReusableCell(withIdentifier: "editActivityListCell")! as UITableViewCell
            return cell
        } else if (self.title == "Edit-Activity-List") {
            let cell = tableView.dequeueReusableCell(withIdentifier: "basicTableViewCell")! as UITableViewCell
            
            if (indexPath.row < numActivities.count) { //problem is here
                cell.textLabel!.text = numActivities[indexPath.row].name
            } else if (indexPath.row < numActivities.count+moodActivities.count) {
                cell.textLabel!.text = moodActivities[indexPath.row-numActivities.count].name
            } else if (indexPath.row < numActivities.count+moodActivities.count+boolActivities.count) {
                cell.textLabel!.text = boolActivities[indexPath.row-(numActivities.count+moodActivities.count)].name
            } else {
                cell.textLabel!.text = dateActivities[indexPath.row-(numActivities.count+boolActivities.count+moodActivities.count)].name
            }
            
            return cell
            
        } else {
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (self.title == "Settings") {
            return "activities"
        } else {
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func editButtonPressed(_ sender: AnyObject) {
        print("edit pressed")
    }
    
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            removeActivity((tableView.cellForRow(at: indexPath)!.textLabel!.text)!)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    // Override to support conditional editing of the table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        editListTableView.setEditing(editing, animated: animated)
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
