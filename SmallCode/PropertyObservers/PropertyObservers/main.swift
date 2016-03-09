//
//  main.swift
//  PropertyObservers
//
//  Created by Jian Su on 2016-03-07.
//  Copyright © 2016 ZeroTech. All rights reserved.
//

import Foundation

//Observers observer the chaning value
//Observers are for the setter only
//Observers cannot be let
//willSet called just before value is stored
//didSet called after new value is stored
//Notifies you when a proerty value has changed

class myBank {
  
  var bankBalance: Double = 0.0 {
    willSet {
      print("About to set the bank account to \(newValue)")
    }
    //custome paramater
    didSet(oldbalance) {
      if bankBalance > oldbalance {
          print("Added \(bankBalance - oldbalance)")
      }
    }
  }
  
}

let balance = myBank()
balance.bankBalance = 500
//about to set the bank account to 500

balance.bankBalance = 750
//about to set the bank account to 750

balance.bankBalance = 1100
//about to set the bank account to 1100
//added 350






