//
//  CounterTableViewCell.swift
//  lifetracker
//
//  Created by Doug Gandle on 11/14/16.
//  Copyright © 2016 Doug Gandle. All rights reserved.
//

import UIKit

class CounterTableViewCell: UITableViewCell {

    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var counterValue: UILabel!
    
    @IBOutlet weak var counterStepper: UIStepper!
    var counterStepperValue: Double = -1.0
    
    //declare title variable
    //declare date variable
    //declare value variable
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        var activityValue = getActivityValue(counterLabel.text!, date: NSDate()).numVal!
        
//        counterStepper.value = Double(activityValue)
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func counterStepperValueChanged(sender: UIStepper) {
//        counterValue.text = Int(sender.value).description
        
        
        if (counterStepper.value  > counterStepperValue)
        {
            print("increment")
            counterStepperValue = counterStepperValue + 1.0
            
            incrementNumActivity(counterLabel.text!, date: NSDate(), incVal: 1)
            
            counterValue.text = String(getActivityValue(counterLabel.text!, date: NSDate()).numVal!)
        }
        else
        {
            print("decrement")
            counterStepperValue = counterStepper.value - 1.0
            
            if (getActivityValue(counterLabel.text!, date: NSDate()).numVal! != 0) {
            incrementNumActivity(counterLabel.text!, date: NSDate(), incVal: -1)
            }
            
            counterValue.text = String(getActivityValue(counterLabel.text!, date: NSDate()).numVal!)
        }
        
        
        
        //function to change variable in database
        //incrementNumActivity(counterLabel.text, date: <#T##NSDate#>, incVal: Int(sender.value))
        
    }

    
//    func addValues(title, date, value) {
//        //update title text field
//        //update value text field
//        //update local title, value, date variables
//    }
    
}
