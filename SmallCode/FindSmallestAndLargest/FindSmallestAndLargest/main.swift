//
//  main.swift
//  FindSmallestAndLargest
//
//  Created by Jian Su on 2016-02-25.
//  Copyright © 2016 Jian Su. All rights reserved.
//

import Foundation

func smallestLargest(arrayOfInts:[Int]) -> (min: Int, max: Int)? {
  
  if arrayOfInts.isEmpty {
    return nil
  }
  
  var min = arrayOfInts[0]
  var max = arrayOfInts[0]
  
  for value in arrayOfInts[1..<arrayOfInts.count] {
    if value < min {
      min = value
    } else if value > max {
      max = value
    }
  }
  
  return (min, max)
  
}

let someArray = [32,32,33,111,335,66]
let finalValue = smallestLargest(someArray)

print("The smallest number is \(finalValue!.min) and the largest number is \(finalValue!.max)")



