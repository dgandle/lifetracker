//
//  CounterTableViewCell.swift
//  lifetracker
//
//  Created by Doug Gandle on 11/14/16.
//  Copyright © 2016 Doug Gandle. All rights reserved.
//

import UIKit
import RealmSwift

class CounterTableViewCell: UITableViewCell {

    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var counterValue: UILabel!
    
    @IBOutlet weak var counterStepper: UIStepper!
    var counterStepperValue: Double = -1.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func counterStepperValueChanged(sender: UIStepper) {
        counterValue.text = Int(sender.value).description
        
        setActivityValue(counterLabel.text!, date: NSDate(), boolInput: nil, numInput: Int(sender.value), moodInput: nil, dateInput: nil)
    }
}
