//
//  Database.swift
//  lifetracker
//
//  Created by Benjamin Danzig on 11/14/16.
//  Copyright © 2016 Doug Gandle. All rights reserved.
//

import Foundation
import RealmSwift

//Constants
var resetTime = 14400.0 //this is the number of seconds in 4 hours. In the future we will have the reset time set in the settings
var oneDay = 86400.0//number of seconds in a day



//Realm Model Definitions

/*
The My[...] classes are my way of getting around
the fact that List data structures can only contain
objects rather than primitives. Also for Realm, Models
require the use of List's rather than Arrays
*/
class MyBoolean: Object {
    dynamic var value = false;
}
class MyNumber: Object {
    dynamic var value = 0;
}
class MyMood: Object {
    dynamic var value = 0;
}
class MyDate: Object {
    dynamic var value =  Date();
}

/*
The Activity objects represent a single
activity that is being tracked of different data types.
The "name" attribute of every Activity is the name
of the Activity, and the "values" attribute has the 
values of the activity for every day that the Activity
is being tracked.
*/

class Activity: Object{
    dynamic var name = ""
    dynamic var indexOffset = 0
}
class BooleanActivity: Activity {
    var values = List<MyBoolean>()
}
class NumberActivity: Activity {
    var values = List<MyNumber>()
}
class DateActivity: Activity {
    let values = List<MyDate>()
}
class MoodActivity: Activity {
    var values = List<MyMood>()
}

func convertMyNumberListToDoubleArray(_ list: List<MyNumber>)->[Double]{
    var arr: [Double] = []
    for i in 0...list.count-1{
        arr.append(Double(list[i].value))
    }
    return arr
}

func convertMyBooleanListToDoubleArray(_ list: List<MyBoolean>)->[Double]{
    var arr: [Double] = []
    for i in 0...list.count-1{
        if(list[i].value){
          arr.append(1.0)
        }
        else{
            arr.append(0.0)
        }
    }
    return arr
}

func convertMyMoodListToDoubleArray(_ list: List<MyMood>)->[Double]{
    var arr: [Double] = []
    for i in 0...list.count-1{
        arr.append(Double(list[i].value))
    }
    return arr
}

func convertMyDateListToDoubleArray(_ list: List<MyDate>)->[Double]{
    var arr: [Double] = []
    for i in 0...list.count-1{
        let currentTime = list[i].value
        let startOfCurrentDay = realDateToLTDay(currentTime).addingTimeInterval(resetTime)
        let secondsAfterStartOfDay = currentTime.timeIntervalSince(startOfCurrentDay)
        arr.append(secondsAfterStartOfDay)
    }
    return arr
}

class DBInfo: Object{
    dynamic var totalDays = 1//starts at one day because the current day is the first day
    dynamic var currentDay = getCurrentLTDay()
}

/*
 function to add a new activity to the database
 of activities to be tracked. "name" parameter
 is the name of the new activity, and "type"
 is the data type of the new activity, which can
 be either Boolean, Number, Mood, or Date.
*/
func addNewActivity(_ name: String ,type:String){
    //Get the default realm
    let realm = try! Realm()
    
    
    //Make sure the Activity name is unique
    if(nameExistsAlready(name).exists){
        print("The name that was used for the new activity was not unique. Please pick another name.")
        return
    }
    //Switch on the type of activity so that
    //you know what sort of Activity (NumberActivity,
    //BooleanActivity, etc.) to create
    switch type {
    case "Boolean":
        let newActivity = BooleanActivity()
        newActivity.name = name
        //get the totalDays and fill the Activity with that number
        //of empty slots
        let totalDays = realm.objects(DBInfo.self)[0].totalDays
        for _ in 0...totalDays-1 {
            newActivity.values.append(MyBoolean())
        }
        //set the offset to the value of one less than totalDays
        newActivity.indexOffset = totalDays-1
        /*
         Once the newActivity has been created, add it to the
         realm.
         */
        try! realm.write {
            realm.add(newActivity)
        }
    case "Number":
        let newActivity = NumberActivity()
        newActivity.name = name
        //get the totalDays and fill the Activity with that number
        //of empty slots
        let totalDays = realm.objects(DBInfo.self)[0].totalDays
        for _ in 0...totalDays-1 {
            newActivity.values.append(MyNumber())
        }
        //set the offset to the value of one less than totalDays
        newActivity.indexOffset = totalDays-1
        /*
         Once the newActivity has been created, add it to the
         realm.
         */
        try! realm.write {
            realm.add(newActivity)
        }
    case "Mood":
        let newActivity = MoodActivity()
        newActivity.name = name
        //get the totalDays and fill the Activity with that number
        //of empty slots
        let totalDays = realm.objects(DBInfo.self)[0].totalDays
        for _ in 0...totalDays-1 {
            newActivity.values.append(MyMood())
        }
        //set the offset to the value of one less than totalDays
        newActivity.indexOffset = totalDays-1
        /*
         Once the newActivity has been created, add it to the
         realm.
         */
        try! realm.write {
            realm.add(newActivity)
        }
    case "Date":
        let newActivity = DateActivity()
        newActivity.name = name
        //get the totalDays and fill the Activity with that number
        //of empty slots
        let totalDays = realm.objects(DBInfo.self)[0].totalDays
        for _ in 0...totalDays-1 {
            newActivity.values.append(MyDate())
        }
        //set the offset to the value of one less than totalDays
        newActivity.indexOffset = totalDays-1
        /*
         Once the newActivity has been created, add it to the
         realm.
         */
        try! realm.write {
            realm.add(newActivity)
        }
    default:
        //TODO: Throw an error and say that the type is incorrect.
        print("The type", type, "is invalid. Valid types are",
            "be either Boolean, Number, Mood, or Date.")
        return
    }
    
}


