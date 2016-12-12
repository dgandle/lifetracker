//
//  SelectActivityTypeButton.swift
//  lifetracker
//
//  Created by Doug Gandle on 12/9/16.
//  Copyright © 2016 Doug Gandle. All rights reserved.
//

import UIKit

class SelectActivityTypeButton: UIButton {

    var alternateButton:Array<SelectActivityTypeButton>?
    
    func unselectAlternateButtons(){
        if alternateButton != nil {
            self.selected = true
            
            for aButton:SelectActivityTypeButton in alternateButton! {
                aButton.selected = false
            }
        } else {
            toggleButton()
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        unselectAlternateButtons()
        super.touchesBegan(touches, withEvent: event)
    }
    
    override var highlighted: Bool {
        didSet {
            
            
            if (highlighted) {
                self.setTitleColor(UIColor.whiteColor(), forState: .Normal)
                if (self.titleLabel?.text == "yes/no") {
                    self.setBackgroundImage(UIImage(named: "booleanSelectButtonImage"), forState: .Normal)
                } else if (self.titleLabel?.text == "slider") {
                    self.setBackgroundImage(UIImage(named: "sliderSelectButtonImage"), forState: .Normal)
                } else if (self.titleLabel?.text == "counter") {
                    self.setBackgroundImage(UIImage(named: "counterSelectButtonImage"), forState: .Normal)
                } else if (self.titleLabel?.text == "time") {
                    self.setBackgroundImage(UIImage(named: "timeSelectButtonImage"), forState: .Normal)
                }
            }
            else {
                self.setTitleColor(UIColor( red: 255/255, green: 255/255, blue: 255/255, alpha: 0.7), forState: .Normal)
                if (self.titleLabel?.text == "yes/no") {
                    self.setBackgroundImage(UIImage(named: "booleanSelectButtonImageDark"), forState: .Normal)
                } else if (self.titleLabel?.text == "slider") {
                    self.setBackgroundImage(UIImage(named: "sliderSelectButtonImageDark"), forState: .Normal)
                } else if (self.titleLabel?.text == "counter") {
                    self.setBackgroundImage(UIImage(named: "counterSelectButtonImageDark"), forState: .Normal)
                } else if (self.titleLabel?.text == "time") {
                    self.setBackgroundImage(UIImage(named: "timeSelectButtonImageDark"), forState: .Normal)
                }
            }
            
        }
    }
    
    func toggleButton() {
        self.selected = !selected
    }
    
    override var selected: Bool {
        didSet {
            if selected {
                self.layer.borderColor = UIColor.whiteColor().CGColor
            } else {
                self.layer.borderColor = UIColor.blackColor().CGColor
            }
        }
    }
}
