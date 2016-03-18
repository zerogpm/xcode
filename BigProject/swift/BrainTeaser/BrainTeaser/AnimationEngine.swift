//
//  AnimationEngine.swift
//  BrainTeaser
//
//  Created by Jian Su on 2016-03-16.
//  Copyright © 2016 ZeroTech. All rights reserved.
//

import UIKit
import pop

class AnimationEngine {
  
  class var offScreenRightPosition: CGPoint {
    return CGPointMake(UIScreen.mainScreen().bounds.width, CGRectGetMidY(UIScreen.mainScreen().bounds))
  }
  
  class var offScreenLeftPosition:CGPoint {
    return CGPointMake(-UIScreen.mainScreen().bounds.width, CGRectGetMidY(UIScreen.mainScreen().bounds))
  }
  
  class var screenCenterPosition: CGPoint {
    return CGPointMake(CGRectGetMidX(UIScreen.mainScreen().bounds), CGRectGetMidY(UIScreen.mainScreen().bounds))
  }
  
  let ANIM_DELAY:Int64 = 1
  var originalConstants = [CGFloat]()
  var constraints: [NSLayoutConstraint]
  
  init(constraints:[NSLayoutConstraint]) {
    
    for con in constraints {
      originalConstants.append(con.constant)
      con.constant = AnimationEngine.offScreenRightPosition.x
    }
    self.constraints = constraints
  }
  
  func animateOnScreen(delay: Int) {
    
    let time = dispatch_time(DISPATCH_TIME_NOW, Int64(Double(delay) * Double(NSEC_PER_SEC)))
    
    dispatch_after(time, dispatch_get_main_queue()) {
      var index = 0
      repeat {
        let moveAnim = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant)
        moveAnim.toValue = self.originalConstants[index]
        moveAnim.springBounciness = 12
        moveAnim.springSpeed = 12
        
      if (index > 0) {
          moveAnim.dynamicsFriction += 10 + CGFloat(index)
      }
      
        let con = self.constraints[index]
        con.pop_addAnimation(moveAnim, forKey: "moveOnScreen")
        index++
      } while (index < self.constraints.count)
    }
  }
  
}
