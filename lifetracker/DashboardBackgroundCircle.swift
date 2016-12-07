//
//  DashboardBackgroundCircle.swift
//  lifetracker
//
//  Created by Doug Gandle on 12/3/16.
//  Copyright © 2016 Doug Gandle. All rights reserved.
//

import UIKit

@IBDesignable

class DashboardBackgroundCircle: UIView {

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        let path = UIBezierPath(ovalInRect: rect)
        UIColor( red: 244/255, green: 245/255, blue: 249/255, alpha: 0.41 ).setFill()
        path.fill()
    }
 

}
