//
//  MyView.swift
//  test
//
//  Created by Admin on 26.04.17.
//  Copyright © 2017 Admintrst. All rights reserved.
//

import UIKit

class MyView: UIView, UIGestureRecognizerDelegate
{
    private var circle:Bool = false
    
    var parentController:ViewController!
    
    var isCircle:Bool
    {
        get{
            return circle
        }
        set(b){
            if b
            {
                layer.cornerRadius = frame.size.width/2
                clipsToBounds = true
            }
            else
            {
                layer.cornerRadius = 0
                clipsToBounds = false
            }
            circle = b
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        if arc4random_uniform(100) > 50
        {
            isCircle = true
        }
        randomColor()
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
    override var collisionBoundsType: UIDynamicItemCollisionBoundsType
    {
        if isCircle
        {
            return .ellipse
        }
        return .rectangle
    }
    
    func randomColor()
    {
        let r = Float(arc4random_uniform(255))/255.0
        let g = Float(arc4random_uniform(255))/255.0
        let b = Float(arc4random_uniform(255))/255.0
        let a = Float(127 + arc4random_uniform(128))/255.0
        self.backgroundColor = UIColor.init(
            red: CGFloat(r),
            green: CGFloat(g),
            blue: CGFloat(b),
            alpha: CGFloat(a))
    }
    
    var old_distance:CGFloat = 0;
   
    func onPan(_ sender: UIPanGestureRecognizer)
    {
        if (sender.state == .began)
        {
            parentController?.bounce.removeItem(self)
            parentController?.boundaries.removeItem(self)
            parentController?.gravity.removeItem(self)
        }else if (sender.state == .cancelled || sender.state == .ended)
        {
            parentController?.bounce.addItem(self)
            parentController?.boundaries.addItem(self)
            parentController?.gravity.addItem(self)
        }
        else
        {
            let translation = sender.translation(in: self.superview)
        
            if let view = sender.view
            {
                view.center = CGPoint(x:view.center.x + translation.x,
                                  y:view.center.y + translation.y)
            }
            sender.setTranslation(CGPoint.zero, in: self.superview)
        }
    }
   
    func onPinch(_ sender: UIPinchGestureRecognizer)
    {
        if (sender.state == .began)
        {
            parentController?.bounce.removeItem(self)
            parentController?.boundaries.removeItem(self)
            parentController?.gravity.removeItem(self)
        }else if (sender.state == .cancelled || sender.state == .ended)
        {
            //print(self.transform.a)
            self.frame.size.width *= self.transform.a
            self.frame.size.height *= self.transform.d
            self.transform.a = 1
            self.transform.d = 1
            if isCircle
            {
                layer.cornerRadius = frame.size.width/2
                clipsToBounds = true
            }
            parentController?.bounce.addItem(self)
            parentController?.boundaries.addItem(self)
            parentController?.gravity.addItem(self)
            sender.scale = 1
        }
        else
        {
            self.transform = CGAffineTransform(scaleX: sender.scale, y: sender.scale)
            
        }

    }
    
    func onRotation(_ sender: UIRotationGestureRecognizer)
    {
        if (sender.state == .began)
        {
            parentController?.bounce.removeItem(self)
            parentController?.boundaries.removeItem(self)
            parentController?.gravity.removeItem(self)
        }else if (sender.state == .cancelled || sender.state == .ended)
        {
            //print(self.transform.a)
            sender.rotation = 0
            parentController?.bounce.addItem(self)
            parentController?.boundaries.addItem(self)
            parentController?.gravity.addItem(self)
        }
        else
        {
            self.transform = CGAffineTransform(rotationAngle: sender.rotation)
        }

    }
}
