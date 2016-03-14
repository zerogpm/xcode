//
//  main.swift
//  ClosuresOne
//
//  Created by Jian Su on 2016-03-13.
//  Copyright © 2016 ZeroTech. All rights reserved.
//

import Foundation

//Closures is self-contain block of fuctionalies that you can pass around in your code
// {(parameters) -> return type in statements}
// func someFunction({parameters} -> return type in statements)
// var someProperty = {(parameters) -> return type in statements}
// A function is a closure that has a name but cannot capture values
// A nested function is a clousre that has a name and can capture values
// A closure with no name and can capture values

var lastNames = ["Randal", "Cruz", "Harris", "Beckham", "Manning"]


func reverseSort(str1: String, _ str2: String) -> Bool {
  return str1 > str2
}

//Body of closure start with in keyword
let reverseSort = {(str1:String, str2:String) -> Bool in return str1 > str2}

let sortedName = lastNames.sort(reverseSort)
print(sortedName)

//shorthand argument names $0 $1 $2...
let anotherSoredName = lastNames.sort({$0 > $1})
print(anotherSoredName)

//if the closure expression is rather long use the trailing closure expression
//() can be omitted if you want
//A trailing closure will accommodate multiple lines of code
let trailingClosure = lastNames.sort() {
  (str1:String, str2:String) -> Bool in return str1 > str2
}

let digitDictionary = [0:"zero", 1: "One", 2: "two", 3:"Three", 4:"Four",5:"Five",
  6:"Six", 7:"Seven", 8:"Eight", 9:"Nine"]
let numbersArray = [25,8,64,510]

let strings = numbersArray.map {(var number)-> String in
  var output = ""
  
  while number > 0 {
    output = digitDictionary[number % 10]! + output
    number /= 10
  }
  
  return output
}

print(strings)

