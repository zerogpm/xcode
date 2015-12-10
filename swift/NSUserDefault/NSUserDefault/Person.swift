//
//  Person.swift
//  NSUserDefault
//
//  Created by Jian Su on 12/1/15.
//  Copyright © 2015 Jian Su. All rights reserved.
//

import Foundation

class Person: NSObject, NSCoding {
    var firstName: String!
    var lastName: String!
    
    init(first:String,last:String) {
        firstName = first
        lastName = last
    }
    
    override init() {
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
        self.firstName = aDecoder.decodeObjectForKey("firstName") as? String
        self.lastName = aDecoder.decodeObjectForKey("lastName") as? String
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.firstName, forKey: "firstName")
        aCoder.encodeObject(self.lastName, forKey: "lastName")
    }
    
}