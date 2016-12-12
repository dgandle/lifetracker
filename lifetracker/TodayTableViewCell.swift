//
//  TodayViewCell.swift
//  lifetracker
//
//  Created by Doug Gandle on 11/29/16.
//  Copyright © 2016 Doug Gandle. All rights reserved.
//

import UIKit

class TodayTableViewCell: UITableViewCell {

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var dateFormatter = NSDateFormatter()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        dateFormatter.dateStyle = .LongStyle
        dateLabel.text = "\(dateFormatter.stringFromDate(NSDate()))"
        dateFormatter.dateFormat = "cccc"
        dayLabel.text = "\(dateFormatter.stringFromDate(NSDate()))"
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
