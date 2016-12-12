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
    
    var isButtonSelected = false
    
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

    
    @IBAction func touchDownNoButton(sender: AnyObject) {
        boolButtonNo.backgroundColor = UIColor( red: 149/255, green: 152/255, blue: 154/255, alpha: 0.125 )
        boolButtonNo.layer.borderColor = UIColor( red: 149/255, green: 152/255, blue: 154/255, alpha: 1.0 ).CGColor
        boolButtonNo.setTitleColor(UIColor( red: 149/255, green: 152/255, blue: 154/255, alpha: 1.0 ), forState: .Normal)
        boolButtonYes.setTitleColor(UIColor( red: 149/255, green: 152/255, blue: 154/255, alpha: 0.25 ), forState: .Normal)
        boolButtonYes.layer.borderColor = UIColor( red: 149/255, green: 152/255, blue: 154/255, alpha: 0.25 ).CGColor
        boolButtonYes.backgroundColor = UIColor.whiteColor()
    }
    
    @IBAction func touchUpInsideNoButton(sender: AnyObject) {
        setActivityValue(booleanLabel.text!, date: NSDate(), boolInput: false, numInput: nil, moodInput: nil, dateInput: nil)
    }
    
    @IBAction func touchUpInsideYesButton(sender: AnyObject) {
        setActivityValue(booleanLabel.text!, date: NSDate(), boolInput: true, numInput: nil, moodInput: nil, dateInput: nil)
    }
    
    @IBAction func touchDownYesButton(sender: AnyObject) {
        boolButtonYes.layer.borderColor = UIColor( red: 58/255, green: 197/255, blue: 105/255, alpha: 1.0 ).CGColor
        boolButtonYes.setTitleColor(UIColor( red: 58/255, green: 197/255, blue: 105/255, alpha: 1.0 ), forState: .Normal)
        boolButtonYes.backgroundColor = UIColor( red: 226/255, green: 247/255, blue: 233/255, alpha: 0.5 )
        boolButtonNo.setTitleColor(UIColor( red: 149/255, green: 152/255, blue: 154/255, alpha: 0.25 ), forState: .Normal)
        boolButtonNo.layer.borderColor = UIColor( red: 149/255, green: 152/255, blue: 154/255, alpha: 0.25 ).CGColor
        boolButtonNo.backgroundColor = UIColor.whiteColor()
        //boolButtonNo.enabled = false
    }
    
    
//    @IBAction func pressNoButton(sender: AnyObject) {
//        setActivityValue(booleanLabel.text!, date: NSDate(), boolInput: false, numInput: nil, moodInput: nil, dateInput: nil)
//        boolButtonYes.layer.borderColor = UIColor( red: 149/255, green: 152/255, blue: 154/255, alpha: 1.0 ).CGColor
//        boolButtonNo.layer.borderColor = UIColor( red: 58/255, green: 197/255, blue: 105/255, alpha: 1.0 ).CGColor
//        boolButtonNo.setTitleColor(UIColor( red: 58/255, green: 197/255, blue: 105/255, alpha: 1.0 ), forState: .Normal)
//        boolButtonYes.setTitleColor(UIColor.blackColor(), forState: .Normal)
//    }
//    
//    @IBAction func pressYesButton(sender: AnyObject) {
//        setActivityValue(booleanLabel.text!, date: NSDate(), boolInput: true, numInput: nil, moodInput: nil, dateInput: nil)
//        boolButtonNo.layer.borderColor = UIColor( red: 149/255, green: 152/255, blue: 154/255, alpha: 1.0 ).CGColor
//        boolButtonYes.layer.borderColor = UIColor( red: 58/255, green: 197/255, blue: 105/255, alpha: 1.0 ).CGColor
//        boolButtonYes.setTitleColor(UIColor( red: 58/255, green: 197/255, blue: 105/255, alpha: 1.0 ), forState: .Normal)
//        boolButtonNo.setTitleColor(UIColor.blackColor(), forState: .Normal)
//    }
}
