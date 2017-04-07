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
        boolButtonNo.layer.borderColor = UIColor( red: 149/255, green: 152/255, blue: 154/255, alpha: 1.0 ).cgColor
        boolButtonYes.layer.borderWidth = 1
        boolButtonYes.layer.cornerRadius = 4
        boolButtonYes.layer.borderColor = UIColor( red: 58/255, green: 197/255, blue: 105/255, alpha: 1.0 ).cgColor
        
        if (getActivityValue(booleanLabel.text!, date: Date()).boolVal == true) {
            boolButtonYes.layer.borderColor = UIColor( red: 58/255, green: 197/255, blue: 105/255, alpha: 1.0 ).cgColor
            boolButtonYes.setTitleColor(UIColor( red: 58/255, green: 197/255, blue: 105/255, alpha: 1.0 ), for: UIControlState())
            boolButtonYes.backgroundColor = UIColor( red: 226/255, green: 247/255, blue: 233/255, alpha: 0.5 )
            boolButtonNo.setTitleColor(UIColor( red: 149/255, green: 152/255, blue: 154/255, alpha: 0.25 ), for: UIControlState())
            boolButtonNo.layer.borderColor = UIColor( red: 149/255, green: 152/255, blue: 154/255, alpha: 0.25 ).cgColor
            boolButtonNo.backgroundColor = UIColor.white
        } else if (getActivityValue(booleanLabel.text!, date: Date()).boolVal == false) {
            boolButtonNo.backgroundColor = UIColor( red: 149/255, green: 152/255, blue: 154/255, alpha: 0.125 )
            boolButtonNo.layer.borderColor = UIColor( red: 149/255, green: 152/255, blue: 154/255, alpha: 1.0 ).cgColor
            boolButtonNo.setTitleColor(UIColor( red: 149/255, green: 152/255, blue: 154/255, alpha: 1.0 ), for: UIControlState())
            boolButtonYes.setTitleColor(UIColor( red: 149/255, green: 152/255, blue: 154/255, alpha: 0.25 ), for: UIControlState())
            boolButtonYes.layer.borderColor = UIColor( red: 149/255, green: 152/255, blue: 154/255, alpha: 0.25 ).cgColor
            boolButtonYes.backgroundColor = UIColor.white
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    @IBAction func touchDownNoButton(_ sender: AnyObject) {
        boolButtonNo.backgroundColor = UIColor( red: 149/255, green: 152/255, blue: 154/255, alpha: 0.125 )
        boolButtonNo.layer.borderColor = UIColor( red: 149/255, green: 152/255, blue: 154/255, alpha: 1.0 ).cgColor
        boolButtonNo.setTitleColor(UIColor( red: 149/255, green: 152/255, blue: 154/255, alpha: 1.0 ), for: UIControlState())
        boolButtonYes.setTitleColor(UIColor( red: 149/255, green: 152/255, blue: 154/255, alpha: 0.25 ), for: UIControlState())
        boolButtonYes.layer.borderColor = UIColor( red: 149/255, green: 152/255, blue: 154/255, alpha: 0.25 ).cgColor
        boolButtonYes.backgroundColor = UIColor.white
    }
    
    @IBAction func touchUpInsideNoButton(_ sender: AnyObject) {
        setActivityValue(booleanLabel.text!, date: Date(), boolInput: false, numInput: nil, moodInput: nil, dateInput: nil)
    }
    
    @IBAction func touchUpInsideYesButton(_ sender: AnyObject) {
        setActivityValue(booleanLabel.text!, date: Date(), boolInput: true, numInput: nil, moodInput: nil, dateInput: nil)
    }
    
    @IBAction func touchDownYesButton(_ sender: AnyObject) {
        boolButtonYes.layer.borderColor = UIColor( red: 58/255, green: 197/255, blue: 105/255, alpha: 1.0 ).cgColor
        boolButtonYes.setTitleColor(UIColor( red: 58/255, green: 197/255, blue: 105/255, alpha: 1.0 ), for: UIControlState())
        boolButtonYes.backgroundColor = UIColor( red: 226/255, green: 247/255, blue: 233/255, alpha: 0.5 )
        boolButtonNo.setTitleColor(UIColor( red: 149/255, green: 152/255, blue: 154/255, alpha: 0.25 ), for: UIControlState())
        boolButtonNo.layer.borderColor = UIColor( red: 149/255, green: 152/255, blue: 154/255, alpha: 0.25 ).cgColor
        boolButtonNo.backgroundColor = UIColor.white
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
