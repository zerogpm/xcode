//
//  main.swift
//  inoutFunction
//
//  Created by Jian Su on 2016-02-27.
//  Copyright © 2016 Jian Su. All rights reserved.
//

import Foundation

/**
 Parameter will be modified inside the function
 var str is not visiable outside of the function body
**/

func justifyRight(var str:String, totalLength:Int, pad: Character) -> String {
  
  let amountToJustify = totalLength - str.characters.count
  
  if amountToJustify < 1 {
    return str
  }
  
  let addToString = String(pad)
  for _ in 1...amountToJustify {
    str = addToString + str
  }
  
  return str
}

let originalString = "Chris"
let justifiedString = justifyRight(originalString, totalLength: 12, pad: " ")
print("This is String has no padding \(originalString)")
print("This is right justified String \(justifiedString)")


/**
  var will get change outside of it function by using inout parameters
  you cannot pass let parameter since let cannot be modtify
**/

func swapTwoNumber(inout num1:Int, inout _ num2: Int) {
  
  let tempNum1 = num1
  num1 = num2
  num2 = tempNum1
  
}

var number = 35
var anotherNumber = 100

swapTwoNumber(&number, &anotherNumber)

print("This is swap number: \(number) and this is swap another number \(anotherNumber)")












