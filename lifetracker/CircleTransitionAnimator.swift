//
//  CircleTransitionAnimator.swift
//  lifetracker
//
//  Created by Doug Gandle on 12/1/16.
//  Copyright © 2016 Doug Gandle. All rights reserved.
//

import UIKit

class CircleTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning, CAAnimationDelegate {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    weak var transitionContext: UIViewControllerContextTransitioning?
    
    var hasTransitioned = false
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        //1
        self.transitionContext = transitionContext
        
        //2
        let containerView = transitionContext.containerView
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as! DashboardViewController
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as! DashboardViewController
        let button = fromViewController.addNewActivityButton
        
        //3
        containerView.addSubview(toViewController.view)
        
        //4
        let circleMaskPathInitial = UIBezierPath(ovalIn: (button?.frame)!)
        let extremePoint = CGPoint(x: (button?.center.x)! - 0, y: (button?.center.y)! - toViewController.view.bounds.height)
        let radius = sqrt((extremePoint.x*extremePoint.x) + (extremePoint.y*extremePoint.y))
        let circleMaskPathFinal = UIBezierPath(ovalIn: (button?.frame.insetBy(dx: -radius, dy: -radius))!)
        
        //5
        let maskLayer = CAShapeLayer()
        maskLayer.path = circleMaskPathFinal.cgPath
        toViewController.view.layer.mask = maskLayer
        
        //6
        let maskLayerAnimation = CABasicAnimation(keyPath: "path")
        let maskLayerAnimationCurve = CAMediaTimingFunction(controlPoints: 0.1, 0.54, 0.53, 0.99)
        maskLayerAnimation.fromValue = circleMaskPathInitial.cgPath
        maskLayerAnimation.toValue = circleMaskPathFinal.cgPath
        maskLayerAnimation.duration = self.transitionDuration(using: transitionContext)
        maskLayerAnimation.timingFunction = maskLayerAnimationCurve
        maskLayerAnimation.delegate = self
        maskLayer.add(maskLayerAnimation, forKey: "path")
        
        toViewController.addNewActivityButton.rotate45Degrees()
        fromViewController.addNewActivityButton.hasTransitioned = true;
        toViewController.addNewActivityButton.hasTransitioned = true;
//        toViewController.addNewActivityButton.changeButtonColor()
//        fromViewController.addNewActivityButton.changeButtonColor()
        
//        fromViewController.backgroundCircle.moveBackgroundCircle()
        //toViewController.backgroundCircle.moveBackgroundCircle()
        
        
    }

    func animationDidStop(_ anim: CAAnimation!, finished flag: Bool) {
        self.transitionContext?.completeTransition(!self.transitionContext!.transitionWasCancelled)
        self.transitionContext?.viewController(forKey: UITransitionContextViewControllerKey.from)?.view.layer.mask = nil
    }
}