/*
 function to remove an activity from the database
 of activities to be tracked. "name" parameter
 is the name of the activity to be deleted.
 */
func removeActivity(_ name: String){
    //Get the default realm
    let realm = try! Realm()
    
    let existenceCheck = nameExistsAlready(name)
    
    //look if the activity exists
    if(!existenceCheck.exists){
        print("The Activity you chose to remove does not exist. Please pick another name.")
        return
    }
    
    if((existenceCheck.boolAct) != nil){
    //remove the activity from the database
    try! realm.write {
        realm.delete(existenceCheck.boolAct!)
    }
    }
    else if((existenceCheck.numAct) != nil){
        //remove the activity from the database
        try! realm.write {
            realm.delete(existenceCheck.numAct!)
        }
    }
    else if((existenceCheck.moodAct) != nil){
        //remove the activity from the database
        try! realm.write {
            realm.delete(existenceCheck.moodAct!)
        }
    }
    else if((existenceCheck.dateAct) != nil){
        //remove the activity from the database
        try! realm.write {
            realm.delete(existenceCheck.dateAct!)
        }
    }
}

/*
 function to get the value of a particular activity for the current day.
 */
func getActivityValue(_ name: String,date: Date) -> (boolVal: Bool?,numVal: Int?,moodVal: Int?,dateVal: Date?){
    //Get the default realm
    let realm = try! Realm()
    
    let existenceCheck = nameExistsAlready(name)
    
    //look if the activity exists
    if(!existenceCheck.exists){
        print("The Activity you chose to remove does not exist. Please pick another name.")
        return (nil,nil,nil,nil)
    }
    //get the totalDays and the currentDay
    let dbInfo = realm.objects(DBInfo.self)[0]
    let totalDays = dbInfo.totalDays
    
    let ltDate = realDateToLTDay(date)
    let currDate = getCurrentLTDay()
    let numSecondsAgo = ltDate.timeIntervalSince(currDate)
    let numDaysAgo = Int(floor(numSecondsAgo/oneDay))
    //this means we have picked a date in the future which is impossible
    if(numDaysAgo<0){
        print("The Date you have chosen doesn't have a value. You have gone too far in the future.")
    }
    if(existenceCheck.boolAct != nil){
        //if we have gone back too far
        if(totalDays-existenceCheck.boolAct!.indexOffset<=numDaysAgo){
           print("The date you have chosen doesn't have a value. You have gone too far in the past.")
           return (nil,nil,nil,nil)
        }
        return (existenceCheck.boolAct!.values[totalDays-1-numDaysAgo].value,nil,nil,nil)
    }
    else if(existenceCheck.numAct != nil){
        //if we have gone back too far
        if(totalDays-existenceCheck.numAct!.indexOffset<=numDaysAgo){
            print("The date you have chosen doesn't have a value. You have gone too far in the past.")
            return (nil,nil,nil,nil)
        }
        return (nil,existenceCheck.numAct!.values[totalDays-1-numDaysAgo].value,nil,nil)
    }
    else if(existenceCheck.moodAct != nil){
        //if we have gone back too far
        if(totalDays-existenceCheck.moodAct!.indexOffset<=numDaysAgo){
            print("The date you have chosen doesn't have a value. You have gone too far in the past.")
            return (nil,nil,nil,nil)
        }
        return (nil,nil,existenceCheck.moodAct!.values[totalDays-1-numDaysAgo].value,nil)
    }
    else if(existenceCheck.dateAct != nil){
        //if we have gone back too far
        if(totalDays-existenceCheck.dateAct!.indexOffset<=numDaysAgo){
            print("The date you have chosen doesn't have a value. You have gone too far in the past.")
            return (nil,nil,nil,nil)
        }
        return (nil,nil,nil,existenceCheck.dateAct!.values[totalDays-1-numDaysAgo].value)
    }
    else{
        print("Something went wrong with the nameExistsAlready() function. It returned true, but the method didn't return an Activity.")
        return (nil,nil,nil,nil)
    }
    
}

