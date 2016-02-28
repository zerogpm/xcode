//
//  main.swift
//  NestedFunctions
//
//  Created by Jian Su on 2016-02-28.
//  Copyright © 2016 Jian Su. All rights reserved.
//

import Foundation

/**
 nested function
 
 The backwars will execute first then choose stepforward or stepbackward.
 
 Input value will be assign as backwars:Bool
 
**/

func chooseStepFunction(backwars:Bool) -> (Int) -> Int {
  
  func stepForward(input: Int) -> Int {
    return input + 1
  }
  
  func stepBackward(input: Int) -> Int {
    return input - 1
  }
  
  return backwars ? stepBackward : stepForward
  
}

var currentValue = -4
//if greate than 0
//move nearer to zero now contains the step forward function inside it.. it adds 1
let moveNearerToZero = chooseStepFunction(currentValue > 0)

while currentValue != 0 {
  print("\(currentValue)...")
  currentValue = moveNearerToZero(currentValue)
}

