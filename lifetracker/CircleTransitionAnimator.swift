//
//  CircleTransitionAnimator.swift
//  lifetracker
//
//  Created by Doug Gandle on 12/1/16.
//  Copyright © 2016 Doug Gandle. All rights reserved.
//

import UIKit

class CircleTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.3
    }
    
    weak var transitionContext: UIViewControllerContextTransitioning?
    
    var hasTransitioned = false
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        //1
        self.transitionContext = transitionContext
        
        //2
        let containerView = transitionContext.containerView()
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! DashboardViewController
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! DashboardViewController
        let button = fromViewController.addNewActivityButton
        
        //3
        containerView!.addSubview(toViewController.view)
        
        //4
        let circleMaskPathInitial = UIBezierPath(ovalInRect: button.frame)
        let extremePoint = CGPoint(x: button.center.x - 0, y: button.center.y - CGRectGetHeight(toViewController.view.bounds))
        let radius = sqrt((extremePoint.x*extremePoint.x) + (extremePoint.y*extremePoint.y))
        let circleMaskPathFinal = UIBezierPath(ovalInRect: CGRectInset(button.frame, -radius, -radius))
        
        //5
        let maskLayer = CAShapeLayer()
        maskLayer.path = circleMaskPathFinal.CGPath
        toViewController.view.layer.mask = maskLayer
        
        //6
        let maskLayerAnimation = CABasicAnimation(keyPath: "path")
        let maskLayerAnimationCurve = CAMediaTimingFunction(controlPoints: 0.1, 0.54, 0.53, 0.99)
        maskLayerAnimation.fromValue = circleMaskPathInitial.CGPath
        maskLayerAnimation.toValue = circleMaskPathFinal.CGPath
        maskLayerAnimation.duration = self.transitionDuration(transitionContext)
        maskLayerAnimation.timingFunction = maskLayerAnimationCurve
        maskLayerAnimation.delegate = self
        maskLayer.addAnimation(maskLayerAnimation, forKey: "path")
        
        toViewController.addNewActivityButton.rotate45Degrees()
        fromViewController.addNewActivityButton.hasTransitioned = true;
        toViewController.addNewActivityButton.hasTransitioned = true;
//        toViewController.addNewActivityButton.changeButtonColor()
//        fromViewController.addNewActivityButton.changeButtonColor()
        
//        fromViewController.backgroundCircle.moveBackgroundCircle()
        //toViewController.backgroundCircle.moveBackgroundCircle()
        
        
    }

    override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        self.transitionContext?.completeTransition(!self.transitionContext!.transitionWasCancelled())
        self.transitionContext?.viewControllerForKey(UITransitionContextFromViewControllerKey)?.view.layer.mask = nil
    }
}
