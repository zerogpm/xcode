//
//  main.swift
//  Enumerations
//
//  Created by Jian Su on 2016-03-08.
//  Copyright © 2016 ZeroTech. All rights reserved.
//

import Foundation

//Enumerations define a type for group of related value
//Enum can have init() or extensions, protocols
//No implied default int for each case like other languages
//EX: Pormeranian != 0 as index

enum DogBreed: String {
  
  case Pomeranian
  case Husky
  case Pug
  case Collie = "Large Breed" //Raw Value
  
}

enum Man {
  case superMan (Int,String) // Assoiciated values can now be assigned to this case
  case normalMan (Int, String)
  case randomGuy (Int, String)
}

var whoIsTheMan = Man.randomGuy(100, "random guy!")
//Extrating associate values

switch whoIsTheMan {
  case .superMan(let number, let name):
    print("There is only \(number), and he is \(name)")
  case .normalMan(let number, let name):
    print("There is so many \(name), they are call \(name)")
  case .randomGuy(let number, let name):
    print("sometimes there are some \(name) flying around you but you just don't know how many \(number) of them!")
}

enum StateEnum {
  
  case NewYork, Florida, NewJersey, Maine, California, Texas, Gerorgia
  
}

var largeCanine = DogBreed.Husky
largeCanine = .Collie
print(largeCanine)

//Raw Value can be String Character Int Float Double. Dogbreed:String is Raw Type
print(largeCanine.rawValue)

switch largeCanine {
  case .Pomeranian:
    print("Two pomeranis were able to survivw the sinking of the Titanic")
  case .Husky:
    print("Huskies rarley bark and make poor watchdogs")
  case .Pug:
    print("A group of ougs are called a grumble.")
  case .Collie:
    print("Collies are very loyal dogs")
}

//----------ATM Banking

enum ATMError: ErrorType {
  case invalidSelection
  case updatedBankBalance (addFunds:Double)
  case wrongPinNumber
  case balanceCheck (alert:String)
  case noError(alert:String)
}

var bankBalance = 400.00

func billPay(money:Double) -> ATMError{
  
  if bankBalance < money {
    return ATMError.balanceCheck(alert: "your balance is \(bankBalance - money) overdrawn")
  } else if bankBalance > money {
    return ATMError.balanceCheck(alert: "Your balance is \(bankBalance - money)")
  } else {
    return ATMError.noError(alert: "\(bankBalance - money) $")
  }
  
}

func addFunds(add: Double) -> ATMError {
  return ATMError.updatedBankBalance(addFunds: bankBalance + add)
}

print(billPay(400))
print(addFunds(300))

enum ControlCharacter:Character {
  case Tab = "\t"
  case LineFeed = "\n"
  case CarriageReturn = "\r"
}

let tab = ControlCharacter.Tab.rawValue
let LineFeed = ControlCharacter.Tab.rawValue
let CarriageReturn = ControlCharacter.Tab.rawValue

//Implicitly Assigned Raw Values

enum MovieList: Int {
  case TheGreatWall = 1, NomanHoliday, TheTaleOfTwoCites, GoneWithWind
}

print(MovieList.TheGreatWall.rawValue)

let favoriteMovies = MovieList(rawValue: 3)

if let favoriteMovie = favoriteMovies {
  print(favoriteMovie)
}

let NomanHolidayToFind = 1

if let someMoives = MovieList(rawValue: NomanHolidayToFind) {
  switch someMoives {
  case .NomanHoliday:
    print("Moive NoMan holiday found at position \(NomanHolidayToFind)")
  default:
    print("No Noman Holiday here")
  }
} else {
  print("There is no Noman Holiday at poisition \(NomanHolidayToFind)")
}

//Recursive enums
indirect enum AritheticExpression {
  case Number(Int)
  case Addition(AritheticExpression, AritheticExpression)
  case Mutiplication(AritheticExpression, AritheticExpression)
}

func evaluate(expression: AritheticExpression) -> Int {
  switch expression {
  case .Number(let value):
    return value
  case .Addition(let left, let right):
    return evaluate(left) + evaluate(right)
  case .Mutiplication(let left, let right):
    return evaluate(left) * evaluate(right)
  }
}

let five = AritheticExpression.Number(5)
let four = AritheticExpression.Number(4)
let sum = AritheticExpression.Addition(five, four)
let product = AritheticExpression.Mutiplication(five, four)

//Product = (5 + 4) * 2
let product2 = AritheticExpression.Mutiplication(sum, AritheticExpression.Number(2))

print(evaluate(product2))




