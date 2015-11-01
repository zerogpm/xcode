//
//  Character.swift
//  rpgoop
//
//  Created by Jian Su on 2015-10-25.
//  Copyright © 2015 Jian Su. All rights reserved.
//

import Foundation

class Character {
    
    private var _hp: Int = 100
    private var _attachPwr: Int = 10
    
    var attackPwr: Int {
        get {
            return _attachPwr
        }
    }
    
    var hp: Int {
        get {
            return _hp
        }
    }
    
    init(startingHp: Int, attackPwr:Int) {
        self._hp = startingHp
        self._attachPwr = attackPwr
    }
    
    var isAlive: Bool {
        get {
            if hp <= 0 {
                return false
            } else {
                return true
            }
        }
    }
    
    func attemptAttack(attakPwr:Int) -> Bool {
        self._hp -= attackPwr
        
        return true
    }
}