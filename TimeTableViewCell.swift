//
//  TimeTableViewCell.swift
//  lifetracker
//
//  Created by Doug Gandle on 11/14/16.
//  Copyright © 2016 Doug Gandle. All rights reserved.
//

import UIKit

class TimeTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeValue: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var isBeingEdited = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        editButton.layer.borderWidth = 1
        editButton.layer.cornerRadius = 4
        editButton.layer.borderColor = UIColor( red: 58/255, green: 197/255, blue: 105/255, alpha: 1.0 ).CGColor
    }

    @IBAction func editButtonTouchUpInside(sender: AnyObject) {
        if (isBeingEdited == false) {
            datePicker.hidden = false
            timeValue.hidden = true
            editButton.setTitle("DONE", forState: .Normal)
            editButton.layer.backgroundColor = UIColor( red: 58/255, green: 197/255, blue: 105/255, alpha: 1.0 ).CGColor
            editButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            isBeingEdited = true
        } else {
            datePicker.hidden = true
            timeValue.hidden = false
            editButton.setTitle("EDIT", forState: .Normal)
            editButton.layer.backgroundColor = UIColor.whiteColor().CGColor
            editButton.setTitleColor(UIColor( red: 58/255, green: 197/255, blue: 105/255, alpha: 1.0 ), forState: .Normal)
            
            let timeFormatter = NSDateFormatter()
            timeFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
            timeValue.text = timeFormatter.stringFromDate(datePicker.date)
            setActivityValue(timeLabel.text!, date: NSDate(), boolInput: nil, numInput: nil, moodInput: nil, dateInput: datePicker.date)
            
            isBeingEdited = false
        }
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
