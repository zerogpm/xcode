//
//  ViewController.swift
//  littleMonster
//
//  Created by Jian Su on 11/1/15.
//  Copyright © 2015 Jian Su. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var monsterImg: UIImageView!
    @IBOutlet weak var heartImg: UIImageView!
    @IBOutlet weak var foodImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var imgArray = [UIImage]()
        
        for var i = 1; i < 4; i++ {
            if let img = UIImage(named: "idle\(i)") {
                imgArray.append(img)
            }
        }
        
        monsterImg.animationImages = imgArray
        monsterImg.animationDuration = 0.8
        monsterImg.animationRepeatCount = 0
        monsterImg.startAnimating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

