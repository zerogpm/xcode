//
//  MonsterImg.swift
//  littleMonster
//
//  Created by Jian Su on 11/8/15.
//  Copyright © 2015 Jian Su. All rights reserved.
//

import Foundation
import UIKit

class MonsterImg : UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame : frame )
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        playIdelAnimation()
    }
    
    func playIdelAnimation() {
        
        self.image = UIImage(named: "idle1")
        self.animationImages = nil
        
        var imgArray = [UIImage]()
        for var i = 1; i < 4; i++ {
            if let img = UIImage(named: "idle\(i)") {
                imgArray.append(img)
            }
        }
        
        self.animationImages = imgArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 0
        self.startAnimating()

    }
    
    func playDeathAnimations() {
        
        self.image = UIImage(named: "dead5")
        self.animationImages = nil
        
        var imgArray = [UIImage]()
        for var i = 1; i < 5; i++ {
            if let img = UIImage(named: "dead\(i)") {
                imgArray.append(img)
            }
        }
        
        self.animationImages = imgArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 1
        self.startAnimating()
    }
}