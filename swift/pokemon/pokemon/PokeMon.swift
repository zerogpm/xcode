//
//  PokeMon.swift
//  pokemon
//
//  Created by Jian Su on 1/3/16.
//  Copyright © 2016 Jian Su. All rights reserved.
//

import Foundation

class PokeMon {
    private var _name:String!
    private var _pokedeId:Int!
    
    var name:String {
        return _name
    }
    
    var pokedeId:Int {
        return _pokedeId
    }
    
    init(name:String, pokededId:Int) {
        self._name = name
        self._pokedeId = pokededId
    }
}