//
//  ViewController.swift
//  StopWatchApp
//
//  Created by Jian Su on 3/19/15.
//  Copyright (c) 2015 Jian Su. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var timer = NSTimer()
    var count = 0
    
    func updateTime() {
        count++
        time.text = String(count)
    }

    @IBOutlet weak var time: UILabel!
    @IBAction func pause(sender: AnyObject) {
        timer.invalidate()
    }
    
    @IBAction func stop(sender: AnyObject) {
        timer.invalidate()
        self.count = 0
        time.text = String(count)
    }
    
    @IBAction func play(sender: AnyObject) {
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("updateTime"), userInfo: nil, repeats: true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

