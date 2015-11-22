//
//  ViewController.swift
//  ac
//
//  Created by Jian Su on 11/21/15.
//  Copyright © 2015 Jian Su. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var RunButtonOutLet: UIButton!
    @IBOutlet weak var Captial: UITextField!
    @IBOutlet weak var Year: UITextField!
    @IBOutlet weak var End: UITextField!
    @IBOutlet weak var Result: UILabel!
    @IBOutlet weak var face: UIImageView!
    @IBOutlet weak var sad: UIImageView!
    
    var CaptialValue:Double?
    var YearValue:Double?
    var EndValue:Double?
    var finalValue = 0.0
    var showValue = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        RunButtonOutLet.layer.cornerRadius = 2.0
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func RunButton(sender: AnyObject) {
        
        
        if ((Captial.text?.isEmpty) == false && (Year.text?.isEmpty) == false && (End.text?.isEmpty) == false) {
            CaptialValue = Double(Captial.text!)
            EndValue = Double(End.text!)
            YearValue = Double(Year.text!)
            finalValue = 100 * (pow(EndValue! / CaptialValue!, 1.0 / YearValue!) - 1.0)
            
            Result.text = "your Return Rate is \(round(10 * finalValue) / 10) %"
            
            if finalValue > 0 {
                face.hidden = false
                sad.hidden = true
            } else {
                face.hidden = true
                sad.hidden = false
            }
            
            self.view.endEditing(true)
            
        } else {
            let alertController = UIAlertController(title: "Warning", message:
                "Fill all the input text please!", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        
        
    }


}

