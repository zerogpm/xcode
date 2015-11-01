//
//  DevilWizard.swift
//  rpgoop
//
//  Created by Jian Su on 2015-10-26.
//  Copyright © 2015 Jian Su. All rights reserved.
//

import Foundation

class DeilWizard: Enemy{
    
    override var loot:[String] {
         return ["Magic Wand", "Dark Amulet", "Salted Pork"]
    }
    
    override var type: String {
        return "Devil Wizard"
    }
}