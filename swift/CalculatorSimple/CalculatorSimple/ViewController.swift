//
//  ViewController.swift
//  CalculatorSimple
//
//  Created by Jian Su on 2015-08-25.
//  Copyright (c) 2015 Jian Su. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var total:Int = 0
    var mode:Int = 0
    var valueString:String! = ""
    var lastButtonWasMode:Bool = false
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func tappedNumber(sender: UIButton) {
        var str:String! = sender.titleLabel!.text
        var num:Int! = str.toInt()
        if(num == 0 && total  == 0) {
            return
        }
        
        if(lastButtonWasMode){
            lastButtonWasMode = false
            valueString = ""
        }
        
        valueString = valueString.stringByAppendingString(str)
        label.text = valueString
        
        if(total == 0) {
            total = valueString.toInt()!
        }
        
    }
    
    @IBAction func tappedPlus(sender: AnyObject) {
        self.MySetMode(1)
    }
    
    @IBAction func tappedMinu(sender: AnyObject) {
        self.MySetMode(-1)
    }
    
    
    @IBAction func tappedMutple(sender: AnyObject) {
    }
    
    
    @IBAction func tappedEqual(sender: AnyObject) {
        if(mode == 0) {
            return
        }
        
        var iNum:Int = valueString.toInt()!
    }
    
    
    @IBAction func tappedClear(sender: AnyObject) {
        total = 0
        mode = 0
        valueString = ""
        label.text = "0"
        lastButtonWasMode = false
    }
    
    func MySetMode(m:Int) {
        if(total == 0) {
            return
        }
        mode = m
        lastButtonWasMode = true
        total = valueString.toInt()!
    }


}

