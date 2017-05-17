//
//  ViewController.swift
//  test
//
//  Created by Admin on 25.04.17.
//  Copyright © 2017 Admintrst. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    var animator: UIDynamicAnimator!
    let gravity = UIGravityBehavior()
    let boundaries = UICollisionBehavior()
    let bounce = UIDynamicItemBehavior()
    let motionManager = CMMotionManager()
    let motionQue = OperationQueue.main
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animator = UIDynamicAnimator(referenceView: self.view)
       // let direction = CGVector(dx: 0.0, dy: 0.2)
       // gravity.gravityDirection = direction
        gravity.magnitude = 5
        boundaries.translatesReferenceBoundsIntoBoundary = true
        bounce.elasticity = 1
        animator.addBehavior(gravity)
        animator.addBehavior(boundaries)
        animator.addBehavior(bounce)
        if motionManager.isAccelerometerAvailable
        {
            motionManager.deviceMotionUpdateInterval = 0.2
            motionManager.startAccelerometerUpdates(to: motionQue, withHandler: {
                motion, error in
                if (error != nil) {
                    NSLog("\(error!)")
                }
                let grav : CMAcceleration = motion!.acceleration;
                
                var x = CGFloat(grav.x);
                var y = CGFloat(grav.y);
                
                let orientation = UIApplication.shared.statusBarOrientation;
                
                if orientation == .landscapeLeft {
                    let t = x
                    x = 0 - y
                    y = t
                } else if orientation == .landscapeRight {
                    let t = x
                    x = y
                    y = 0 - t
                } else if orientation == .portraitUpsideDown {
                    x *= -1
                    y *= -1
                }
                
                let v = CGVector(dx: x,dy: 0 - y);
                self.gravity.gravityDirection = v;

            })
        }
                // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onTap(_ sender: UITapGestureRecognizer)
    {
        let location = sender.location(in: self.view)
        let o = MyView(frame: CGRect(x: location.x - 50, y: location.y - 50, width: 100, height: 100))
        o.parentController = self
        let panGesture = UIPanGestureRecognizer(target: o, action: #selector(o.onPan(_:)))
        let pinchGesture = UIPinchGestureRecognizer(target: o, action: #selector(o.onPinch(_:)))
        let rotationGesture = UIRotationGestureRecognizer(target: o, action: #selector(o.onRotation(_:)))
        self.view.addSubview(o)
        gravity.addItem(o)
        boundaries.addItem(o)
        bounce.addItem(o)
        o.addGestureRecognizer(panGesture)
        o.addGestureRecognizer(pinchGesture)
        o.addGestureRecognizer(rotationGesture)
        
    }
    

}