/*
 function to set the value of a particular activity for the current day.
 */
func setActivityValue(_ name: String,date: Date, boolInput: Bool?,numInput: Int?, moodInput: Int?,dateInput: Date?){
    //Get the default realm
    let realm = try! Realm()
    
    let existenceCheck = nameExistsAlready(name)
    
    //look if the activity exists
    if(!existenceCheck.exists){
        print("The Activity you chose to remove does not exist. Please pick another name.")
        return
    }
    //get the totalDays and the currentDay
    let dbInfo = realm.objects(DBInfo.self)[0]
    let totalDays = dbInfo.totalDays
    let currentDay = dbInfo.currentDay
    let tomorrow = currentDay.addingTimeInterval(oneDay)
    
    //one of the inputs should have been entered, and the others
    //will be nil. So find the one input that is non-nil and set 
    //that value to the Activity we are trying to edit.
    if((boolInput) != nil){
        
        //if the date is in the future
        if(date.compare(tomorrow.addingTimeInterval(resetTime))==ComparisonResult.orderedDescending){
            if(!newDayReset()){
                print("The date you have entered is in the future and invalid. Please try another date.")
                return
            }
        }
        let myVal = MyBoolean()
        myVal.value = boolInput!
        //if the date is today
        if(date.compare(currentDay.addingTimeInterval(resetTime))==ComparisonResult.orderedDescending && date.compare(tomorrow.addingTimeInterval(resetTime))==ComparisonResult.orderedAscending){
            try! realm.write {
                existenceCheck.boolAct!.values[totalDays-1] = myVal
            }
        }
        //if the date is a past day
        if(date.compare(currentDay.addingTimeInterval(resetTime))==ComparisonResult.orderedAscending){
            let ltDate = realDateToLTDay(date)
            let currDate = getCurrentLTDay()
            let numSecondsAgo = ltDate.timeIntervalSince(currDate)
            let numDaysAgo = -Int(floor(numSecondsAgo/oneDay))
            //check if the past day was before the first day that we are tracking.
            if(totalDays-1-numDaysAgo<0){
                print("The date you have entered is before the first day we have been tracking activities. Pick a later date.")
                return
            }
            else{
                try! realm.write {
                    existenceCheck.boolAct!.values[totalDays-1-numDaysAgo] = myVal
                    if(totalDays-1-numDaysAgo<existenceCheck.boolAct!.indexOffset){
                        existenceCheck.boolAct!.indexOffset=totalDays-1-numDaysAgo
                    }
                }
            }
            
        }
    }
    else if((numInput) != nil){
        
        //if the date is in the future
        if(date.compare(tomorrow.addingTimeInterval(resetTime))==ComparisonResult.orderedDescending){
            if(!newDayReset()){
                print("The date you have entered is in the future and invalid. Please try another date.")
                return
            }
        }
        let myVal = MyNumber()
        myVal.value = numInput!
        //if the date is today
        if(date.compare(currentDay.addingTimeInterval(resetTime))==ComparisonResult.orderedDescending && date.compare(tomorrow.addingTimeInterval(resetTime))==ComparisonResult.orderedAscending){
            try! realm.write {
                existenceCheck.numAct!.values[totalDays-1] = myVal
            }
        }
        //if the date is a past day
        if(date.compare(currentDay.addingTimeInterval(resetTime))==ComparisonResult.orderedAscending){
            let ltDate = realDateToLTDay(date)
            let currDate = getCurrentLTDay()
            let numSecondsAgo = ltDate.timeIntervalSince(currDate)
            let numDaysAgo = -Int(floor(numSecondsAgo/oneDay))
            //check if the past day was before the first day that we are tracking.
            if(totalDays-1-numDaysAgo<0){
                print("The date you have entered is before the first day we have been tracking activities. Pick a later date.")
                return
            }
            else{
                try! realm.write {
                    existenceCheck.numAct!.values[totalDays-1-numDaysAgo] = myVal
                    if(totalDays-1-numDaysAgo<existenceCheck.numAct!.indexOffset){
                        existenceCheck.numAct!.indexOffset=totalDays-1-numDaysAgo
                    }
                }
            }
            
        }
    }
    else if((moodInput) != nil){
        
        //if the date is in the future
        if(date.compare(tomorrow.addingTimeInterval(resetTime))==ComparisonResult.orderedDescending){
            if(!newDayReset()){
                print("The date you have entered is in the future and invalid. Please try another date.")
                return
            }
        }
        let myVal = MyMood()
        myVal.value = moodInput!
        //if the date is today
        if(date.compare(currentDay.addingTimeInterval(resetTime))==ComparisonResult.orderedDescending && date.compare(tomorrow.addingTimeInterval(resetTime))==ComparisonResult.orderedAscending){
            try! realm.write {
                existenceCheck.moodAct!.values[totalDays-1] = myVal
            }
        }
        //if the date is a past day
        if(date.compare(currentDay.addingTimeInterval(resetTime))==ComparisonResult.orderedAscending){
            let ltDate = realDateToLTDay(date)
            let currDate = getCurrentLTDay()
            let numSecondsAgo = ltDate.timeIntervalSince(currDate)
            let numDaysAgo = -Int(floor(numSecondsAgo/oneDay))
            //check if the past day was before the first day that we are tracking.
            if(totalDays-1-numDaysAgo<0){
                print("The date you have entered is before the first day we have been tracking activities. Pick a later date.")
                return
            }
            else{
                try! realm.write {
                    existenceCheck.moodAct!.values[totalDays-1-numDaysAgo] = myVal
                    if(totalDays-1-numDaysAgo<existenceCheck.boolAct!.indexOffset){
                        existenceCheck.moodAct!.indexOffset=totalDays-1-numDaysAgo
                    }
                }
            }
            
        }
    }
    else if((dateInput) != nil){
        
        //if the date is in the future
        if(date.compare(tomorrow.addingTimeInterval(resetTime))==ComparisonResult.orderedDescending){
            if(!newDayReset()){
                print("The date you have entered is in the future and invalid. Please try another date.")
                return
            }
        }
        let myVal = MyDate()
        myVal.value = dateInput!
        //if the date is today
        if(date.compare(currentDay.addingTimeInterval(resetTime))==ComparisonResult.orderedDescending && date.compare(tomorrow.addingTimeInterval(resetTime))==ComparisonResult.orderedAscending){
            try! realm.write {
                existenceCheck.dateAct!.values[totalDays-1] = myVal
            }
        }
        //if the date is a past day
        if(date.compare(currentDay.addingTimeInterval(resetTime))==ComparisonResult.orderedAscending){
            let ltDate = realDateToLTDay(date)
            let currDate = getCurrentLTDay()
            let numSecondsAgo = ltDate.timeIntervalSince(currDate)
            let numDaysAgo = -Int(floor(numSecondsAgo/oneDay))
            //check if the past day was before the first day that we are tracking.
            if(totalDays-1-numDaysAgo<0){
                print("The date you have entered is before the first day we have been tracking activities. Pick a later date.")
                return
            }
            else{
                try! realm.write {
                    existenceCheck.dateAct!.values[totalDays-1-numDaysAgo] = myVal
                    if(totalDays-1-numDaysAgo<existenceCheck.boolAct!.indexOffset){
                        existenceCheck.dateAct!.indexOffset=totalDays-1-numDaysAgo
                    }
                }
            }
            
        }
    }
}


