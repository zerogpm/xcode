//
//  ViewController.swift
//  walkingDead
//
//  Created by Jian Su on 12/23/15.
//  Copyright © 2015 Jian Su. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    let WIDTH: CGFloat = 240
    let HIGHT: CGFloat = 288
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        for var i = 1; i <= 5; i++ {
            let img = UIImage(named: "\(i)")
            let imgView = UIImageView(image: img)
            scrollView.addSubview(imgView)
            imgView.frame = CGRectMake(-WIDTH + (WIDTH * CGFloat(i)), 425, WIDTH, HIGHT)
        }
        
        scrollView.contentSize = CGSizeMake(WIDTH * 5, scrollView.frame.size.height)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

