//
//  AddNewActivityButton.swift
//  lifetracker
//
//  Created by Doug Gandle on 12/1/16.
//  Copyright © 2016 Doug Gandle. All rights reserved.
//

import UIKit

@IBDesignable

class AddNewActivityButton: UIButton {
    
    var degrees:CGFloat = 0
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        var path = UIBezierPath(ovalInRect: rect)
        UIColor( red: 58/255, green: 197/255, blue: 105/255, alpha: 1.0 ).setFill()
        path.fill()
        
        
        //Horizontal Line
        //set up the width and height variables
        //for the horizontal stroke
        let plusHeight: CGFloat = 1.5
        let plusWidth: CGFloat = 15.5
        
        //create the path
        var plusPath = UIBezierPath()
        
        //set the path's line width to the height of the stroke
        plusPath.lineWidth = plusHeight
        
        //move the initial point of the path
        //to the start of the horizontal stroke
        plusPath.moveToPoint(CGPoint(
            x:bounds.width/2 - plusWidth/2,
            y:bounds.height/2))
        
        //add a point to the path at the end of the stroke
        plusPath.addLineToPoint(CGPoint(
            x:bounds.width/2 + plusWidth/2,
            y:bounds.height/2))
        
        //Vertical Line
        //move to the start of the vertical stroke
        plusPath.moveToPoint(CGPoint(
            x:bounds.width/2,
            y:bounds.height/2 - plusWidth/2))
        
        //add the end point to the vertical stroke
        plusPath.addLineToPoint(CGPoint(
            x:bounds.width/2,
            y:bounds.height/2 + plusWidth/2))
        
        //set the stroke color
        UIColor.whiteColor().setStroke()
        
        //draw the stroke
        plusPath.stroke()
        
        //rotate if desired
        var radians = degrees * CGFloat(M_PI/180)
        self.transform = CGAffineTransformMakeRotation(radians);
        
    }
    
//    func runtimeRotationChange(degrees: CGFloat) {
//        var radians = degrees * CGFloat(M_PI/180)
//        self.transform = CGAffineTransformMakeRotation(radians);
//    }
 
    func rotate45Degrees(duration: CFTimeInterval = 0.6, completionDelegate: AnyObject? = nil) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(M_PI * 0.25)
        rotateAnimation.duration = duration
        
        if let delegate: AnyObject = completionDelegate {
            rotateAnimation.delegate = delegate
        }
        self.layer.addAnimation(rotateAnimation, forKey: nil)
    }
}