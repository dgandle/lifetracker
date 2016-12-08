//
//  BooleanTableViewCell.swift
//  lifetracker
//
//  Created by Doug Gandle on 11/14/16.
//  Copyright © 2016 Doug Gandle. All rights reserved.
//

import UIKit

class BooleanTableViewCell: UITableViewCell {

    
    @IBOutlet weak var boolButtonNo: UIButton!
    @IBOutlet weak var boolButtonYes: UIButton!
    
    @IBOutlet weak var booleanLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        boolButtonNo.layer.borderWidth = 1
        boolButtonNo.layer.cornerRadius = 4
        boolButtonNo.layer.borderColor = UIColor( red: 149/255, green: 152/255, blue: 154/255, alpha: 1.0 ).CGColor
        boolButtonYes.layer.borderWidth = 1
        boolButtonYes.layer.cornerRadius = 4
        boolButtonYes.layer.borderColor = UIColor( red: 58/255, green: 197/255, blue: 105/255, alpha: 1.0 ).CGColor
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func pressNoButton(sender: AnyObject) {
        setActivityValue(booleanLabel.text!, date: NSDate(), boolInput: false, numInput: nil, moodInput: nil, dateInput: nil)
        boolButtonYes.layer.borderColor = UIColor( red: 149/255, green: 152/255, blue: 154/255, alpha: 1.0 ).CGColor
        boolButtonNo.layer.borderColor = UIColor( red: 58/255, green: 197/255, blue: 105/255, alpha: 1.0 ).CGColor
        boolButtonNo.setTitleColor(UIColor( red: 58/255, green: 197/255, blue: 105/255, alpha: 1.0 ), forState: .Normal)
        boolButtonYes.setTitleColor(UIColor.blackColor(), forState: .Normal)
    }
    @IBAction func pressYesButton(sender: AnyObject) {
        setActivityValue(booleanLabel.text!, date: NSDate(), boolInput: true, numInput: nil, moodInput: nil, dateInput: nil)
        boolButtonNo.layer.borderColor = UIColor( red: 149/255, green: 152/255, blue: 154/255, alpha: 1.0 ).CGColor
        boolButtonYes.layer.borderColor = UIColor( red: 58/255, green: 197/255, blue: 105/255, alpha: 1.0 ).CGColor
        boolButtonYes.setTitleColor(UIColor( red: 58/255, green: 197/255, blue: 105/255, alpha: 1.0 ), forState: .Normal)
        boolButtonNo.setTitleColor(UIColor.blackColor(), forState: .Normal)
    }
}
