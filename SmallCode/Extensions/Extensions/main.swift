//
//  main.swift
//  Extensions
//
//  Created by Jian Su on 2016-03-07.
//  Copyright © 2016 ZeroTech. All rights reserved.
//

import Foundation

extension Int {
  //put the new functionality you want to add t othe type here
  var feetInMile:Int {
    return self * 5280
  }
  
  var inchInMile:Int {
    return self * 63360
  }
}

let marthonInfeet = 26.feetInMile
print("The distance in feet of 26 miles marathos is \(marthonInfeet)")

let marathonInches = 26.inchInMile
print("The distance in inches of 26 miles is \(marathonInches)")

let marathonInMeters = Double(26.feetInMile) / 3.2888
print("A 26 mile marathon is \(marathonInMeters) meters long")