//increment the value of a number activity for a particular date. "incVal" is the amount by which
//we will increment the current value. If the number is negative, we will decrement the value.
func incrementNumActivity(_ name: String,date: Date,incVal: Int){
    let currentVal = getActivityValue(name, date: date).numVal;
    if(currentVal==nil){
        print("The activity you have chosen has no current value. Please choose another activity or date.")
        return
    }
    setActivityValue(name, date: date, boolInput: nil, numInput: currentVal!+incVal, moodInput: nil, dateInput: nil)
}

func initDB(){
    //Get the default realm
    let realm = try! Realm()
    let dbInfo = DBInfo()
    try! realm.write {
        realm.deleteAll()
        realm.add(dbInfo)
    }
}

func getFirstDayTracked() -> Date{
    //Get the default realm
    let realm = try! Realm()

    //get the totalDays and the currentDay
    let dbInfo = realm.objects(DBInfo.self)[0]
    let totalDays = dbInfo.totalDays
    let currentDay = dbInfo.currentDay
    return currentDay.addingTimeInterval(oneDay*Double(-(totalDays-1)))
}

func getCurrentLTDay() -> Date{
    let currentTime = Date()
    let currDay = Calendar.current.startOfDay(for: currentTime)
    if(currentTime.compare(currDay.addingTimeInterval(resetTime))==ComparisonResult.orderedAscending){
        return currDay.addingTimeInterval(-oneDay)
    }
    else{
        return currDay
    }
}

