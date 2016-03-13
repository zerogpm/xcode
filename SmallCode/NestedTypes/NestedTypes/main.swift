//
//  main.swift
//  NestedTypes
//
//  Created by Jian Su on 2016-03-12.
//  Copyright © 2016 ZeroTech. All rights reserved.
//

import Foundation

//Nested Types swift allow us to put Enum, Struct inside a class
class Email {
  
  enum EmailStatus: String{
    case Read
    case Unread
    case Sent = "Email has been sent!"
    case Recieved
  }
  
  let sender:String
  let recipient:String
  let date:NSDate
  
  var status = EmailStatus.Sent
  var urgent = EmailPriority()
  var important = EmailPriority()
  var notImportant = EmailPriority()
  
  init(sender:String,recipient:String){
    self.sender = sender
    self.recipient = recipient
    self.date = NSDate()
  }
  
  func emailData() -> String {
    return "Sent From: \(sender), Recipient: \(recipient), Time:\(date)"
  }
  
  func EmailState() -> String {
    switch status {
    case .Read:
      return "Email Read!"
    case .Unread:
      return "Email has not been read!"
    case .Sent:
      return status.rawValue
    case .Recieved:
      return "Email has been recieved"
    }
  }
  
  class EmailPriority
  {
    var someSpam = SpamEmail()
    
    class SpamEmail
    {
      enum DeletionTimeForSpam:Int
      {
        case deleteAfter1Day = 1
        case deleteAfter5Days = 5
        case deleteAfter10Days = 10
      }
      
      var delete = DeletionTimeForSpam.deleteAfter5Days
    }
  }
  
}

var myEmail = Email(sender: "Bill gate", recipient: "John Done")
print(myEmail.emailData())
print(myEmail.EmailState())
print(myEmail.important.someSpam.delete.rawValue)
