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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foodImg.dropTarget = monsterImg
        heartImg.dropTarget = monsterImg
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "ItemDropOnCharacter:", name: "onTargetDropped", object: nil)
    }
    
    func ItemDropOnCharacter(notif: AnyObject) {
        print("It item was drop")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

