//
//  main.swift
//  Generics
//
//  Created by Jian Su on 2016-03-12.
//  Copyright © 2016 ZeroTech. All rights reserved.
//

import Foundation

//Generics avoid repeating function with different type
//for example func func somefunc(Value: String) .... func somefunc(Value: Int)
//can be replaced by func genericFunc<T>(value:T)
// non specific data type: Array's Dictionaries

//you can omit pamater name if you put _ inside the pamater
func swapTwoValues<T>(inout value1:T, inout _ value2: T) {
  let templeValue = value1
  value1 = value2
  value2 = templeValue
}

var someValue1 = 10
var someValue2 = 20

swapTwoValues(&someValue1, &someValue2)
print("someValue1 is now \(someValue1), and someValue2 is now \(someValue2)")

//Custom Generic Types can work with Class Struct Enum
struct StackOfObjects<T> {
  var objects = [T]()
  
  mutating func pushOnTheStack(object:T) {
    objects.append(object)
  }
  
  mutating func popOffTheStack() ->T {
    return objects.removeLast()
  }
}

//Generic can be extended 
extension StackOfObjects {
  var topOfStack: T? {
      return objects.isEmpty ? nil : objects[objects.count - 1]
  }
  
  var lastOfStack: T? {
    return objects.isEmpty ? nil : objects.first
  }
}

var myFavor = StackOfObjects<String>()
myFavor.pushOnTheStack("goneWithWind")
myFavor.pushOnTheStack("The Great Wall")
myFavor.pushOnTheStack("EVA")
print(myFavor)
print(myFavor.lastOfStack)





