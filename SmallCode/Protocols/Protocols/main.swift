//
//  main.swift
//  Protocols
//
//  Created by Jian Su on 2016-03-07.
//  Copyright © 2016 ZeroTech. All rights reserved.
//

import Foundation

//Protocols is a set rules which Class, Struct, Enum can conform to
//Class conform protocol must conform its fuctions, if you set the function optinal
//then you need to provide implementation
//Uppercase for all Types
//add @objc for optional func, this way some class doesn't have be conform with protocal
//@objc is not required for enum or struct TYPE, only for classes
//var instanceProperty:Int {get set} //read-write
//var static var typeProperty:String {get} //readOnly
//Property must be var

@objc protocol Palindrome {
  optional func palindromeCheck(workd:String) -> Bool
  
  var numberOfWords:Int {get} //readOnly
  var numberOfCharacters:Int {get set} //read-write
  
  //Typed property by using static
  //Belongs to the FunWithWord Type not to the palindromeOrNor instance
  static var longestPalindrome:String {get} //readOnly
}


class FunWithWords:  Palindrome {
  func oxymorons() {
    print("I find it SERIOUSLY FUNNY that is simple impossible to find an EXACT COPY of the class syllabus,I'll try asking one of the PAID VOLUNTEERS at library")
  }
  @objc func palindromeCheck(word: String) -> Bool {
    var reverseString = ""
    for character in word.characters {
      reverseString = String(character) + reverseString
    }
    
    return (reverseString.stringByReplacingOccurrencesOfString(" ", withString: "").lowercaseString == word.stringByReplacingOccurrencesOfString(" ", withString: "").lowercaseString)
  }
  
  //optional property, only for classes
  @objc var numberOfWords:Int = 0
  @objc var numberOfCharacters:Int = 0
  @objc static var longestPalindrome:String = "Gateman sees name,garageman sees nametag"
}

var palindromeOrNot = FunWithWords()
print(palindromeOrNot.palindromeCheck("Si well let Dad tell Lewis"))
print(FunWithWords.longestPalindrome)


