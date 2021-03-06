//
//  SliderTableViewCell.swift
//  lifetracker
//
//  Created by Doug Gandle on 11/14/16.
//  Copyright © 2016 Doug Gandle. All rights reserved.
//

import UIKit

class SliderTableViewCell: UITableViewCell {

    @IBOutlet weak var sliderLabel: UILabel!
    @IBOutlet weak var sliderSlider: UISlider!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func sliderValueChanged(_ sender: AnyObject) {
        setActivityValue(sliderLabel.text!, date: Date(), boolInput: nil, numInput: nil, moodInput: Int(sliderSlider.value), dateInput: nil)
    }
}
