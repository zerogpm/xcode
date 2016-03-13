//
//  main.swift
//  TypeCasting
//
//  Created by Jian Su on 2016-03-12.
//  Copyright © 2016 ZeroTech. All rights reserved.
//

import Foundation

class Book {
  var title: String
  init(title:String) {
    self.title = title
  }
}

class Fiction: Book {
  var author: String
  init(title: String, author:String) {
    self.author = author
    super.init(title: title)
  }
}

class Nonfiction: Book {
  var publishedBy: String
  init(title: String, publishedBy:String) {
    self.publishedBy = publishedBy
    super.init(title: title)
  }
}

//BookLiabrary is inferring Type "Book" since Fiction and Nonfiction
// has common super class "Book"
let bookLibrary = [
  Fiction(title: "Moby Dick", author: "Herman Melville"),
  Nonfiction(title: "The Wright Brothers", publishedBy: "Simon and Schuster"),
  Fiction(title: "Hamlet", author: "william Shakespeare"),
  Nonfiction(title: "Walden", publishedBy: "Henry David Thoreau"),
  Nonfiction(title: "Quantum Healing", publishedBy: "Random House")
]

//as For downcasting to another type
//is For checking the type

var fictionCount = 0
var nonfictionCount = 0

for item in bookLibrary {
  if item is Fiction {
    ++fictionCount
  } else if item is Nonfiction {
    ++nonfictionCount
  }
}

print("fciton has number of \(fictionCount), non fction has number of \(nonfictionCount)")

//in order to work with different type of book
//we need to downcasting the type "Book"
//downcasting may fail and we don't know and unsure if downcast will succeed
//so we use as? as optional value, if downcast fail, it will return nil
//we use as! we are sure the downcast is certain to work, it will crash your app if it fails

for item in bookLibrary {
  if let fiction = item as? Fiction {
    print("Fiction: \(fiction.title), Author: \(fiction.author)")
  } else if let nonficiton = item as? Nonfiction {
    print("Nonfiction:\(nonficiton.title), Published by: \(nonficiton.publishedBy)")
  }
}

//AnyObject can be any class object
//Any can be any class object or Int Double String Class Function Clousure Tuple

let bookObjects:[AnyObject] = [
  Fiction(title: "The Da Vinci Code", author: "Dan Brow"),
  Fiction(title: "The Alchemist", author: "Paulo Coelho"),
  Fiction(title: "The Hunger Games", author: "Suzanne Collins")
]

for object in bookObjects {
  let fiction = object as! Fiction
  print("Fiction objects: \(fiction.title) - Author\(fiction.author)")
}

//short handed downcasting
for fiction in bookObjects as! [Fiction] {
  print("short handed downcasting Fiction objects: \(fiction.title) - Author\(fiction.author)")
}

var variousItems = [Any]()

variousItems.append(4)
variousItems.append(24)
variousItems.append(0.0)
variousItems.append(2.0)
variousItems.append(3.14)
variousItems.append("swift")
variousItems.append((2.0, 7.0))
variousItems.append(Fiction(title: "Catch me if you can", author: "no one"))
variousItems.append({(name:String) -> String in "Hello, \(name)"})

print(variousItems)

//value Binding
for items in variousItems {
  switch items {
  case 24 as Int:
    print("An Int value of 24 is in the array and we can now use it in code")
  case 0.0 as Double:
    print("A Double value of 0.0 is in the array and we can use it")
  case let someInt as Int:
    print("An In value of \(someInt) is in the array")
  case let someDouble as Double where someDouble > 0:
    print("A Double value of \(someDouble)")
  case is Double:
    print("Some other double value")
  case let someString as String:
    print("A String value of \(someString)")
  case let(x,y) as (Double, Double):
    print("An (x,y) point at \(x), \(y)")
  case let fiction as Fiction:
    print("A book called \(fiction.title), Author - \(fiction.author)")
  case let stringClosure as String -> String:
    print(stringClosure("John"))
  default:
    print("Default String")
  }
}



