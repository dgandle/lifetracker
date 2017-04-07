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
        editButton.layer.borderColor = UIColor( red: 58/255, green: 197/255, blue: 105/255, alpha: 1.0 ).cgColor
    }

    @IBAction func editButtonTouchUpInside(_ sender: AnyObject) {
        if (isBeingEdited == false) {
            datePicker.isHidden = false
            timeValue.isHidden = true
            editButton.setTitle("DONE", for: UIControlState())
            editButton.layer.backgroundColor = UIColor( red: 58/255, green: 197/255, blue: 105/255, alpha: 1.0 ).cgColor
            editButton.setTitleColor(UIColor.white, for: UIControlState())
            isBeingEdited = true
        } else {
            datePicker.isHidden = true
            timeValue.isHidden = false
            editButton.setTitle("EDIT", for: UIControlState())
            editButton.layer.backgroundColor = UIColor.white.cgColor
            editButton.setTitleColor(UIColor( red: 58/255, green: 197/255, blue: 105/255, alpha: 1.0 ), for: UIControlState())
            
            let timeFormatter = DateFormatter()
            timeFormatter.timeStyle = DateFormatter.Style.short
            timeValue.text = timeFormatter.string(from: datePicker.date)
            setActivityValue(timeLabel.text!, date: Date(), boolInput: nil, numInput: nil, moodInput: nil, dateInput: datePicker.date)
            
            isBeingEdited = false
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
