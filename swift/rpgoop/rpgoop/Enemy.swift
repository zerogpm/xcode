//
//  Enemy.swift
//  rpgoop
//
//  Created by Jian Su on 2015-10-25.
//  Copyright © 2015 Jian Su. All rights reserved.
//

import Foundation

class Enemy : Character{
    
    var loot: [String] {
        return ["Rusty Dagger", "Cracked Buckler"]
    }
    
    var type: String {
        return "Grunt"
    }
    
    func dropLoot() -> String? {
        
        if !isAlive {
            let rand = Int(arc4random_uniform(UInt32(loot.count)))
            return loot[rand]
        }
        
        return nil
    }
    
}