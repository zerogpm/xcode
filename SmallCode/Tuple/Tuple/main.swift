//
//  main.swift
//  Tuple
//
//  Created by Jian Su on 2016-03-13.
//  Copyright © 2016 ZeroTech. All rights reserved.
//

import Foundation

//tuple can accpect any type
var  meeting = ("Board Meeting", (NSDate()), true)

var currency = ("US Dollar", 350.00)

//Accessing a tuples values via its index

print(meeting.1)

//Adding and accessing label names to the values
//also can be accessed via index
var moiveTime = (Address:"Richmond liver pool", time:(NSDate()), GoingOrNot:true)
print(moiveTime.GoingOrNot)

//Decomposing a tuple
//The type is inferred
let (currencyType, amount) = currency
print(currencyType)
//you can ignore certain tuple values
let (Address, _ , _) = moiveTime
print(Address)

//using a tuple with a for in loog and dictionary
let businessTrips = ["San Francisco" : 650.00, "Japan":1800.00, "London": 1200.00, "Brazil" : 2200.00, "New York": 450.00]

for (location, tripExpense) in businessTrips {
  print("Location is at \(location) and the cost will be \(tripExpense)")
}

//Tuples with functions
//if we remove ? from the function, we will get an error
//because the return type is Tuples,so we mark it ? in order to return nil
func smallestAndLargest(arrayOfInts:[Int]) -> (small:Int, large:Int)? {
  
  if arrayOfInts.isEmpty {
    return nil
  }
  
  var smallest = arrayOfInts[0]
  var largest = arrayOfInts[0]
  
  for value in arrayOfInts[1..<arrayOfInts.count] {
    if value < smallest {
      smallest = value
    } else if value > largest {
      largest = value
    }
  }
  return (smallest, largest)
}

let myInts = [23,33,1,23,222,31,45,664]
let results = smallestAndLargest(myInts)

if let result = results {
  print("the smallest number in the array is \(results!.small) and the largest is \(results!.large)")
  
  
  let (smallest,biggest) = smallestAndLargest([33,44,22,12,44,67,88,323])!
  print("Another smallest number in this array is \(smallest) , and the largest is \(biggest)")
}


//making the tuple as optional
let emptyArray = [Int]()

if let optionalResults = smallestAndLargest(emptyArray) {
  print("Option smallesr number in the array is \(optionalResults.small) and the biggest is \(optionalResults.large)")
}


