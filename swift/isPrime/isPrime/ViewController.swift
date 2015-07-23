//
//  ViewController.swift
//  isPrime
//
//  Created by Jian Su on 3/16/15.
//  Copyright (c) 2015 Jian Su. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textValue: UITextField!
    @IBOutlet weak var message: UILabel!
    @IBAction func Prime(sender: AnyObject) {
        
        var textInt = textValue.text.toInt()
        
        if textInt != nil && textInt > 0{
            var unwapperNumber = textInt!
            var isPrime = true
            
            if unwapperNumber == 1 {
                isPrime = false
            }
            
            if unwapperNumber == 0 {
                isPrime = false
            }
            
            if unwapperNumber != 2 && unwapperNumber != 1{
                for var i = 2; i < unwapperNumber; i++ {
                    if unwapperNumber % 2 == 0 {
                        isPrime = false
                    }
                }
            }
            
            if isPrime == true {
                message.text = "\(unwapperNumber) is a prime number!"
                self.textValue.resignFirstResponder()
            } else {
                message.text = "\(unwapperNumber) is not a prime number!"
                self.message.resignFirstResponder()
            }
            
        } else {
            message.text = "Please Enter something"
            textValue.resignFirstResponder()
        }
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