func realDateToLTDay(_ dateTime: Date) -> Date{
    let date = Calendar.current.startOfDay(for: dateTime)
    if(dateTime.compare(date.addingTimeInterval(resetTime))==ComparisonResult.orderedAscending){
        return date.addingTimeInterval(-oneDay)
    }
    else{
        return date
    }
}

func newDayReset() ->Bool{
    //Get the default realm
    let realm = try! Realm()
    //get the totalDays and the currentDay
    var allDbInfos = realm.objects(DBInfo.self)
    if(allDbInfos.count==0){
        initDB()
        allDbInfos = realm.objects(DBInfo.self)
    }
    let dbInfo = allDbInfos[0]
    let totalDays = dbInfo.totalDays
    let currentDay = dbInfo.currentDay
    let currentLTDay = getCurrentLTDay()
    if(currentLTDay.compare(currentDay)==ComparisonResult.orderedDescending){
        let booleanActs = realm.objects(BooleanActivity.self)
        let numActs = realm.objects(NumberActivity.self)
        let moodActs = realm.objects(MoodActivity.self)
        let dateActs = realm.objects(DateActivity.self)
        try! realm.write {
            for act in booleanActs{
                act.values.append(MyBoolean())
            }
            for act in numActs{
                act.values.append(MyNumber())
            }
            for act in moodActs{
                act.values.append(MyMood())
            }
            for act in dateActs{
                act.values.append(MyDate())
            }
            dbInfo.currentDay = currentLTDay
            dbInfo.totalDays = totalDays+1
        }
        return true
    }
    else{
        return false
    }
    
}


/*
 This function searches through all the activities and checks if 
 the "name" entered in the parameter exists already. This function
 returns a boolean for whether or not an activity with the same name 
 already exists, and it also returns an Activity if an activity with 
 the same name exists, and if it doesn't exist nil is returned along
 with the boolean false.
*/
func nameExistsAlready(_ name: String) -> (exists: Bool,boolAct: BooleanActivity?,numAct: NumberActivity?,moodAct:MoodActivity?,dateAct:DateActivity?){
    //Get the default realm
    let realm = try! Realm()
    
    // Query Realm for all activities with the same name
    // as the activity we are adding
    let predicate = NSPredicate(format: "name = %@", name)
    let booleanMatches = realm.objects(BooleanActivity.self).filter(predicate)
    if(booleanMatches.count>0){
        return (true,booleanMatches[0],nil,nil,nil)
    }
    
    let numMatches = realm.objects(NumberActivity.self).filter(predicate)
    if(numMatches.count>0){
        return (true,nil,numMatches[0],nil,nil)
    }
    
    let moodMatches = realm.objects(MoodActivity.self).filter(predicate)
    if(moodMatches.count>0){
        return (true,nil,nil,moodMatches[0],nil)
    }
    
    let dateMatches = realm.objects(DateActivity.self).filter(predicate)
    if(dateMatches.count>0){
        return (true,nil,nil,nil,dateMatches[0])
    }
    
    return (false,nil,nil,nil,nil)
}
