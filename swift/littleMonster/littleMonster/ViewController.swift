//
//  ViewController.swift
//  littleMonster
//
//  Created by Jian Su on 11/1/15.
//  Copyright © 2015 Jian Su. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var monsterImg: MonsterImg!
    @IBOutlet weak var heartImg: DragImg!
    @IBOutlet weak var foodImg: DragImg!
    @IBOutlet weak var penalty1Img: UIImageView!
    @IBOutlet weak var penalty2Img: UIImageView!
    @IBOutlet weak var penalty3Img: UIImageView!
    
    //partly visiable
    let DIM_ALPHA : CGFloat = 0.2
    //fully visiable
    let OPQAUE : CGFloat = 1.0
    //only has 3 life
    let MAX_PENALTIES = 3
    //check if the monster is happy
    var monsterHappy = false
    
    //UInt hold more value than Int
    var currentItem: UInt32 = 0
    
    var penalties = 0
    //timer for penalty
    var timer : NSTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foodImg.dropTarget = monsterImg
        heartImg.dropTarget = monsterImg
        
        //start at full life
        penalty1Img.alpha = DIM_ALPHA
        penalty2Img.alpha = DIM_ALPHA
        penalty3Img.alpha = DIM_ALPHA
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "itemDroppedOnCharacter:", name: "onTargetDropped", object: nil)
        
        //the golem will lose life start from now set the timer 
        startTimer()
    }
    
    func itemDroppedOnCharacter(notif: AnyObject) {
        monsterHappy = true
        
        startTimer()
        
        foodImg.alpha = DIM_ALPHA
        foodImg.userInteractionEnabled = false
        
        heartImg.alpha = DIM_ALPHA
        heartImg.userInteractionEnabled = false
    }
    
    func startTimer() {
        
        //reset the timer if the moseter is happy
        if timer != nil {
            timer.invalidate()
        }
        
        //every 3 sec will function changeGameState
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "changeGameState", userInfo: nil, repeats: true)
    }
    
    func changeGameState() {
        
        if !monsterHappy {
            
            penalties++
            
            if penalties == 1 {
                
                penalty1Img.alpha = OPQAUE
                penalty2Img.alpha = DIM_ALPHA
                
            } else if penalties == 2 {
                
                penalty2Img.alpha = OPQAUE
                penalty3Img.alpha = DIM_ALPHA
                
            } else if penalties >= 3 {
                
                penalty3Img.alpha = OPQAUE
                
            } else {
                
                penalty1Img.alpha = DIM_ALPHA
                penalty2Img.alpha = DIM_ALPHA
                penalty3Img.alpha = DIM_ALPHA
                
            }
            
            if penalties == MAX_PENALTIES {
                
                gameOver()
                
            }

        }
        
        let rand = arc4random_uniform(2) // random 0 or 1
        
        if rand == 0 {
            foodImg.alpha = DIM_ALPHA
            foodImg.userInteractionEnabled = false
            
            heartImg.alpha = OPQAUE
            heartImg.userInteractionEnabled = true
            
        } else {
            heartImg.alpha = DIM_ALPHA
            foodImg.userInteractionEnabled = false
            
            foodImg.alpha = OPQAUE
            foodImg.userInteractionEnabled = true
        }
        
        currentItem = rand
        monsterHappy = false
        
    }
    
    func gameOver() {
        
        timer.invalidate()
        monsterImg.playDeathAnimations()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

