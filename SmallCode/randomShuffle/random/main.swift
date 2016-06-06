//
//  main.swift
//  random
//
//  Created by Jian Su on 6/5/16.
//  Copyright © 2016 Jian Su. All rights reserved.
//

import Foundation

var listOfperson = ["Jack", "Ben", "Peter", "Chao", "Wu", "Steve", "winner", "jojo","San","Ada","smith"]


extension Array
{
  /** Randomizes the order of an array's elements. */
  mutating func shuffle()
  {
    for _ in 0..<10
    {
      sortInPlace { (_,_) in arc4random() < arc4random() }
    }
  }
}

listOfperson.shuffle()
print(listOfperson)


