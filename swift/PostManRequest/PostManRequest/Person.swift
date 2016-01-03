//
//  Person.swift
//  PostManRequest
//
//  Created by Jian Su on 1/2/16.
//  Copyright © 2016 Jian Su. All rights reserved.
//

import Foundation

class Person {
    private var _name: String!
    private var _heigh: String!
    private var _birthYear: String!
    private var _hairColor: String!
    
    var name: String {
        return _name;
    }
    
    var heigh: String {
        return _heigh
    }
    
    var birthYear: String {
        return _birthYear;
    }
    
    var hairColor: String {
        return _hairColor
    }
    
    init(name:String,heigh:String,birthYear:String,hairColor:String) {
        _name = name
        _heigh = heigh
        _birthYear = birthYear
        _hairColor = hairColor
    }
    
    
}