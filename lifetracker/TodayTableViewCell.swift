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
    
    var dateFormatter = DateFormatter()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        dateFormatter.dateStyle = .long
        dateLabel.text = "\(dateFormatter.string(from: Date()))"
        dateFormatter.dateFormat = "cccc"
        dayLabel.text = "\(dateFormatter.string(from: Date()))"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
