//
//  CustomNavigationAnimationController.swift
//  CustomTransitions
//
//  Created by Joyce Echessa on 3/4/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

import UIKit

final class CustomNavigationAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    var reverse: Bool = false
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.7
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        
        guard let toView = transitionContext.view(forKey: .to) else {
            return
        }
        guard let fromView = transitionContext.view(forKey: .from) else {
            return
        }
        let direction: CGFloat = reverse ? -1 : 1
        let const: CGFloat = -0.005
        
        toView.layer.anchorPoint = CGPoint(x: direction == 1 ? 0 : 1, y: 0.5)
        fromView.layer.anchorPoint = CGPoint(x: direction == 1 ? 1 : 0, y: 0.5)
        
        var viewFromTransform: CATransform3D = CATransform3DMakeRotation(direction * CGFloat(Double.pi / 2), 0.0, 1.0, 0.0)
        var viewToTransform: CATransform3D = CATransform3DMakeRotation(-direction * CGFloat(Double.pi / 2), 0.0, 1.0, 0.0)
        viewFromTransform.m34 = const
        viewToTransform.m34 = const
        
        containerView.transform = CGAffineTransform(translationX: direction * containerView.frame.size.width / 2.0, y: 0)
        toView.layer.transform = viewToTransform
        containerView.addSubview(toView)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            containerView.transform = CGAffineTransform(translationX: -direction * containerView.frame.size.width / 2.0, y: 0)
            fromView.layer.transform = viewFromTransform
            toView.layer.transform = CATransform3DIdentity
        }, completion: {
            finished in
            containerView.transform = .identity
            fromView.layer.transform = CATransform3DIdentity
            toView.layer.transform = CATransform3DIdentity
            fromView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            toView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    
            if (transitionContext.transitionWasCancelled) {
                toView.removeFromSuperview()
            } else {
                fromView.removeFromSuperview()
            }
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
        
    }
    
}


