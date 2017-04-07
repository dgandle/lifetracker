//
//  NavigationControllerDelegate.swift
//  lifetracker
//
//  Created by Doug Gandle on 12/1/16.
//  Copyright © 2016 Doug Gandle. All rights reserved.
//

import UIKit

class NavigationControllerDelegate: NSObject, UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CircleTransitionAnimator()
    }
    
}
