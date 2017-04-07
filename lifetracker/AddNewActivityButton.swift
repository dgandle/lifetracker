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
    var backgroundCircleColor = UIColor(red: 58/255, green: 197/255, blue: 105/255, alpha: 1.0)
    var plusColor = UIColor.white
    var hasTransitioned = false;

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: rect)
        backgroundCircleColor.setFill()
        path.fill()
        
        
        //Horizontal Line
        //set up the width and height variables
        //for the horizontal stroke
        let plusHeight: CGFloat = 1.5
        let plusWidth: CGFloat = 15.5
        
        //create the path
        let plusPath = UIBezierPath()
        
        //set the path's line width to the height of the stroke
        plusPath.lineWidth = plusHeight
        
        //move the initial point of the path
        //to the start of the horizontal stroke
        plusPath.move(to: CGPoint(
            x:bounds.width/2 - plusWidth/2,
            y:bounds.height/2))
        
        //add a point to the path at the end of the stroke
        plusPath.addLine(to: CGPoint(
            x:bounds.width/2 + plusWidth/2,
            y:bounds.height/2))
        
        //Vertical Line
        //move to the start of the vertical stroke
        plusPath.move(to: CGPoint(
            x:bounds.width/2,
            y:bounds.height/2 - plusWidth/2))
        
        //add the end point to the vertical stroke
        plusPath.addLine(to: CGPoint(
            x:bounds.width/2,
            y:bounds.height/2 + plusWidth/2))
        
        //set the stroke color
        plusColor.setStroke()
        
        //draw the stroke
        plusPath.stroke()
        
        //rotate if desired
        let radians = degrees * CGFloat(M_PI/180)
        self.transform = CGAffineTransform(rotationAngle: radians);
        
    }
 
    func rotate45Degrees(_ duration: CFTimeInterval = 0.6, completionDelegate: AnyObject? = nil) {
        
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        let rotateAnimationCurve = CAMediaTimingFunction(controlPoints: 0.1, 0.54, 0.53, 0.99)
        
        if (hasTransitioned == false) {
            rotateAnimation.fromValue = 0.0
            rotateAnimation.toValue = CGFloat(M_PI * 0.25)
        } else {
            rotateAnimation.fromValue = CGFloat(M_PI * 0.25)
            rotateAnimation.toValue = CGFloat(M_PI * 0.5)
        }
        rotateAnimation.duration = duration
        rotateAnimation.timingFunction = rotateAnimationCurve
        
        if let delegate: AnyObject = completionDelegate {
            rotateAnimation.delegate = delegate as! CAAnimationDelegate
        }
        self.layer.add(rotateAnimation, forKey: nil)
        
        //Animate Opacity
//        let alphaAnimation = CABasicAnimation(keyPath: "opacity")
//        alphaAnimation.fromValue = 0.0
//        alphaAnimation.toValue = 1.0
//        alphaAnimation.duration = duration
//        self.layer.addAnimation(alphaAnimation, forKey: nil)
        
        //Animate Scale
//        self.transform = CGAffineTransformMakeScale(0.0, 0.0)
//
//        UIView.animateWithDuration(0.3, delay: 0.0, options: [.CurveLinear], animations: { () -> Void in
//            self.transform = CGAffineTransformMakeScale(1, 1)
//        }) { (animationCompleted: Bool) -> Void in
//        }
    }
}
