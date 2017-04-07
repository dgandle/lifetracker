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
            self.isSelected = true
            
            for aButton:SelectActivityTypeButton in alternateButton! {
                aButton.isSelected = false
            }
        } else {
            toggleButton()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        unselectAlternateButtons()
        super.touchesBegan(touches, with: event)
    }
    
    override var isHighlighted: Bool {
        didSet {
            
            
            if (isHighlighted) {
                self.setTitleColor(UIColor.white, for: UIControlState())
                if (self.titleLabel?.text == "yes/no") {
                    self.setBackgroundImage(UIImage(named: "booleanSelectButtonImage"), for: UIControlState())
                } else if (self.titleLabel?.text == "slider") {
                    self.setBackgroundImage(UIImage(named: "sliderSelectButtonImage"), for: UIControlState())
                } else if (self.titleLabel?.text == "counter") {
                    self.setBackgroundImage(UIImage(named: "counterSelectButtonImage"), for: UIControlState())
                } else if (self.titleLabel?.text == "time") {
                    self.setBackgroundImage(UIImage(named: "timeSelectButtonImage"), for: UIControlState())
                }
            }
            else {
                self.setTitleColor(UIColor( red: 255/255, green: 255/255, blue: 255/255, alpha: 0.7), for: UIControlState())
                if (self.titleLabel?.text == "yes/no") {
                    self.setBackgroundImage(UIImage(named: "booleanSelectButtonImageDark"), for: UIControlState())
                } else if (self.titleLabel?.text == "slider") {
                    self.setBackgroundImage(UIImage(named: "sliderSelectButtonImageDark"), for: UIControlState())
                } else if (self.titleLabel?.text == "counter") {
                    self.setBackgroundImage(UIImage(named: "counterSelectButtonImageDark"), for: UIControlState())
                } else if (self.titleLabel?.text == "time") {
                    self.setBackgroundImage(UIImage(named: "timeSelectButtonImageDark"), for: UIControlState())
                }
            }
            
        }
    }
    
    func toggleButton() {
        self.isSelected = !isSelected
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.layer.borderColor = UIColor.white.cgColor
            } else {
                self.layer.borderColor = UIColor.black.cgColor
            }
        }
    }
}
