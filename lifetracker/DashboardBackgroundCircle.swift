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
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: rect)
        UIColor( red: 244/255, green: 245/255, blue: 249/255, alpha: 0.41 ).setFill()
        path.fill()
    }
 
    func moveBackgroundCircle(_ duration: CFTimeInterval = 0.6, completionDelegate: AnyObject? = nil) {
        
        let moveAnimation = CABasicAnimation(keyPath: "transform.translation.y")
        let moveAnimationCurve = CAMediaTimingFunction(controlPoints: 0.1, 0.54, 0.53, 0.99)
        moveAnimation.fromValue = 0.0
        moveAnimation.toValue = -155.0
        moveAnimation.duration = duration
        moveAnimation.isRemovedOnCompletion = false
        moveAnimation.timingFunction = moveAnimationCurve
        moveAnimation.fillMode = kCAFillModeForwards;
        
        
//        if let _: AnyObject = completionDelegate {
////            moveAnimation.delegate = delegate
//        }
        self.layer.add(moveAnimation, forKey: nil)
        
    }

    
}
