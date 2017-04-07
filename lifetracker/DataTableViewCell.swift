//
//  DataTableViewCell.swift
//  lifetracker
//
//  Created by Benjamin Danzig on 12/9/16.
//  Copyright © 2016 Doug Gandle. All rights reserved.
//

import UIKit
import RealmSwift

class DataTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var activityName: UILabel!
    @IBOutlet weak var activityType: UILabel!
    
    var dateFormatter = DateFormatter()
    
    let viewController:ChartViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "chartViewController") as! ChartViewController
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
        let realm = try! Realm()
        //get the totalDays and the currentDay
        let dbInfo = realm.objects(DBInfo.self)[0]
        let totalDays = dbInfo.totalDays
        let currentDay = dbInfo.currentDay
        
        if(selected == true){
            
            let existenceCheck = nameExistsAlready(activityName.text!)
            if((existenceCheck.boolAct) != nil){
                var days: [String] = []//this should be the days of the week before
                for i in 0...totalDays-1-existenceCheck.boolAct!.indexOffset{
                    //CONVERT FROM NSDate to String
                    let date = currentDay.addingTimeInterval(oneDay*Double(i-(totalDays-1-existenceCheck.boolAct!.indexOffset)))
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "MM/dd"
                    let dateString = dateFormatter.string(from: date)
                    print(dateString)
                    days.append(dateString)
                }
                let boolArr = convertMyBooleanListToDoubleArray(existenceCheck.boolAct!.values)
                viewController.initSetChartParameters(days,values: boolArr,yLabel:activityName.text!)
            }
            else if((existenceCheck.numAct) != nil){
                var days:[String] = []//this should be the days of the week before
                for i in 0...totalDays-1-existenceCheck.numAct!.indexOffset{
                    //CONVERT FROM NSDate to String
                    let date = currentDay.addingTimeInterval(oneDay*Double(i-(totalDays-1-existenceCheck.numAct!.indexOffset)))
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "MM/dd"
                    let dateString = dateFormatter.string(from: date)
                    days.append(dateString)
                }
                let numArr = convertMyNumberListToDoubleArray(existenceCheck.numAct!.values)
                viewController.initSetChartParameters(days,values: numArr,yLabel:activityName.text!)
            }
            else if((existenceCheck.moodAct) != nil){
                var days: [String] = []//this should be the days of the week before
                for i in 0...totalDays-1-existenceCheck.moodAct!.indexOffset{
                    //CONVERT FROM NSDate to String
                    let date = currentDay.addingTimeInterval(oneDay*Double(i-(totalDays-1-existenceCheck.moodAct!.indexOffset)))
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "MM/dd"
                    let dateString = dateFormatter.string(from: date)
                    days.append(dateString)
                }
                let moodArr = convertMyMoodListToDoubleArray(existenceCheck.moodAct!.values)
                viewController.initSetChartParameters(days,values: moodArr,yLabel:activityName.text!)
            }
            else if((existenceCheck.dateAct) != nil){
                var days: [String] = []//this should be the days of the week before
                for i in 0...totalDays-1-existenceCheck.dateAct!.indexOffset{
                    //CONVERT FROM NSDate to String
                    
                    let date = currentDay.addingTimeInterval(oneDay*Double(i-(totalDays-1-existenceCheck.dateAct!.indexOffset)))
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "MM/dd"
                    let dateString = dateFormatter.string(from: date)
                    days.append(dateString)
                }
                let dateArr = convertMyDateListToDoubleArray(existenceCheck.dateAct!.values)
                viewController.initSetChartParameters(days,values: dateArr,yLabel:activityName.text!)
            }
        }
        // Configure the view for the selected state
    }
    
    
    
    
    
}
